import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_auth/presistance/auth_prefs_helper.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_locations/response/location_list/location_list_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class LocationListRepository {
  final HttpClient _httpClient;
  final AuthService _authService;
  final AuthPrefsHelper _prefsHelper;
  LocationListRepository(
      this._httpClient, this._authService, this._prefsHelper);

  Future<LocationListResponse> getLocationList() async {
    Map response;

    try {
      var token = await _prefsHelper.getToken();
      response = await _httpClient
          .get(Urls.locationList, headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      response = await _httpClient.get(Urls.locationList);
    }

    if (response != null) {
      return LocationListResponse.fromJson(response);
    }

    return null;
  }
}
