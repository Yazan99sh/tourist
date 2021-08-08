import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/manager/request_manager/request_guide_manager.dart';
import 'package:tourists/module_forms/user_orders_module/model/request_guide/request_guide.model.dart';
import 'package:tourists/module_forms/user_orders_module/request/request_guide/request_guide.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/service/guide_list/guide_list.dart';
import 'package:tourists/module_orders/response/request_guide_response/request_guide_response.dart';

@provide
class RequestGuideService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GuideListService _guidesService;
  final RequestGuideManager _requestGuideManager;

  RequestGuideService(this._guidesService, this._requestGuideManager);

  Future<bool> requestGuide(RequestGuideModel requestGuide) async {
    User user = await _auth.currentUser;
    if (user == null) {
      return null;
    }

    String uid = user.uid;

    RequestGuideRequest requestObject = RequestGuideRequest(
      touristUserID: uid,
      guidUserID: requestGuide.guideId,
      city: requestGuide.location,
      language: requestGuide.language,
      arriveDate: requestGuide.arrivalDate,
      status: 'pending',
      date: DateTime.now(),
      leaveDate: requestGuide.arrivalDate
          .add(Duration(days: requestGuide.stayingDays)),
      services: requestGuide.services,
    );

    RequestGuideResponse requestResult =
        await _requestGuideManager.requestGuide(requestObject);

    if (requestResult != null) {
      return requestResult.statusCode == '201';
    }

    return null;
  }

  Future<GuideListItemModel> getGuideInfoWithId(String guideId) async {
    List<GuideListItemModel> availableGuides =
        await _guidesService.getAllGuides();

    GuideListItemModel targetGuide;

    availableGuides.forEach((guide) {
      if (guideId == guide.user) targetGuide = guide;
    });

    return targetGuide;
  }
}
