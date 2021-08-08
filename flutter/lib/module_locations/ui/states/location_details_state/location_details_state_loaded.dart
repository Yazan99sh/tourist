import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_comment/ui/widget/comment_list/comment_list.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_locations/ui/screens/location_details/location_details.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';
import 'package:tourists/module_locations/ui/widgets/guides_list/guides_list.dart';
import 'package:flutter/material.dart' as mat;

class LocationDetailsStateLoaded extends LocationDetailsState {
  LocationDetailsModel location;
  List<GuideListItemModel> guides;
  bool isLoggedIn;
  double rate = 0.0;
  LocationDetailsScreenState screenState;
  LocationDetailsStateLoaded(
    this.screenState, {
    this.location,
    this.guides,
    this.isLoggedIn,
  }) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    location.comments ??= <CommentModel>[];
    return Scaffold(
      appBar: AppBar(
        title: Text('${location?.name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getCarousel(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                location.description,
                maxLines: 4,
              ),
            ),
            isLoggedIn
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Text(
                      '${S.of(context).rateThisLocation}',
                      style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    )),
                  )
                : Container(),
            isLoggedIn
                ? Center(
                    child: Directionality(
                      textDirection: mat.TextDirection.ltr,
                      child: SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {
                            if (v > 0.0) {
                              screenState.createRate(
                                  v, location.id.toString(), location.placeId);
                            }
                          },
                          starCount: 5,
                          rating: location.userRating != null
                              ? double.parse(location.userRating)
                              : 0.0,
                          size: 35.0,
                          isReadOnly:
                              double.parse(location.userRating ?? '0.0') > 0.0,
                          color: Color(0xff05F29B),
                          borderColor: Color(0xff05F29B),
                          spacing: 0.0),
                    ),
                  )
                : Container(),
            guides.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Container(
                      width: double.maxFinite,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${S.of(context).guides}',
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      )),
                    ),
                  )
                : Container(),
            guides.isNotEmpty
                ? GuidesListWidget(guides, location.placeId)
                : Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('${S.of(context).noGuides}!'),
                    ),
                  ),
            //_getCommentsList(context),
               guides.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Container(
                      width: double.maxFinite,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${S.of(context).comments}',
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      )),
                    ),
                  )
                : Container(),
            CommentListWidget(
              comments: location.comments,
              pageSize: 3,
              onCommentPosted: (comment) {
                screenState.createComment(
                    comment, location.id.toString(), location.placeId);
              },
              isLoggedIn: isLoggedIn,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCarousel(BuildContext context) {
    List<Widget> carouselList = [];
    location.regionImage ??= [];
    if (location.regionImage != null) {
      location.regionImage.forEach((path) {
        carouselList.add(Flex(
          direction: Axis.vertical,
          children: [
            Image.network(
              '${path.path}'.contains('http')
                  ? '${path.path}'.substring(path.path.lastIndexOf('http'))
                  : path.path,
              errorBuilder: (c, e, s) {
                return Image.asset('resources/images/logo.png');
              },
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              color: Color(0xff05F29B),
              child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${S.of(context).ratingAverage}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5),
                      ),
                      Directionality(
                        textDirection: mat.TextDirection.ltr,
                        child: SmoothStarRating(
                            allowHalfRating: true,
                            starCount: 5,
                            rating: location.ratingAverage != null
                                ? double.parse(location.ratingAverage)
                                : 0.0,
                            size: 25.0,
                            isReadOnly: true,
                            color: Colors.white,
                            borderColor: Colors.white,
                            spacing: 0.0),
                      ),
                    ],
                  )),
            ),
          ],
        ));
      });
    }

    return Flex(
      direction: Axis.vertical,
      children: carouselList,
    );
  }

  Widget _getCommentsList(BuildContext context) {
    location.comments ??= <CommentModel>[];
    return CommentListWidget(
      comments: location.comments,
      pageSize: 3,
      onCommentPosted: (comment) {
        screenState.createComment(
            comment, location.id.toString(), location.placeId);
      },
      isLoggedIn: isLoggedIn,
    );
  }
}
