import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/service/profile/profile_service.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_error.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_guide_load_success.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_loading.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_save_success.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_tourist_load_success.dart';
import 'package:tourists/module_search/bloc/search_bloc/search_bloc.dart';
import 'package:tourists/module_upload/service/image_upload/image_upload_service.dart';

@provide
class MyProfileStateManager {
  final PublishSubject<EditProfileState> _stateSubject = PublishSubject();

  Stream<EditProfileState> get stateStream => _stateSubject.stream;

  final ImageUploadService _uploadService;
  final ProfileService _myProfileService;
  final AuthService _authService;
  final SearchBloc _searchProvider;

  MyProfileStateManager(
    this._uploadService,
    this._myProfileService,
    this._authService,
    this._searchProvider,
  );

  Future<void> setMyProfile(
      MyProfileScreen screen, ProfileModel profile) async {
    _stateSubject.add(EditProfileStateLoading(screen));
    await _myProfileService.createProfile(profile);
     _stateSubject.add(EditProfileStateSaveSuccess(screen));
  }

  void getMyProfile(MyProfileScreen screen) {
    _authService.userRole.then((role) {
        _myProfileService.getMyProfile().then((profile) {
        if (role == UserRole.ROLE_GUIDE) {
          _stateSubject.add(
                EditProfileStateGuideLoadSuccess(
                  screen,
                  profile,
                  _searchProvider,
                ),
              );
        } else {
          _stateSubject
              .add(EditProfileStateTouristLoadSuccess(screen, profile));
        }
      });
    });
  }

  void upload(MyProfileScreen screen, String imagePath, ProfileModel model) {
    _stateSubject.add(EditProfileStateLoading(screen));
    this._uploadService.uploadImage(imagePath).then((value) {
      if (value == null) {
        _stateSubject.add(
          EditProfileStateError(screen, 'Error Submitting Profile'),
        );
      } else {
        model.image = value;
        print(model.image);
        _authService.userRole.then((value) {
          if (value == UserRole.ROLE_GUIDE) {
            _stateSubject.add(
              EditProfileStateGuideLoadSuccess(screen, model, _searchProvider),
            );
          } else {
            _stateSubject
                .add(EditProfileStateTouristLoadSuccess(screen, model));
          }
        });
      }
    });
  }
}
