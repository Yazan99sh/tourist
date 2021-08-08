import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_locations/response/event_details/event_details.dart';
import 'package:tourists/module_locations/response/event_list/event_list.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class EventRepository {
  final HttpClient _httpClient;
  EventRepository(this._httpClient);

  Future<EventListResponse> getAllEvents() async {
    Map response = await _httpClient.get(Urls.eventList);

    if (response != null) {
      return EventListResponse.fromJson(response);
    }

    return null;
  }

  Future<EventResponse> getEvent(String id) async {
    Map response = await _httpClient.get(Urls.event + '/' + id);

    if (response != null) {
      return EventResponse.fromJson(response);
    }

    return null;
  }
}
