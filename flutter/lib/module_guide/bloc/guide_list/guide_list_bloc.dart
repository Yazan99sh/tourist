import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_guide/service/guide_list/guide_list.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';
import 'package:tourists/module_guide/ui/states/guide_list_state.dart';
import 'package:tourists/module_guide/ui/states/guide_list_state_load_error.dart';
import 'package:tourists/module_guide/ui/states/guide_list_state_load_success.dart';

@provide
class GuideListBloc {
  static const int STATUS_CODE_INIT = 845;
  static const int STATUS_CODE_LOAD_SUCCESS = 855;
  static const int STATUS_CODE_LOAD_ERROR = 865;

  final GuideListService _guideListService;
  final AuthService _authService;
  GuideListBloc(this._guideListService, this._authService);

  final PublishSubject<GuideListState> _guidesListSubject =
      new PublishSubject();
  Stream<GuideListState> get guidesStream =>
      _guidesListSubject.stream;

  void getAllGuides(GuideListScreen screen) {
    _authService.isLoggedIn.then((loggedId) {
      _guideListService.getAllGuides().then((value) {
        if (value != null) {
          _guidesListSubject.add(GuideListStateLoadSuccess(screen, value, loggedId));
        } else {
          _guidesListSubject.add(GuideListStateLoadError(screen, 'Null Data Error'));
        }
      });
    });
  }

  void sortGuideByNearist() {

  }

  void sortGuideBy() {}
}