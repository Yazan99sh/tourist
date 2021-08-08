import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_forms/user_orders_module/model/request_guide/request_guide.model.dart';
import 'package:tourists/module_forms/user_orders_module/service/request_guide/request_guide.service.dart';
import 'package:tourists/module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form_state_all_mode.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form_state_error.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form_state_guide_mode.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form_state_loading.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form_state_location_mode.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form_state_success.dart';
import 'package:tourists/module_locations/service/location_details/location_details_service.dart';

@provide
class RequestGuideBloc {
  // Services and DI
  final RequestGuideService _requestGuideService;
  final LocationDetailsService _locationDetailsService;

  RequestGuideBloc(this._requestGuideService, this._locationDetailsService);

  final PublishSubject<RequestGuideFormState> _stateStream =
      new PublishSubject();

  Stream<RequestGuideFormState> get guideInfoStream => _stateStream.stream;

  void requestGuide(RequestGuideScreen screen, RequestGuideModel request) {
    _stateStream.add(RequestGuideFormStateLoading(screen));
    _requestGuideService.requestGuide(request).then((value) {
      _stateStream.add(RequestGuideFormStateSuccess(screen));
    });
  }

  void requestInfo(
      RequestGuideScreen screen, String guideId, String locationId) {
    _stateStream.add(RequestGuideFormStateLoading(screen));
    if (locationId != null && guideId != null) {
      Future.wait([
        _requestGuideService.getGuideInfoWithId(guideId),
        _locationDetailsService.getLocationDetails(locationId)
      ]).then((value) {
        _stateStream.add(RequestGuideFormStateAllMode(
          screen,
          value[1],
          value[0],
        ));
      });
    } else if (locationId != null && guideId == null) {
      _locationDetailsService.getLocationDetails(locationId).then((value) {
        _stateStream.add(RequestGuideFormStateLocationMode(screen, value));
      });
    } else if (locationId == null && guideId != null) {
      _requestGuideService.getGuideInfoWithId(guideId).then((value) {
        _stateStream.add(RequestGuideFormStateGuideMode(screen, value));
      });
    } else {
      _stateStream.add(RequestGuideFormStateError(screen, 'Error Loading Arguments!'));
    }
  }
}
