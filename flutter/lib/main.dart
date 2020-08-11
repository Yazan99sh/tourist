import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:tourists/components/guide/guide_module.dart';
import 'package:tourists/components/shared/chat_component.dart';
import 'package:tourists/components/user/user_component.dart';
import 'package:tourists/components/user/user_home_routes.dart';

import 'di/components/app.component.dart';
import 'generated/l10n.dart';

typedef Provider<T> = T Function();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final container = await AppComponent.create();
    runApp(container.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  final UserComponent _userComponent;
  final GuideComponent _guideComponent;
  final SharedComponent _sharedComponent;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  MyApp(this._userComponent, this._guideComponent, this._sharedComponent);

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = Map();

    fullRoutesList.addAll(_userComponent.getRoutes());
    fullRoutesList.addAll(_guideComponent.getRoutes());
    fullRoutesList.addAll(_sharedComponent.getRoutes());

    return MaterialApp(
        navigatorObservers: <NavigatorObserver>[
          observer
        ],
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
            primaryColor: Colors.greenAccent, accentColor: Colors.greenAccent),
        supportedLocales: S.delegate.supportedLocales,
        title: 'Soyah',
        routes: fullRoutesList,
        initialRoute: UserRoutes.home);
  }
}
