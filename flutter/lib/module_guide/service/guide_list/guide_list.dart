import 'package:inject/inject.dart';
import 'package:tourists/module_comment/manager/rate/rate_manager.dart';
import 'package:tourists/module_comment/request/create_rating/create_rating.dart';
import 'package:tourists/module_guide/manager/guides_manager/guides_manager.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/request/filter_guide_list.dart';
import 'package:tourists/module_guide/response/guide_response/guides_response.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class GuideListService {
  final GuidesManager _guidesManager;
  final RatingManager _ratingManager;
  final SharedPreferencesHelper _preferencesHelper;
  GuideListService(
      this._guidesManager, this._preferencesHelper, this._ratingManager);

  Future<List<GuideListItemModel>> getAllGuides() async {
    GuidesResponse response = await _guidesManager.getGuidesList();
    if (response == null) return null;

    var guideList =
        response.data.where((element) => element.regions?.isNotEmpty).toList();
    return guideList;
  }

  Future<List<GuideListItemModel>> getAllGuidesFiltred(
      FilterGuideListRequest request) async {
    GuidesResponse response =
        await _guidesManager.getAllGuidesFiltredList(request);
    if (response == null) return null;
    if (response.noData != null) {
      return [];
    }
    var guideList =
        response.data.where((element) => element.regions?.isNotEmpty).toList();
    return guideList;
  }

  Future<dynamic> createRate(double rate, String guideId) async {
    String uid = await _preferencesHelper.getUserUID();
    dynamic response = await _ratingManager.createRating(CreateRatingRequest(
        user: uid, rate: rate.toInt().toString(), guide: guideId));

    return response;
  }
}
