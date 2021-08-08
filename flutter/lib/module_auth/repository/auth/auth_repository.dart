import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/request/login_request/login_request.dart';
import 'package:tourists/module_auth/request/register_request/register_request.dart';
import 'package:tourists/module_auth/response/login_response/login_response.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class AuthRepository {
  final _apiClient = HttpClient();

  AuthRepository();

  Future<bool> createUser(RegisterRequest request) async {
    var result;
    if (request.role == UserRole.ROLE_GUIDE) {
      result = await _apiClient.post(Urls.registerGuideAPI, request.toJson());
    } else {
      result = await _apiClient.post(Urls.registerTouristsAPI, request.toJson());
    }

    return result != null;
  }

  Future<LoginResponse> getToken(LoginRequest loginRequest) async {
    var result = await _apiClient.post(
      Urls.CREATE_TOKEN_API,
      loginRequest.toJson(),
    );

    if (result == null) {
      return null;
    }
    return LoginResponse.fromJson(result);
  }
}
