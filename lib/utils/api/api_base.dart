import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';

import '../preferences/local_perference.dart';

typedef ApiResponseSuccess = Function(dynamic data);
typedef ApiResponseFailure = Function(String error);

const String jsonContentType = 'application/json';

class ApiBase {
  final Dio _client =Dio();
  final Map<String, String> _headers;
  Future _getToken() async {
    token = await LocalStorageUtils.fetchToken();
    // ignore: avoid_print
    print(token);
  }

  String? token = "";

  ApiBase({Map<String, String>? headers})
      : _headers = headers ?? {'Content-Type': jsonContentType};
  Future<void> get(
    String url,
    ApiResponseSuccess onSuccess,
    ApiResponseFailure onFailure, {
    bool? isTokenMandatory = false,
  }) async {
    await _getToken();

    if (isTokenMandatory ?? false) {
      _headers['Authorization'] = token ?? '';
    }
    log("\x1B[32m${"URL -> $url"}\x1B[0m");
    _request(
        (uri) => http.get(uri, headers: _headers), url, onSuccess, onFailure);
  }

Future<void> post(
  String endpoint,
  Map<String, dynamic> payload,
  Function(dynamic) onSuccess,
  Function(dynamic) onError,
) async {
  try {
    final response = await http.post(
      Uri.parse(endpoint),
      body: jsonEncode(payload),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      onSuccess(data);
    } else {
      onError(response.body);
    }
  } catch (error) {
    onError(error);
  }
}
  Future<void> put(
    String url,
    Map<String, dynamic> body,
    ApiResponseSuccess onSuccess,
    ApiResponseFailure onFailure, {
    bool? isTokenMandatory = false,
  }) async {
    await _getToken();
    if (isTokenMandatory ?? false) {
      _headers['Authorization'] = token ?? '';
    }
    log("\x1B[35m${"Payload -> $body"}\x1B[0m");
    _request((uri) => http.put(uri, body: jsonEncode(body), headers: _headers),
        url, onSuccess, onFailure);
  }

 Future<void> delete(
  String url,
  Map<String, dynamic> body,
  ApiResponseSuccess onSuccess,
  ApiResponseFailure onFailure, {
  bool? isTokenMandatory = false,
}) async {
  await _getToken();
  if (isTokenMandatory ?? false) {
    _headers['Authorization'] = token ?? '';
  }
  log('\x1B[32m${"URL -> $url"}\x1B[0m');
  _request((uri) => http.delete(uri, body: jsonEncode(body), headers: _headers),
      url, onSuccess, onFailure);
}
 
  Future dioPutFile(
      {required String? url,
      XFile? uploadFile,
      required int fileLength,
      dynamic data,
      String? contentType}) async {
    Options options = Options(
        contentType: contentType ?? lookupMimeType(uploadFile?.path ?? ""),
        headers: {
          'Accept': "*/*",
          'Content-Length': fileLength,
          'Connection': 'keep-alive',
        });
 
    final response = await _client.put(url ?? "",
        data: data ?? uploadFile?.openRead(),
        options: options, onSendProgress: (val1, val2) {
      log("${val1 / val2 * 100}");
    });
    log("Res ${response.statusCode}");
    if (response.statusCode == 200) {
      log("file upload successfully");
    }
  }
 
 

Future<void> _request(Function requestMethod, String url,
    ApiResponseSuccess onSuccess, ApiResponseFailure onFailure) async {
  try {
    final response = await requestMethod(Uri.parse(url));
    log('\x1B[32m${"URL -> ${response.request?.url}"}\x1B[0m');
    log("URL -> ${response.request?.url}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      onSuccess(jsonDecode(response.body));
    } else {
      final errorResponse = jsonDecode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Failed to load data.';

      switch (response.statusCode) {
        case 400:
          onFailure('Bad request: $errorMessage');
          break;
        case 401:
          onFailure('Unauthorized: $errorMessage');
          break;
        case 403:
          onFailure('Forbidden: $errorMessage');
          break;
        case 404:
          onFailure('Not found: $errorMessage');
          break;
        case 500:
          onFailure('Internal server error: $errorMessage');
          break;
        default:
          onFailure('Failed to load data. Status code: ${response.statusCode}');
          break;
      }
    }
  } catch (e) {
    onFailure('An error occurred: $e');
  }
}

  void addHeader(String key, String value) {
    _headers[key] = value;
  }

  String getHeader(String key) {
    return _headers[key] ?? "";
  }
}
