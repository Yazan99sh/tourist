import 'package:inject/inject.dart';
import 'package:tourists/module_profile/repository/my_profile/my_profile.dart';
import 'package:tourists/module_profile/request/create_profile.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';

@provide
class MyProfileManager {
  final MyProfileRepository _repository;

  MyProfileManager(this._repository);

  Future<ProfileResponse> getTouristProfile(String userId) =>
      _repository.getTouristProfile(userId);

  Future<ProfileResponse> getGuideProfile(String userId) =>
      _repository.getGuideProfile(userId);

  Future<ProfileResponse> createTouristProfile(
          CreateProfileRequest createProfileRequest) =>
      _repository.createTouristProfile(createProfileRequest);

  Future<ProfileResponse> createGuideProfile(
      CreateProfileRequest createProfileRequest) =>
      _repository.createGuideProfile(createProfileRequest);
}
