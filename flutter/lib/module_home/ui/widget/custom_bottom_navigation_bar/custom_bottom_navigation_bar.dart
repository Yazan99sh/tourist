import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/authorization_routes.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/module_settings/settings_routes.dart';

class CustomGuideBottomNavigationBar extends StatefulWidget {
  final Function(int) onNavigationChanged;
  final int currentPosition;
  final bool loggedIn;
  final Function() onLogout;

  CustomGuideBottomNavigationBar({
    @required this.loggedIn,
    @required this.currentPosition,
    @required this.onNavigationChanged,
    this.onLogout,
  });

  @override
  State<StatefulWidget> createState() =>
      _CustomGuideBottomNavigatorState(currentPosition);
}

class _CustomGuideBottomNavigatorState
    extends State<CustomGuideBottomNavigationBar> {
  final Color activeColor = Color(0xFF00FFA8);
  final Color inactiveColor = Colors.black;
  int currentPosition = 0;

  _CustomGuideBottomNavigatorState(this.currentPosition);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetLayout = [];

    if (currentPosition == 3) {
      widgetLayout.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: moreColumn(),
      ));
    }

    widgetLayout.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                widget.onNavigationChanged(0);
                this.currentPosition = 0;
                setState(() {});
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.credit_card,
                    color: currentPosition == 0 ? activeColor : inactiveColor,
                  ),
                  Text(
                    S.of(context).orders,
                    style: TextStyle(
                        color:
                            currentPosition == 0 ? activeColor : inactiveColor),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.onNavigationChanged(1);
                this.currentPosition = 1;
                setState(() {});
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.map,
                    color: currentPosition == 1 ? activeColor : inactiveColor,
                  ),
                  Text(
                    S.of(context).map,
                    style: TextStyle(
                        color:
                            currentPosition == 1 ? activeColor : inactiveColor),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                this.currentPosition = 2;
                widget.onNavigationChanged(2);
                setState(() {});
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.event,
                    color: currentPosition == 2 ? activeColor : inactiveColor,
                  ),
                  Text(
                    S.of(context).events,
                    style: TextStyle(
                        color:
                            currentPosition == 2 ? activeColor : inactiveColor),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                currentPosition = 3;
                setState(() {});
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.more_horiz,
                    color: currentPosition == 3 ? activeColor : inactiveColor,
                  ),
                  Text(
                    S.of(context).more,
                    style: TextStyle(
                        color:
                            currentPosition == 3 ? activeColor : inactiveColor),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SettingsRoute.settingsRoutes);
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Icon(Icons.settings),
                      Container(
                        width: 16,
                      ),
                      Text('${S.of(context).settings}'),
                    ],
                  ),
                ),
              ),
            )
          ]),
    ));

    return Column(
      children: widgetLayout,
    );
  }

  Flex moreColumn() {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            SharedPreferencesHelper preferencesHelper =
                new SharedPreferencesHelper();
            preferencesHelper.clearData().then((value) {
              Navigator.pushNamed(context, AuthorizationRoutes.LOGIN_SCREEN);
            });
          },
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Icon(Icons.exit_to_app),
                  Container(
                    width: 16,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (widget.loggedIn) {
                          // Navigator.of(context)
                          //     .pushNamed(AuthorizationRoutes.logout);
                        } else {
                          Navigator.of(context)
                              .pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
                        }
                      },
                      child: Text(widget.loggedIn
                          ? S.of(context).logout
                          : S.of(context).login)),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(
            //     context, GuideAuthorizationRoutes.guideUpdateProfile);
          },
          child: !widget.loggedIn
              ? Container()
              : Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Icon(Icons.account_circle),
                        Container(
                          width: 16,
                        ),
                        GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushNamed(
                              //     GuideAuthorizationRoutes.guideUpdateProfile);
                            },
                            child: Text(S.of(context).updateMyProfile)),
                      ],
                    ),
                  ),
                ),
        )
      ],
    );
  }
}
