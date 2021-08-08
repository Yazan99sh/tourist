import 'package:inject/inject.dart';
import 'package:tourists/module_locations/manager/google_locations/google_locations_manager.dart';
import 'package:tourists/module_locations/response/google_locations/google_location_details_response.dart';
import 'package:tourists/module_locations/service/prefs/location_prefs.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';

@provide
class GoogleLocationsService {
  final GoogleLocationsManager _manager;
  final LocationPreferencesHelper _preferencesHelper;
  GoogleLocationsService(this._manager, this._preferencesHelper);

  /// @returns Locations with Names
  Future<List<LocationListItem>> getPredictions(String query) async {
    var mapsKey = await _preferencesHelper.getKey();
    if (mapsKey == null) {
      var mapsApiKey = await this._manager.getKey();
      await _preferencesHelper.setKey(mapsApiKey);
      mapsKey = mapsApiKey;
    }

    //var response = await _manager.getPredictions(mapsKey, query);
    var response = await _manager.getPlaces(query);
    // var predictions = <String, String>{};
    // response.predictions?.forEach((feature) {
    //   predictions[feature.description] = feature.placeId;
    // });

    //return predictions;
    List<LocationListItem> data = [];
    if (response == null) {
      return data;
    }
    data = response.locationList;
    return data;
  }

  Future<GoogleLocationDetailsResponse> getLocationDetails(
      String locationId) async {
    var mapsKey = await _preferencesHelper.getKey();
    if (mapsKey == null) {
      var mapsApiKey = await this._manager.getKey();
      await _preferencesHelper.setKey(mapsApiKey);
      mapsKey = mapsApiKey;
    }

    return _manager.getPlaceDetails(mapsKey, locationId);
  }
}
