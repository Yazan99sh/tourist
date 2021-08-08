import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_comment/request/create_rating/create_rating.dart';

class GuideListItemWidget extends StatelessWidget {
  final String guideName;
  final String guideLanguage;
  final String guideImage;
  final String availability;
  final double rate;
  final String guideCity;
  final bool isLogged;
  void Function(double) createRate;
  GuideListItemWidget(
      {Key key,
      @required this.guideName,
      @required this.guideImage,
      @required this.guideLanguage,
      @required this.rate,
      @required this.guideCity,
      @required this.availability,
      @required this.isLogged,
      this.createRate});

  @override
  Widget build(BuildContext context) {
    var rating = 0.0;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  // Image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 56,
                        width: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        child: Text(
                          guideName[0],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        )),
                  ),
                  // Info
                  Expanded(
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          guideName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Text(
                              availability ?? S.of(context).available,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                            Container(
                              width: 8,
                            ),
                            SmoothStarRating(
                              rating: rate,
                              allowHalfRating: true,
                              isReadOnly: true,
                              color: Colors.black,
                              borderColor: Colors.black,
                              size: 14,
                            )
                          ],
                        ),
                        Text(
                          '$guideCity | $guideLanguage',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLogged
                ? Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('${S.of(context).rating}'),
                                content: Container(
                                  height: 100,
                                  child: Center(
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: SmoothStarRating(
                                        onRated: (r) {
                                          rating = r;
                                        },
                                        allowHalfRating: true,
                                        isReadOnly: !isLogged,
                                        color: Color(0xff05F29B),
                                        borderColor: Color(0xff05F29B),
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      createRate(rating);
                                      Navigator.of(context).pop();
                                    },
                                    color: Color(0xff05F29B),
                                    textColor: Colors.white,
                                    child: Text('${S.of(context).rating}'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    textColor: Colors.white,
                                    color: Color(0xff05F29B),
                                    child: Text('${S.of(context).cancel}'),
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        child: Icon(
                          Icons.star,
                          color: Color(0xff05F29B),
                        ),
                      ),
                    ),
                  )
                : Container(),
            // Request Button
            GestureDetector(
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    border: Border.all(color: Colors.black)),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getStarsLine() {
    List<Widget> starsLine = [];

    for (int i = 0; i < rate; i++) {
      starsLine.add(Icon(
        Icons.star,
        size: 16,
      ));
    }

    return Flex(
      direction: Axis.horizontal,
      children: starsLine,
    );
  }
}
