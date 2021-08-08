import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/bloc/event_list/event_list_bloc.dart';
import 'package:tourists/module_locations/model/event/event_model.dart';
import 'package:tourists/module_locations/ui/widgets/event_list_item_widget/event_list_item_widget.dart';

import '../../../location_routes.dart';

@provide
class EventListScreen extends StatefulWidget {
  final EventListBloc bloc;

  EventListScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  String activeList = EventListBloc.KEY_FESTIVAL;
  List<EventModel> eventList;
  int currentStatus = EventListBloc.STATUS_CODE_INIT;

  @override
  Widget build(BuildContext context) {
    widget.bloc.eventStream.listen((event) {
      currentStatus = event.first;
      if (currentStatus == EventListBloc.STATUS_CODE_LOAD_SUCCESS) {
        eventList = event.last;
      }
      if (this.mounted) setState(() {});
    });

    switch (currentStatus) {
      case EventListBloc.STATUS_CODE_INIT:
        widget.bloc.getAllEvents();
        return _getLoadingUI();
      case EventListBloc.STATUS_CODE_LOADING:
        return _getLoadingUI();
      case EventListBloc.STATUS_CODE_LOAD_SUCCESS:
        return _getSuccessUI();
      default:
        return _getErrorUI();
    }
  }

  Widget _getLoadingUI() {
    return Center(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text('${S.of(context).loading}...')
        ],
      ),
    );
  }

  Widget _getErrorUI() {
    return Center(child: Text('${S.of(context).error_fetching_data}'));
  }

  Widget _getSuccessUI() {
    List<Widget> pageLayout = [];

    pageLayout.add(Container(
      width: double.infinity,
      height: 2,
      color: Colors.black45,
    ));

    // Filter
    pageLayout.add(Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              activeList = EventListBloc.KEY_EVENT;
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 48,
              child: Text(
                S.of(context).events,
                style: TextStyle(
                    color: activeList == EventListBloc.KEY_EVENT
                        ? Colors.greenAccent
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Container(
          height: 30,
          width: 2,
          color: Colors.black45,
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              activeList = EventListBloc.KEY_FESTIVAL;
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              child: Text(
                S.of(context).festivals,
                style: TextStyle(
                    color: activeList == EventListBloc.KEY_FESTIVAL
                        ? Colors.greenAccent
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    ));

    pageLayout.add(Container(
      width: double.infinity,
      height: 2,
      color: Colors.black45,
    ));

    List<EventModel> eventsList = getActiveList();

    if (eventsList.isNotEmpty) {
      getActiveList().forEach((event) {
        pageLayout.add(GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, LocationRoutes.eventDetails,
                arguments: event.id);
          },
          child: EventListItemWidget(
            image: event.images ??
                'https://www.abouther.com/sites/default/files/2018/11/06/main_-_janadriyah_festival.jpg',
            location: event.location,
            status: getStatus(getDate(event.date.timestamp)),
            commentNumber: int.parse(event.commentNumber ?? '0'),
            time: getDate(event.date.timestamp),
            name: event.name,
          ),
        ));
      });
    } else {
      pageLayout.add(Center(
        child: Text(S.of(context).no_events_yet),
      ));
    }

    return ListView(
      children: pageLayout,
    );
  }

  List<EventModel> getActiveList() {
    List<EventModel> events = [];
    eventList.forEach((element) {
      if (element.type == activeList) events.add(element);
    });
    return events;
  }

  DateTime getDate(int timeStamp) {
    return new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  }

  String getStatus(DateTime date) {
    if (date.isAfter(DateTime.now())) {
      return '${S.of(context).soon}';
    } else {
    return '${S.of(context).finished}';
    }
  }
}
