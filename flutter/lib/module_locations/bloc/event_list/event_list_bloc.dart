import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_comment/manager/comment/comment_service.dart';
import 'package:tourists/module_comment/request/create_comments/create_comments.dart';
import 'package:tourists/module_comment/response/create_comment/create_comment_response.dart';
import 'package:tourists/module_locations/model/event/event_model.dart';
import 'package:tourists/module_locations/service/event/event_service.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class EventListBloc {
  static const String KEY_FESTIVAL = 'festival';
  static const String KEY_EVENT = 'event';

  static const STATUS_CODE_INIT = 480;
  static const STATUS_CODE_LOAD_SUCCESS = 490;
  static const STATUS_CODE_LOAD_ERROR = 500;
  static const STATUS_CODE_LOADING = 510;

  final EventService _eventService;

  EventListBloc(
      this._eventService);

  final PublishSubject<Pair<int, List<EventModel>>> _eventSubject =
      new PublishSubject<Pair<int, List<EventModel>>>();

  Stream<Pair<int, List<EventModel>>> get eventStream => _eventSubject.stream;

  void getAllEvents() {
    _eventService.getAllEvents().then((value) {
      if (value == null) {
        _eventSubject.add(Pair(STATUS_CODE_LOAD_ERROR, null));
      } else {
        _eventSubject.add(Pair(STATUS_CODE_LOAD_SUCCESS, value));
      }
    });
  }
}
