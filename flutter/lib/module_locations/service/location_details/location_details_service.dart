import 'package:inject/inject.dart';
import 'package:tourists/module_comment/manager/rate/rate_manager.dart';
import 'package:tourists/module_comment/request/create_rating/create_rating.dart';
import 'package:tourists/module_locations/manager/location_details/location_details.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_locations/request/create_location_request.dart';
import 'package:tourists/module_locations/response/location_details/location_response.dart';
import 'package:tourists/module_locations/service/google_locations/google_locations_service.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class LocationDetailsService {
  final LocationDetailsManager _locationManager;
  final RatingManager _ratingManager;
  final GoogleLocationsService _googleLocationsService;
  final SharedPreferencesHelper _preferencesHelper;

  LocationDetailsService(
    this._locationManager,
    this._ratingManager,
    this._preferencesHelper,
    this._googleLocationsService,
  );

  Future<LocationDetailsModel> getLocationDetails(String locationId) async {
    // Check out DB
    LocationDetailsResponse apiResponse =
        await _locationManager.getLocationDetails(locationId);

    var locationModel = apiResponse?.locationDetails;

    //locationModel ??= await createLocationByGoogleId(locationId);

    if (locationModel == null) {
      // There is a problem in the request. it should be validated and reported
      // on the Dio Level
      return null;
    }

    return locationModel;
  }

  Future<LocationDetailsModel> createLocationByGoogleId(
      String locationId) async {
    // First request the details from google
    var locationDetails =
        await _googleLocationsService.getLocationDetails(locationId);

    var request = CreateLocationRequest();
    request.name = locationDetails.result?.name;
    if (locationDetails.result?.reviews != null) {
      if (locationDetails.result.reviews.isNotEmpty) {
        request.description = locationDetails.result.reviews[0].text;
      }
    }
    request.description ??= request.name;
    request.placeId = locationId;
    request.path = 'asd';
    if (locationDetails.result?.geometry != null) {
      request.location = {
        'lat': locationDetails.result.geometry.location.lat,
        'lng': locationDetails.result.geometry.location.lng,
      };
    }

    var response = await _locationManager.createLocationDetails(request);
    if (response == null) return null;
    return response.locationDetails;
  }

  Future<LocationDetailsModel> updateLocation(
      LocationDetailsModel locationDetails) async {
    var request = CreateLocationRequest();
    request.name = locationDetails.name;
    request.description = locationDetails.description;

    request.placeId = locationDetails.placeId;
    request.path = 'asd';
    request.location = {
      'lat': locationDetails.location?.latitude,
      'lng': locationDetails.location?.longitude,
    };

    var response = await _locationManager.createLocationDetails(request);
    if (response == null) return null;
    return response.locationDetails;
  }

  Future<dynamic> createRate(double rate, String locationId) async {
    String uid = await _preferencesHelper.getUserUID();
    dynamic response = await _ratingManager.createRating(CreateRatingRequest(
        user: uid,
        rate: rate.toInt().toString(),
        region: int.parse(locationId)));

    return response;
  }
}
