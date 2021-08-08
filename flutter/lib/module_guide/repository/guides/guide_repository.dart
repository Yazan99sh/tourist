import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_guide/request/filter_guide_list.dart';
import 'package:tourists/module_guide/response/guide_response/guides_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class GuidesRepository {
  final HttpClient _client;

  GuidesRepository(this._client);

  Future<GuidesResponse> getGuidesList() async {
    Map response = await _client.get(Urls.guideList);

    if (response != null) {
      return GuidesResponse.fromJson(response);
    }

    return null;
  }
  Future<GuidesResponse> getAllGuidesFiltredList(FilterGuideListRequest request) async {
    Map response = await _client.post(Urls.filterguide,request.toJson());

    if (response != null) {
      return GuidesResponse.fromJson(response);
    }

    return null;
  }

  Future<GuidesResponse> getGuidesByArea(String areaId) async {
    Map response = await _client.get(Urls.guidesByRegion + '/' + areaId);

    if (response != null) {
      return GuidesResponse.fromJson(response);
    }

    return null;
  }
}
