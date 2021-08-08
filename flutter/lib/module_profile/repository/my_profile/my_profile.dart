import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_network/http_client/http_client.dart';
import 'package:tourists/module_profile/request/create_profile.dart';
import 'package:tourists/module_profile/response/profile_list/profile_list_response.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
class MyProfileRepository {
  final TAG = 'MyProfileRepository';
  final _apiClient = HttpClient();
  final _logger = Logger();

  MyProfileRepository();

  Future<ProfileResponse> createTouristProfile(
      CreateProfileRequest profileRequest) async {
    Map<String, dynamic> response;
    try {
      response = await _apiClient.post(
          Urls.getTouristProfileAPI, profileRequest.toJson());
    } catch (e) {
      _logger.info(TAG, '${e.toString()}');
    }
    ;

    try {
      response = await _apiClient.put(
          Urls.getTouristProfileAPI, profileRequest.toJson());
    } catch (e) {
      _logger.info(TAG, '${e.toString()}');
    }
    ;

    return response == null
        ? null
        : ProfileListResponse.fromJson(response).data.last;
  }

  Future<ProfileResponse> createGuideProfile(
      CreateProfileRequest profileRequest) async {
    Map<String, dynamic> response;
    try {
      response =
          await _apiClient.post(Urls.registerGuideAPI, profileRequest.toJson());
    } catch (e) {
      _logger.info(TAG, '${e.toString()}');
    }

    try {
      response =
          await _apiClient.put(Urls.registerGuideAPI, profileRequest.toJson());
    } catch (e) {
      _logger.info(TAG, '${e.toString()}');
    }

    return response == null
        ? null
        : ProfileListResponse.fromJson(response).data.last;
  }

  Future<ProfileResponse> getTouristProfile(String userId) async {
    Map<String, dynamic> response =
        await _apiClient.get(Urls.getTouristProfileAPI + '/$userId');

    if (response == null) return null;

    return ProfileResponse.fromJson(response);
  }

  Future<ProfileResponse> getGuideProfile(String userId) async {
    Map<String, dynamic> response =
        await _apiClient.get(Urls.getGuideProfile + '/$userId');

    if (response == null) return null;

    return ProfileResponse.fromJson(response);
  }
}
