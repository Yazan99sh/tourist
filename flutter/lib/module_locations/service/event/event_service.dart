import 'package:inject/inject.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_locations/manager/event/event_manager.dart';
import 'package:tourists/module_locations/model/event/event_model.dart';
import 'package:tourists/module_locations/response/event_details/event_details.dart';
import 'package:tourists/module_locations/response/event_list/event_list.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class EventService {
  final EventManager _manager;
  final AuthService _authService;
  EventService(this._manager, this._authService);

  Future<List<EventModel>> getAllEvents() async {
    EventListResponse response = await _manager.getAllEvents();

    if (response == null) {
      return [];
    }

    List<EventModel> eventList = [];
    response.data.forEach((element) {
      eventList.add(EventModel(
          id: element.id,
          name: element.name,
          type: element.type,
          subType: element.subType,
          description: element.description,
          date: element.date,
          images: element.images.isNotEmpty
              ? element.images
              : 'https://www.abouther.com/sites/default/files/2018/11/06/main_-_janadriyah_festival.jpg',
          status: element.status,
          commentNumber: element.commentNumber));
    });

    return eventList;
  }

  Future<EventModel> getEvent(String id) async {
    EventResponse response = await _manager.getEvent(id);
    bool isLogged = await _authService.isLoggedIn;

    if (response != null) {
      return EventModel(
          id: response.data.id,
          name: response.data.name,
          type: response.data.type,
          subType: response.data.subType,
          description: response.data.description,
          images: response.data.images.isNotEmpty
              ? response.data.images
              : 'https://www.abouther.com/sites/default/files/2018/11/06/main_-_janadriyah_festival.jpg',
          date: response.data.date,
          status: response.data.status,
          comments: response.data.comments,
          isLogged: isLogged,
          location: response.data.location,
          commentNumber: response.data.commentNumber ?? 0);
    }
    return null;
  }
}
