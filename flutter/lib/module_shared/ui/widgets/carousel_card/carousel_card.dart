import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class CarouselCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int stars;
  final int commentsNumber;

  CarouselCard(
      {Key key,
      this.title,
      this.description,
      this.image,
      this.stars,
      this.commentsNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 240,
              child: Image.network(
                '$image'.contains('http')
                    ? image.substring(image.lastIndexOf('http'))
                    : image,
                fit: BoxFit.cover,
                errorBuilder: (context, object, stack) {
                  return Image.asset('resources/images/logo.jpg');
                },
              )),
          Container(
            height: 240,
            width: double.infinity,
            color: Color(0x80000000),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container(
                  height: 8,
                ),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Container(
                  height: 8,
                ),
                getStarsRow(),
                Container(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Colors.white,
                    ),
                    Container(
                      width: 8,
                    ),
                    Text(
                      commentsNumber.toString() + ' ' + S.of(context).comments,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getStarsRow() {
    double starSize = 20.0;
    List<Widget> starsRow = [];
    for (int i = 0; i < 5; i++) {
      starsRow.add(
        i + 1 <= stars
            ? Icon(
                Icons.star,
                color: Colors.white,
                size: starSize,
              )
            : Icon(
                Icons.star,
                color: Color(0x88ffffff),
                size: starSize,
              ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: starsRow,
    );
  }
}
