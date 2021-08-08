import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_locations/service/location_list/location_list_service.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
@singleton
class LocationListBloc {
  static const TAG = 'LocationListBloc';

  static const STATUS_CODE_INIT = -1;
  static const STATUS_CODE_LOADING = 157;
  static const STATUS_CODE_LOAD_SUCCESS = 167;
  static const STATUS_CODE_LOAD_ERROR = 177;

  static const KEY_STATUS = 'status';
  static const KEY_PAYLOAD = 'payload';

  final LocationListService _locationListService;
  final Logger _logger;

  LocationListBloc(this._locationListService, this._logger);

  final PublishSubject<Map<String, dynamic>> _stateSubject =
      new PublishSubject();

  Stream<Map<String, dynamic>> get stateStream => _stateSubject.stream;

  void requestLocationList() {
    _stateSubject.add({KEY_STATUS: STATUS_CODE_LOADING});
    _locationListService.getLocationList().then((locationList) {
      if (locationList != null) {
        _logger.info(
            TAG, 'Got this many locations ' + locationList.length.toString());
        _stateSubject.add({
          KEY_STATUS: STATUS_CODE_LOAD_SUCCESS,
          KEY_PAYLOAD: locationList,
        });
      } else {
        _stateSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
      }
    });
  }

  void dispose() {
    _stateSubject.close();
  }
}
