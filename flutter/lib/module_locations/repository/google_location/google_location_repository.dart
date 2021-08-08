import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_locations/response/google_locations/google_location_details_response.dart';
import 'package:tourists/module_locations/response/google_locations/google_locations.dart';
import 'package:tourists/module_network/http_client/http_client.dart';
import 'package:tourists/module_locations/response/location_list/location_list_response.dart';
@provide
class GoogleLocationRepository {
  final _client = HttpClient();

  GoogleLocationRepository();

  Future<String> getMapKey() async {
    Map<String, dynamic> response = await _client.get(Urls.mapHelper);
    if (response == null) {
      return null;
    }
    return response == null ? null : response['Data'];
  }

  Future<LocationListResponse> getPlaces(String search) async {
    Map<String, dynamic> response = await _client.get(Urls.searchRegion + '/$search');
    if (response == null) {
      return null;
    }
    return response == null ? null : LocationListResponse.fromJson(response);
  }

  Future<GoogleLocationsResponse> getPredictions(
    String query,
    String key,
  ) async {
    Map<String, dynamic> response =
        await _client.get(Urls.googleAutoComplete, queryParams: {
      'input': query,
      'key': key,
      'language': 'ar',
      'componentRestrictions': {'country': 'ksa'},
    });
    if (response == null) return null;
    return GoogleLocationsResponse.fromJson(response);
  }

  Future<GoogleLocationDetailsResponse> getPlaceDetails(
      String key, String placeId) async {
    Map<String, dynamic> response =
        await _client.get(Urls.googlePlaceDetails, queryParams: {
      'place_id': placeId,
      'key': key,
      'language': 'ar',
      'componentRestrictions': {'country': 'ksa'},
      'fields': 'name,rating,formatted_phone_number,icon,photo',
    });
    if (response == null) return null;
    return GoogleLocationDetailsResponse.fromJson(response);
  }
}
