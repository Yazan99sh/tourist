import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_comment/ui/widget/comment_list/comment_list.dart';
import 'package:tourists/module_locations/bloc/event_details/event_details.dart';
import 'package:tourists/module_locations/location_routes.dart';
import 'package:tourists/module_locations/model/event/event_model.dart';
import 'package:tourists/module_shared/ui/widgets/carousel/carousel.dart';
import 'package:tourists/module_shared/ui/widgets/request_guide_button/request_guide_button.dart';

@provide
class EventDetailsScreen extends StatefulWidget {
  final EventDetailsBloc _bloc;

  EventDetailsScreen(this._bloc);

  @override
  State<StatefulWidget> createState() => EventDetailsScreenState();
}

class EventDetailsScreenState extends State<EventDetailsScreen> {
  int currentState = EventDetailsBloc.STATUS_CODE_INIT;
  int eventId;
  EventModel eventDetails;
  String locationId;
  @override
  void initState() {
    super.initState();
    widget._bloc.eventStream.listen((event) {
      currentState = event[EventDetailsBloc.KEY_STATUS];
      if (currentState == EventDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
        eventDetails = event[EventDetailsBloc.KEY_EVENT];
        if (event[EventDetailsBloc.KEY_LOCATION] != null) {
          locationId = event[EventDetailsBloc.KEY_LOCATION].id;
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    eventId = ModalRoute.of(context).settings.arguments;
    widget._bloc.eventStream.listen((event) {
      currentState = event[EventDetailsBloc.KEY_STATUS];
      if (currentState == EventDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
        eventDetails = event[EventDetailsBloc.KEY_EVENT];
        if (event[EventDetailsBloc.KEY_LOCATION] != null) {
          locationId = event[EventDetailsBloc.KEY_LOCATION].id;
        }
      }
      if (mounted) {
        setState(() {});
      }
    });

    if (currentState == EventDetailsBloc.STATUS_CODE_INIT) {
      widget._bloc.getEventDetails(eventId.toString());
      return _getLoadingScreen();
    }

    if (currentState == EventDetailsBloc.STATUS_CODE_LOAD_ERROR) {
      return _getErrorScreen();
    }

    if (currentState == EventDetailsBloc.STATUS_CODE_LOAD_SUCCESS) {
      return _getSuccessScreenScaffold();
    }

    return _getUndefinedScreenScaffold();
  }

  Scaffold _getLoadingScreen() {
    return Scaffold(
      body: Center(
        child: Text(S.of(context).loading),
      ),
    );
  }

  Scaffold _getUndefinedScreenScaffold() {
    return Scaffold(
      body: Center(
        child: Text('Unknown State: ' + currentState.toString()),
      ),
    );
  }

  Scaffold _getSuccessScreenScaffold() {
    List<Widget> pageUI = [];
    List<Widget> carouselCards = [];

    var eventImages = [];
    print(eventDetails.images);
    if (eventDetails.images == null) {
      eventImages = [
        'https://www.abouther.com/sites/default/files/2018/11/06/main_-_janadriyah_festival.jpg'
      ];
    } else if (eventDetails.images.isEmpty) {
      eventImages = [
        'https://www.abouther.com/sites/default/files/2018/11/06/main_-_janadriyah_festival.jpg'
      ];
    } else {
      eventImages.add(eventDetails.images);
    }

    eventImages.forEach((element) {
      carouselCards.add(Image.network(element));
    });
    CarouselWidget carouselWidget = CarouselWidget(carouselCards);
    pageUI.add(carouselWidget);

    Flex eventInfo = Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              color: Colors.greenAccent,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  getTimeFromTimeStamp(eventDetails.date.timestamp)
                      .toIso8601String()
                      .substring(11, 16),
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Text(eventDetails.description),
            ],
          ),
        )
      ],
    );
    pageUI.add(eventInfo);

    pageUI.add(Container(
      height: 16,
    ));

    pageUI.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(getTimeFromTimeStamp(eventDetails.date.timestamp)
            .toString()
            .substring(0, 16))
      ],
    ));

    pageUI.add(Container(
      height: 16,
    ));
    pageUI.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.location_on),
        Text(
          eventDetails.location ?? '${S.of(context).soon}',
          style: TextStyle(fontSize: 24),
        )
      ],
    ));
    pageUI.add(Container(
      height: 16,
    ));
    pageUI.add(_getCommentsList());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(eventDetails.name),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 56,
            child: ListView(
              children: pageUI,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: this.locationId != null
                ? RequestGuideButton(
                    cityId: this.locationId != null
                        ? this.locationId.toString()
                        : '1',
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Scaffold _getErrorScreen() {
    return Scaffold(
      body: Center(
        child: Text(S.of(context).error_fetching_data),
      ),
    );
  }

  Widget _getCommentsList() {
    eventDetails.comments ??= <CommentModel>[];
    return CommentListWidget(
      comments: eventDetails.comments,
      pageSize: 3,
      onCommentPosted: (comment) {
        widget._bloc.postComment(comment, locationId ?? eventDetails.id);
      },
      isLoggedIn: eventDetails.isLogged ?? false,
    );
  }

  DateTime getTimeFromTimeStamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return date;
  }
}
