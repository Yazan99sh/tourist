import 'package:inject/inject.dart';
import 'package:tourists/module_locations/repository/location_details/location_details_repository.dart';
import 'package:tourists/module_locations/request/create_location_request.dart';
import 'package:tourists/module_locations/response/location_details/location_response.dart';

@provide
class LocationDetailsManager {
  final LocationDetailsRepository _repository;

  LocationDetailsManager(this._repository);

  Future<LocationDetailsResponse> getLocationDetails(String locationId) =>
      this._repository.getLocationDetails(locationId);

  Future<LocationDetailsResponse> createLocationDetails(
          CreateLocationRequest createLocationRequest) =>
      this._repository.createLocationDetails(createLocationRequest);

  Future<LocationDetailsResponse> updateLocationDetails(
      CreateLocationRequest createLocationRequest) =>
      this._repository.updateLocationDetails(createLocationRequest);
}
