import 'package:inject/inject.dart';
import 'package:tourists/module_locations/manager/location_list/location_list_manager.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';

@provide
class LocationListService {
  final LocationListManager _locationListManager;

  LocationListService(this._locationListManager);

  Future<List<LocationListItem>> getLocationList() async {
    var locations = await _locationListManager.getLocationList();

    if (locations == null) return null;
    var locationResult = <LocationListItem>[];

    locations.forEach((element) {
      if (element.id == null) {
        return;
      }


      element.path ??= <Path>[];
      element.path.map((obj) {
        if (obj.path.contains('http')) {
          obj.path = obj.path.substring(obj.path.lastIndexOf('http'));
        }
        return obj;
      });

      locationResult.add(element);
    });

    return locationResult;
  }
}
