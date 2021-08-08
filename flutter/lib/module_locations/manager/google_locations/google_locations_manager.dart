import 'package:inject/inject.dart';
import 'package:tourists/module_locations/repository/google_location/google_location_repository.dart';
import 'package:tourists/module_locations/response/google_locations/google_location_details_response.dart';
import 'package:tourists/module_locations/response/google_locations/google_locations.dart';
import 'package:tourists/module_locations/response/location_list/location_list_response.dart';

@provide
class GoogleLocationsManager {
  final GoogleLocationRepository _repository;
  GoogleLocationsManager(this._repository);

  Future<String> getKey() => _repository.getMapKey();

  Future<GoogleLocationsResponse> getPredictions(String key, String query) =>
      _repository.getPredictions(query, key);

  Future<GoogleLocationDetailsResponse> getPlaceDetails(
          String key, String locationId) =>
      _repository.getPlaceDetails(key, locationId);
  Future<LocationListResponse> getPlaces(String search) =>
      _repository.getPlaces(search);
}
