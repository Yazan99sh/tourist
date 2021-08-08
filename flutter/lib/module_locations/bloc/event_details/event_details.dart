import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_comment/manager/comment/comment_service.dart';
import 'package:tourists/module_comment/request/create_comments/create_comments.dart';
import 'package:tourists/module_comment/response/create_comment/create_comment_response.dart';
import 'package:tourists/module_locations/model/event/event_model.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';
import 'package:tourists/module_locations/service/event/event_service.dart';
import 'package:tourists/module_locations/service/location_list/location_list_service.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class EventDetailsBloc {
  static const int STATUS_CODE_INIT = 951;
  static const int STATUS_CODE_LOAD_SUCCESS = 961;
  static const int STATUS_CODE_LOAD_ERROR = 971;

  static const int KEY_STATUS = 152;
  static const int KEY_LOCATION = 162;
  static const int KEY_EVENT = 172;

  final EventService _eventService;
  final LocationListService _locationListService;
  final SharedPreferencesHelper _preferencesHelper;
  final CommentManager _commentManager;
  EventDetailsBloc(this._eventService, this._locationListService,
      this._commentManager, this._preferencesHelper);

  final PublishSubject<Map<int, dynamic>> _eventSubject = new PublishSubject();

  Stream<Map<int, dynamic>> get eventStream => _eventSubject.stream;

  void getEventDetails(String id) async {
    EventModel eventDetailsModel = await this._eventService.getEvent(id);
    if (eventDetailsModel == null) {
      _eventSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
    }

    LocationListItem locationListItem =
        await getLocationByName(eventDetailsModel?.location);

    _eventSubject.add({
      KEY_STATUS: STATUS_CODE_LOAD_SUCCESS,
      KEY_LOCATION: locationListItem,
      KEY_EVENT: eventDetailsModel
    });
  }

  Future<LocationListItem> getLocationByName(String name) async {
    List<LocationListItem> locations =
        await _locationListService.getLocationList();
    LocationListItem activeLocation;

    locations.forEach((element) {
      if (element.name == name) activeLocation = element;
    });

    return activeLocation;
  }

  Future postComment(String commentMsg, var regionId) async {
    String uid = await this._preferencesHelper.getUserUID();
    if (uid == null) {
      return;
    }
    CreateCommentResponse response =
        await this._commentManager.createComment(CreateCommentRequest(
              comment: commentMsg,
              user: uid,
              event: regionId,
            ));
    if (response == null) return;
    return getEventDetails(regionId.toString());
  }
}
