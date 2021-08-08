import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/authorization_routes.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_locations/ui/screens/event_list/event_list.dart';
import 'package:tourists/module_locations/ui/screens/location_carousel/location_carousel.dart';
import 'package:tourists/module_locations/ui/screens/location_list/location_list_screen.dart';
import 'package:tourists/module_orders/orders_routes.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/module_profile/profile_routes.dart';
import 'package:tourists/module_search/search_routes.dart';
import 'package:tourists/module_settings/settings_routes.dart';
import 'package:tourists/module_shared/ui/widgets/request_guide_button/request_guide_button.dart';

@provide
class HomeScreen extends StatefulWidget {
  final GuideListScreen _guideListScreen;
  final EventListScreen _eventListScreen;
  final LocationListScreen _locationListScreen;
  final LocationCarouselScreen _locationCarouselScreen;
  final AuthService _authService;

  HomeScreen(
    this._locationListScreen,
    this._guideListScreen,
    this._eventListScreen,
    this._authService,
    this._locationCarouselScreen,
  );

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int position = 0;
  bool moreActive = false;
  bool loggedIn;
  int prePostion = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (loggedIn == null) {
      widget._authService.isLoggedIn.then((value) {
        loggedIn = value;
        setState(() {});
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                Stack(children: [
                  Positioned.fill(
                    child: ListView(
                      children: <Widget>[
                        AppBar(
                          backgroundColor: Colors.white,
                          centerTitle: true,
                          leading: FutureBuilder(
                            future: widget._authService.userRole,
                            builder: (_, snapshot) {
                              if (loggedIn != null) {
                                if (loggedIn && snapshot.hasData) {
                                  if (snapshot.data == UserRole.ROLE_GUIDE) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                          'resources/images/logo.jpg'),
                                    );
                                  } else {
                                    return Icon(
                                      Icons.account_circle,
                                      color: Color(0xff05F29B),
                                    );
                                  }
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            },
                          ),
                          title: Text('${S.of(context).soyah}'),
                          actions: [
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SearchRoutes.ROUTE_SEARCH);
                              },
                            ),
                          ],
                        ),
                        widget._locationCarouselScreen,
                        widget._locationListScreen,
                        Container(
                          height: 112,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _changePosition(1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RequestGuideButton(),
                        ),
                      ),
                    ),
                  ),
                ]),
                widget._guideListScreen,
                widget._eventListScreen
              ],
              onPageChanged: (pos) {
                if (position != 3) {
                  prePostion = position;
                }
                _changePosition(pos);
              },
            ),
          ),
          Positioned.fill(
            child: position == 3
                ? Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _changePosition(prePostion);
                          },
                          child: Container(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      moreColumn(),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: position ?? 0,
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).primaryColor),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
          onTap: (pos) {
            if (position != 3) {
              prePostion = position;
            }
            if (pos == 3 && position == 3) {
              _changePosition(prePostion);
              return true;
            }
            _changePosition(pos);
            return true;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: S.of(context).guides),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), label: S.of(context).events),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz), label: S.of(context).more),
          ]),
    );
  }

  Widget moreColumn() {
    return FutureBuilder(
      future: widget._authService.userRole,
      builder: (BuildContext context, AsyncSnapshot<UserRole> snapshot) {
        if (snapshot.hasData && loggedIn) {
          return Flex(
            direction: Axis.vertical,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(OrdersRoutes.ordersList);
                },
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text(S.of(context).orders),
                  ),
                ),
              ),
              snapshot.data == UserRole.ROLE_TOURIST
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(HomeRoutes.guideHome);
                      },
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.user),
                          title: Text(S.of(context).guidesArea),
                        ),
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SettingsRoute.settingsRoutes);
                },
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(S.of(context).settings),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProfileRoutes.MY_ROUTE_PROFILE);
                },
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(S.of(context).profile),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Flex(
            direction: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () {
                  SharedPreferencesHelper preferencesHelper =
                      new SharedPreferencesHelper();
                  preferencesHelper.clearData().then((value) {
                    Navigator.pushNamed(
                        context, AuthorizationRoutes.LOGIN_SCREEN);
                  });
                },
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: GestureDetector(
                        onTap: () {
                          if (loggedIn == true) {
                            widget._authService.logout().then((value) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomeRoutes.home, (route) => false);
                            });
                          } else {
                            Navigator.of(context)
                                .pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
                          }
                        },
                        child: Text(loggedIn == true
                            ? S.of(context).logout
                            : S.of(context).login)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SettingsRoute.settingsRoutes);
                },
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(S.of(context).settings),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  void _changePosition(position) {
    print(position);
    if (position == null) {
      position = 0;
    }
    if (position < 3) _pageController.jumpToPage(position);
    setState(() {
      this.position = position;
    });
  }
}
