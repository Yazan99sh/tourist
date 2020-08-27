import 'package:inject/inject.dart';
import 'package:tourists/module_authorization/user_authorization_module/repository/profile/profile.repository.dart';
import 'package:tourists/module_authorization/user_authorization_module/request/create_profile/create_profile_body.dart';
import 'package:tourists/module_authorization/user_authorization_module/response/create_profile/create_profile_response.dart';

@provide
class ProfileManager {
  final ProfileRepository _profileRepository;

  ProfileManager(this._profileRepository);

  Future<CreateProfileResponse> getProfile(String uid) {
    return _profileRepository.getProfile(uid);
  }

  Future<CreateProfileResponse> createProfile(CreateProfileBody profileModel) {
    return _profileRepository.createProfile(profileModel);
  }
}
