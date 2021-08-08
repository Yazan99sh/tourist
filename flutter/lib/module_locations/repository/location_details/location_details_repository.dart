import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_auth/presistance/auth_prefs_helper.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_locations/request/create_location_request.dart';
import 'package:tourists/module_locations/response/location_details/location_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class LocationDetailsRepository {
  final HttpClient _client;
  final AuthService _authService;
  final AuthPrefsHelper _prefsHelper;
  LocationDetailsRepository(this._client, this._authService, this._prefsHelper);

  Future<LocationDetailsResponse> getLocationDetails(String locationId) async {
    Map response;
    try {
      var token = await _prefsHelper.getToken();
      response = await _client.get(Urls.locationDetails + locationId,
          headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      response = await _client.get(Urls.locationDetails + locationId);
    }
    if (response != null) {
      return new LocationDetailsResponse.fromJson(response);
    } else {
      return null;
    }
  }

  Future<LocationDetailsResponse> createLocationDetails(
      CreateLocationRequest createLocationRequest) async {
    try {
      await _authService.refreshToken();
      var token = await _authService.getToken();
      var response = await _client.post(
        Urls.createLocationDetails,
        createLocationRequest.toJson(),
        headers: {
          'Authorization': 'Beare $token',
        },
      );

      if (response != null) {
        return new LocationDetailsResponse.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<LocationDetailsResponse> updateLocationDetails(
      CreateLocationRequest createLocationRequest) async {
    await _authService.refreshToken();
    var token = await _authService.getToken();

    Map response = await _client.put(
      '${Urls.createLocationDetails}/${createLocationRequest.placeId}',
      createLocationRequest.toJson(),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response != null) {
      return new LocationDetailsResponse.fromJson(response);
    } else {
      return null;
    }
  }
}
