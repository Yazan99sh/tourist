import 'package:inject/inject.dart';
import 'package:tourists/module_guide/repository/guides/guide_repository.dart';
import 'package:tourists/module_guide/response/guide_response/guides_response.dart';

@provide
class GuidesManager {
  final GuidesRepository _guidesRepository;

  GuidesManager(this._guidesRepository);

  Future<GuidesResponse> getGuidesList() {
    return _guidesRepository.getGuidesList();
  }

  Future<GuidesResponse> getGuidesByLocationId(String locationId) {
    return _guidesRepository.getGuidesByArea(locationId);
  }
}
