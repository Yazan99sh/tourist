import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final List<Widget> pages;

  CarouselWidget(this.pages);

  @override
  State<StatefulWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int position = 0;

  Widget getIndicator() {
    List<Widget> indicatorBar = [];
    for (int i = 0; i < widget.pages.length; i++) {
      indicatorBar.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: position == i ? Colors.white : Color(0x88ffffff),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ));
    }
    return Row(
      children: indicatorBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Stack(
        children: <Widget>[
          // Sizing Background
          Container(
            height: 240,
          ),

          PageView(
            children: widget.pages,
            scrollDirection: Axis.horizontal,
            onPageChanged: (pos) {
              this.position = pos;
              setState(() {});
            },
          ),

          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [getIndicator()],
            ),
          )
        ],
      ),
    );
  }
}
