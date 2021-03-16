import 'package:inject/inject.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';
import 'package:tourists/module_locations/service/location_list/location_list_service.dart';
import 'package:tourists/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/presistance/profile_shared_preferences.dart';
import 'package:tourists/module_profile/request/create_profile.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';

@provide
class ProfileService {
  final MyProfileManager _manager;
  final ProfileSharedPreferencesHelper _preferencesHelper;
  final AuthService _authService;
  final LocationListService _locationListService;

  ProfileService(
    this._manager,
    this._preferencesHelper,
    this._authService,
    this._locationListService,
  );

  Future<bool> hasProfile() async {
    String userImage = await _preferencesHelper.getImage();
    return userImage != null;
  }

  Future<ProfileModel> get profile async {
    var username = await _preferencesHelper.getUsername();
    var image = await _preferencesHelper.getImage();
    return ProfileModel(name: username, image: image);
  }

  Future<ProfileModel> createProfile(ProfileModel profileModel) async {
    String userId = await _authService.userID;
    UserRole role = await _authService.userRole;

    CreateProfileRequest request = CreateProfileRequest(
      userName: profileModel.name,
      image: profileModel.image,
      location: 'Saudi Arabia',
      userID: userId,
    );

    ProfileResponse response;
    if (role == UserRole.ROLE_GUIDE) {
      response = await _manager.createGuideProfile(request);
    } else {
      response = await _manager.createTouristProfile(request);
    }

    if (response == null) return null;

    return getUserProfile(userId);
  }

  Future<ProfileModel> getUserProfile(String userId) async {
    var role = await _authService.userRole;

    ProfileResponse myProfile = await _manager.getUserProfile(userId, role);

    return ProfileModel(
      name: '${myProfile.data.name} ',
      image: '${myProfile.data.image} ',
      locations: [],
      languages: ['en', 'ar'],
    );
  }

  Future<ProfileModel> getMyProfile() async {
    var me = await _authService.userID;
    return getUserProfile(me);
  }
}