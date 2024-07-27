import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:startup_project/main.dart';

class PostRepository {
  Future<void> sendOtp(String phoneNumber) async {
    try {
      final response = await http
          .post(
            Uri.parse('${apiEndPoints.sendOTP}'), // Replace with your OTP endpoint
            body: jsonEncode({'phone_number': phoneNumber}),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        // Handle successful response
  
      } else {
        throw Exception('Failed to send OTP');
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('Request timeout');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
