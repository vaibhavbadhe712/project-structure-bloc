import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_project/utils/jwt_model/jwt_model.dart';


class LocalStorageUtils {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();
  static JwtTokeResponseModel get tokenResponseModel => userData();

  static Future<void> saveUserDetails(String token) async {
    await instance.setString("token", token);
  }

  static Future<String?> fetchToken() async {
    final token = instance.getString('token') ?? '';
    if (token.isEmpty) {
      return "";
    }
    return token;
  }

  static JwtTokeResponseModel userData() {
    final token = instance.getString('token') ?? '';
    var userData = JwtDecoder.decode(token);
    var userDecoded = JwtTokeResponseModel.fromJson(userData);
    return userDecoded;
  }

  static Future<void> clear() async {
    await instance.clear();
  }

  static Future<String?> saveGroupId(String groupId) async {
    await instance.setString("groupId", groupId);
    return groupId;
  }

  static Future<String?> fetchGroupId() async {
    final groupId = instance.getString('groupId') ?? '';
    if (groupId.isEmpty) {
      return "";
    }
    return groupId;
  }

  // static Future<String?> saveUserSelectedUserId(
  //     String userSelectedUserId) async {
  //   await instance.setString("userSelectedUserId", userSelectedUserId);
  //   return userSelectedUserId;
  // }

  // static Future<String?> fetchUserSelectedUserId() async {
  //   final userSelectedUserId = instance.getString('userSelectedUserId') ?? '';
  //   if (userSelectedUserId.isEmpty) {
  //     return "";
  //   }
  //   return userSelectedUserId;
  // }
}
