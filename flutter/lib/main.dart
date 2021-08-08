import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_auth/authoriazation_module.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_forms/forms_module.dart';
import 'package:tourists/module_guide/guide_list_module.dart';
import 'package:tourists/module_home/home_module.dart';
import 'package:tourists/module_locations/location_module.dart';
import 'package:tourists/module_orders/order_module.dart';
import 'package:tourists/module_profile/profile_module.dart';
import 'package:tourists/module_search/search_module.dart';
import 'package:tourists/module_settings/settings_module.dart';
import 'package:tourists/module_splash/ui/splash_routes.dart';
import 'package:tourists/utils/language/language.dart';
import 'package:tourists/utils/logger/logger.dart';
import 'package:uni_links/uni_links.dart';
import 'di/components/app.component.dart';
import 'generated/l10n.dart';
import 'module_chat/chat_module.dart';
import 'module_splash/splash_module.dart';

import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await timeago.setLocaleMessages('ar', timeago.ArMessages());
  await timeago.setLocaleMessages('en', timeago.EnMessages());
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = (FlutterErrorDetails details) {
    print('Err: ' + details.exception.toString());
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final container = await AppComponent.create();
  FlutterError.onError = (FlutterErrorDetails details) async {
    new Logger().error('Main', details.toString(), StackTrace.current);
  };
  await runZoned<Future<void>>(() async {
    runApp(container.app);
  }, onError: (error, stackTrace) {
    new Logger().error(
        'Main', error.toString() + stackTrace.toString(), StackTrace.current);
  });
}

@provide
class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  final AuthorizationModule _authorizationModule;
  final HomeModule _homeModule;
  final ChatModule _chatModule;
  final FormsModule _formsModule;
  final GuideListModule _guideListModule;
  final LocationModule _locationModule;
  final OrderModule _orderModule;
  final SplashModule _splashModule;
  final SettingsModule _settingsModule;
  final LanguageHelper _languageHelper;
  final AuthService _authService;
  final SearchModule _searchModule;
  final ProfileModule _profileModule;

  MyApp(
    this._languageHelper,
    this._authorizationModule,
    this._settingsModule,
    this._homeModule,
    this._splashModule,
    this._chatModule,
    this._locationModule,
    this._guideListModule,
    this._orderModule,
    this._formsModule,
    this._authService,
    this._searchModule,
    this._profileModule,
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (data?.link != null) {
        await _authService.verifyLoginLink(data.link.toString());
      }
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
            await _authService.verifyLoginLink(data.link.toString());
          },
          onError: (OnLinkErrorException e) async {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = {};

    fullRoutesList.addAll(_authorizationModule.getRoutes());
    fullRoutesList.addAll(_homeModule.getRoutes());
    fullRoutesList.addAll(_chatModule.getRoutes());
    fullRoutesList.addAll(_formsModule.getRoutes());
    fullRoutesList.addAll(_locationModule.getRoutes());
    fullRoutesList.addAll(_guideListModule.getRoutes());
    fullRoutesList.addAll(_orderModule.getRoutes());
    fullRoutesList.addAll(_settingsModule.getRoutes());
    fullRoutesList.addAll(_splashModule.getRoutes());
    fullRoutesList.addAll(_searchModule.getRoutes());
    fullRoutesList.addAll(_profileModule.getRoutes());
    try {
      getInitialLink().then((value) {
        if (value != null) {
          _authService.verifyLoginLink(value);
        }
      });
    } catch (e) {}

    return StreamBuilder(
      stream: _languageHelper.languageStream,
      initialData: Platform.localeName,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return getConfiguratedApp(
          fullRoutesList,
          snapshot.data ?? 'en',
        );
      },
    );
  }

  Widget getConfiguratedApp(
      Map<String, WidgetBuilder> fullRoutesList, String currentLang) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      locale: Locale(currentLang),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: Color(0xff05F29B),
        accentColor: Color(0xffF2DC6B),
      ),
      supportedLocales: S.delegate.supportedLocales,
      title: 'Soyah',
      routes: fullRoutesList,
      initialRoute: SplashRoutes.splash,
    );
  }
}
