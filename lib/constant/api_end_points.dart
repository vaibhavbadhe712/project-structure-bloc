
import '../utils/api_base_model/api_base_model.dart';

class ApiEndPoints {
  ApiBaseModel? apiBaseModel;

  ApiEndPoints({this.apiBaseModel}) {
    if (apiBaseModel == null) {}
  }

  late String baseUrl = apiBaseModel?.commerceUrl ?? "";
  late String authBaseUrl = apiBaseModel?.authUrl ?? "";
  late String gatewayBaseUrl = apiBaseModel?.gatewayUrl ?? "";
  late String memberBaseUrl = apiBaseModel?.memberUrl ?? "";
  late String academicUrl = apiBaseModel?.academicUrl ?? "";
  late String imageUploadBaseUrl = apiBaseModel?.imageUploadUrl ?? "";
  late String imageResizeBaseUrl = apiBaseModel?.imageResizeUrl ?? "";
  late String attendanceUrl = apiBaseModel?.attendanceBaseUrl ?? "";

  late String version = apiBaseModel?.version ?? "";
  late int groupId = apiBaseModel?.groupId ?? 1703228300417;
  late int sendOtpGroupId = apiBaseModel?.sendOtpGroupId ?? 1703228300417;
  late String getCategoryByGroupId = "${academicUrl}category/all/getByGroupId/";
  late String getAllGroupsByPhoneNumber = "${authBaseUrl}usergroup/all/";
  late String sendOTP = "$gatewayBaseUrl/authgw/sendOtp";
  late String verifyOTP = "$authBaseUrl/auth/validateOtp";
  late String refreshToken = "${gatewayBaseUrl}authgw/refresh-token";
  late String attendance = "${attendanceUrl}/attendance/attendance/";
  late String feesDetails = "$academicUrl/studentAdmission/getFeesStructure";
  late String activeTrip = "$academicUrl/activetrips";
  late String bustracking = "$academicUrl/activetrips/trip";
  late String getAllNotices = "$academicUrl/noticeBoard/getAllNotice/groupId/";
  late String getAllModules = "${authBaseUrl}menuitem/all/group/";
  late String getUserData = "$attendanceUrl/members/group/";
  late int appId = apiBaseModel?.appId ?? 1698744195060;
}
