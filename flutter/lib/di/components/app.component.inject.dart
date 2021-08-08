import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../module_locations/bloc/location_list/location_list_bloc.dart'
    as _i3;
import '../../utils/auth_guard/auth_gard.dart' as _i4;
import 'dart:async' as _i5;
import '../../main.dart' as _i6;
import '../../utils/language/language.dart' as _i7;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i8;
import '../../module_auth/authoriazation_module.dart' as _i9;
import '../../module_auth/ui/screen/login_screen/login_screen.dart' as _i10;
import '../../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i11;
import '../../module_auth/service/auth_service/auth_service.dart' as _i12;
import '../../module_auth/presistance/auth_prefs_helper.dart' as _i13;
import '../../module_auth/manager/auth_manager/auth_manager.dart' as _i14;
import '../../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../../module_settings/settings_module.dart' as _i16;
import '../../module_settings/ui/settings/settings.dart' as _i17;
import '../../module_settings/state_manager/settings_state_manager.dart'
    as _i18;
import '../../module_home/home_module.dart' as _i19;
import '../../module_home/ui/screens/guide_home/guide_home.dart' as _i20;
import '../../module_orders/ui/screen/guide_orders/guide_orders.dart' as _i21;
import '../../module_orders/bloc/guide_orders_list/guide_orders_list.dart'
    as _i22;
import '../../module_orders/service/guide_orders/guide_orders.dart' as _i23;
import '../../module_orders/manager/guide_orders/guide_orders.dart' as _i24;
import '../../module_orders/repository/guide_orders/guide_orders.dart' as _i25;
import '../../module_network/http_client/http_client.dart' as _i26;
import '../../module_home/ui/screens/home/home.dart' as _i27;
import '../../module_locations/ui/screens/location_list/location_list_screen.dart'
    as _i28;
import '../../module_locations/service/location_list/location_list_service.dart'
    as _i29;
import '../../module_locations/manager/location_list/location_list_manager.dart'
    as _i30;
import '../../module_locations/repository/location_list/location_list_repository.dart'
    as _i31;
import '../../module_guide/ui/screen/guide_list/guide_list_screen.dart' as _i32;
import '../../module_guide/bloc/guide_list/guide_list_bloc.dart' as _i33;
import '../../module_guide/service/guide_list/guide_list.dart' as _i34;
import '../../module_guide/manager/guides_manager/guides_manager.dart' as _i35;
import '../../module_guide/repository/guides/guide_repository.dart' as _i36;
import '../../module_comment/manager/rate/rate_manager.dart' as _i37;
import '../../module_comment/repository/rating/rating_repository.dart' as _i38;
import '../../module_locations/ui/screens/event_list/event_list.dart' as _i39;
import '../../module_locations/bloc/event_list/event_list_bloc.dart' as _i40;
import '../../module_locations/service/event/event_service.dart' as _i41;
import '../../module_locations/manager/event/event_manager.dart' as _i42;
import '../../module_locations/repository/event/event_repository.dart' as _i43;
import '../../module_locations/ui/screens/location_carousel/location_carousel.dart'
    as _i44;
import '../../module_splash/splash_module.dart' as _i45;
import '../../module_splash/ui/screen/splash_screen.dart' as _i46;
import '../../module_chat/chat_module.dart' as _i47;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i48;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i49;
import '../../module_chat/service/chat/char_service.dart' as _i50;
import '../../module_chat/manager/chat/chat_manager.dart' as _i51;
import '../../module_chat/repository/chat/chat_repository.dart' as _i52;
import '../../module_locations/location_module.dart' as _i53;
import '../../module_locations/ui/screens/location_details/location_details.dart'
    as _i54;
import '../../module_locations/bloc/location_details/location_details_bloc.dart'
    as _i55;
import '../../module_locations/service/location_details/location_details_service.dart'
    as _i56;
import '../../module_locations/manager/location_details/location_details.dart'
    as _i57;
import '../../module_locations/repository/location_details/location_details_repository.dart'
    as _i58;
import '../../module_locations/service/google_locations/google_locations_service.dart'
    as _i59;
import '../../module_locations/manager/google_locations/google_locations_manager.dart'
    as _i60;
import '../../module_locations/repository/google_location/google_location_repository.dart'
    as _i61;
import '../../module_locations/service/prefs/location_prefs.dart' as _i62;
import '../../module_comment/manager/comment/comment_service.dart' as _i63;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i64;
import '../../module_locations/ui/screens/event_details/event_details_screen.dart'
    as _i65;
import '../../module_locations/bloc/event_details/event_details.dart' as _i66;
import '../../module_locations/ui/screens/add_location/add_location.dart'
    as _i67;
import '../../module_locations/bloc/add_location/add_location.dart' as _i68;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i69;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i70;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i71;
import '../../module_guide/guide_list_module.dart' as _i72;
import '../../module_orders/order_module.dart' as _i73;
import '../../module_orders/ui/screen/orders_list/order_list_screen.dart'
    as _i74;
import '../../module_orders/bloc/orders_list_bloc/orders_list_bloc.dart'
    as _i75;
import '../../module_orders/service/orders/orders_service.dart' as _i76;
import '../../module_orders/manager/orders/orders_manager.dart' as _i77;
import '../../module_orders/repository/orders/orders.dart' as _i78;
import '../../module_forms/forms_module.dart' as _i79;
import '../../module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart'
    as _i80;
import '../../module_forms/user_orders_module/bloc/request_guide/request_guide.bloc.dart'
    as _i81;
import '../../module_forms/user_orders_module/service/request_guide/request_guide.service.dart'
    as _i82;
import '../../module_forms/user_orders_module/manager/request_manager/request_guide_manager.dart'
    as _i83;
import '../../module_forms/user_orders_module/repository/request_guide/request_guide_repository.dart'
    as _i84;
import '../../module_search/search_module.dart' as _i85;
import '../../module_search/ui/screen/search_screen/search_screen.dart' as _i86;
import '../../module_search/bloc/search_bloc/search_bloc.dart' as _i87;
import '../../module_profile/profile_module.dart' as _i88;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i89;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i90;
import '../../module_profile/service/profile/profile_service.dart' as _i91;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i92;
import '../../module_profile/repository/my_profile/my_profile.dart' as _i93;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i94;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.LocationListBloc _singletonLocationListBloc;

  _i4.AuthGuard _singletonAuthGuard;

  static _i5.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i6.MyApp _createMyApp() => _i6.MyApp(
      _createLanguageHelper(),
      _createAuthorizationModule(),
      _createSettingsModule(),
      _createHomeModule(),
      _createSplashModule(),
      _createChatModule(),
      _createLocationModule(),
      _createGuideListModule(),
      _createOrderModule(),
      _createFormsModule(),
      _createAuthService(),
      _createSearchModule(),
      _createProfileModule());
  _i7.LanguageHelper _createLanguageHelper() =>
      _i7.LanguageHelper(_createSharedPreferencesHelper());
  _i8.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i8.SharedPreferencesHelper();
  _i9.AuthorizationModule _createAuthorizationModule() =>
      _i9.AuthorizationModule(_createLoginScreen());
  _i10.LoginScreen _createLoginScreen() =>
      _i10.LoginScreen(_createLoginStateManager());
  _i11.LoginStateManager _createLoginStateManager() =>
      _i11.LoginStateManager(_createAuthService());
  _i12.AuthService _createAuthService() =>
      _i12.AuthService(_createAuthPrefsHelper(), _createAuthManager());
  _i13.AuthPrefsHelper _createAuthPrefsHelper() => _i13.AuthPrefsHelper();
  _i14.AuthManager _createAuthManager() =>
      _i14.AuthManager(_createAuthRepository());
  _i15.AuthRepository _createAuthRepository() => _i15.AuthRepository();
  _i16.SettingsModule _createSettingsModule() =>
      _i16.SettingsModule(_createSettingsScreen());
  _i17.SettingsScreen _createSettingsScreen() =>
      _i17.SettingsScreen(_createSettingsStateManager());
  _i18.SettingsStateManager _createSettingsStateManager() =>
      _i18.SettingsStateManager(_createAuthService(), _createLanguageHelper());
  _i19.HomeModule _createHomeModule() =>
      _i19.HomeModule(_createGuideHomeScreen(), _createHomeScreen());
  _i20.GuideHomeScreen _createGuideHomeScreen() =>
      _i20.GuideHomeScreen(_createGuideOrdersScreen());
  _i21.GuideOrdersScreen _createGuideOrdersScreen() =>
      _i21.GuideOrdersScreen(_createGuideOrdersListBloc());
  _i22.GuideOrdersListBloc _createGuideOrdersListBloc() =>
      _i22.GuideOrdersListBloc(_createGuideOrdersService());
  _i23.GuideOrdersService _createGuideOrdersService() =>
      _i23.GuideOrdersService(_createGuideOrdersManager());
  _i24.GuideOrdersManager _createGuideOrdersManager() =>
      _i24.GuideOrdersManager(_createGuideOrdersRepository());
  _i25.GuideOrdersRepository _createGuideOrdersRepository() =>
      _i25.GuideOrdersRepository(_createHttpClient());
  _i26.HttpClient _createHttpClient() => _i26.HttpClient();
  _i27.HomeScreen _createHomeScreen() => _i27.HomeScreen(
      _createLocationListScreen(),
      _createGuideListScreen(),
      _createEventListScreen(),
      _createAuthService(),
      _createLocationCarouselScreen());
  _i28.LocationListScreen _createLocationListScreen() =>
      _i28.LocationListScreen(_createLocationListBloc());
  _i3.LocationListBloc _createLocationListBloc() =>
      _singletonLocationListBloc ??=
          _i3.LocationListBloc(_createLocationListService(), _createLogger());
  _i29.LocationListService _createLocationListService() =>
      _i29.LocationListService(_createLocationListManager());
  _i30.LocationListManager _createLocationListManager() =>
      _i30.LocationListManager(_createLocationListRepository());
  _i31.LocationListRepository _createLocationListRepository() =>
      _i31.LocationListRepository(
          _createHttpClient(), _createAuthService(), _createAuthPrefsHelper());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i32.GuideListScreen _createGuideListScreen() =>
      _i32.GuideListScreen(_createGuideListBloc());
  _i33.GuideListBloc _createGuideListBloc() =>
      _i33.GuideListBloc(_createGuideListService(), _createAuthService());
  _i34.GuideListService _createGuideListService() => _i34.GuideListService(
      _createGuidesManager(),
      _createSharedPreferencesHelper(),
      _createRatingManager());
  _i35.GuidesManager _createGuidesManager() =>
      _i35.GuidesManager(_createGuidesRepository());
  _i36.GuidesRepository _createGuidesRepository() =>
      _i36.GuidesRepository(_createHttpClient());
  _i37.RatingManager _createRatingManager() =>
      _i37.RatingManager(_createRatingRepository());
  _i38.RatingRepository _createRatingRepository() =>
      _i38.RatingRepository(_createHttpClient());
  _i39.EventListScreen _createEventListScreen() =>
      _i39.EventListScreen(_createEventListBloc());
  _i40.EventListBloc _createEventListBloc() =>
      _i40.EventListBloc(_createEventService());
  _i41.EventService _createEventService() =>
      _i41.EventService(_createEventManager(), _createAuthService());
  _i42.EventManager _createEventManager() =>
      _i42.EventManager(_createEventRepository());
  _i43.EventRepository _createEventRepository() =>
      _i43.EventRepository(_createHttpClient());
  _i44.LocationCarouselScreen _createLocationCarouselScreen() =>
      _i44.LocationCarouselScreen(_createLocationListBloc());
  _i45.SplashModule _createSplashModule() =>
      _i45.SplashModule(_createSplashScreen());
  _i46.SplashScreen _createSplashScreen() =>
      _i46.SplashScreen(_createLanguageHelper());
  _i47.ChatModule _createChatModule() => _i47.ChatModule(_createChatPage());
  _i48.ChatPage _createChatPage() => _i48.ChatPage(_createChatPageBloc());
  _i49.ChatPageBloc _createChatPageBloc() =>
      _i49.ChatPageBloc(_createChatService());
  _i50.ChatService _createChatService() =>
      _i50.ChatService(_createChatManager());
  _i51.ChatManager _createChatManager() =>
      _i51.ChatManager(_createChatRepository());
  _i52.ChatRepository _createChatRepository() => _i52.ChatRepository();
  _i53.LocationModule _createLocationModule() => _i53.LocationModule(
      _createLocationDetailsScreen(),
      _createEventDetailsScreen(),
      _createAddLocationScreen());
  _i54.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i54.LocationDetailsScreen(
          _createLocationDetailsBloc(), _createAuthGuard());
  _i55.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i55.LocationDetailsBloc(
          _createLocationDetailsService(),
          _createSharedPreferencesHelper(),
          _createCommentManager(),
          _createAuthService());
  _i56.LocationDetailsService _createLocationDetailsService() =>
      _i56.LocationDetailsService(
          _createLocationDetailsManager(),
          _createRatingManager(),
          _createSharedPreferencesHelper(),
          _createGoogleLocationsService());
  _i57.LocationDetailsManager _createLocationDetailsManager() =>
      _i57.LocationDetailsManager(_createLocationDetailsRepository());
  _i58.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i58.LocationDetailsRepository(
          _createHttpClient(), _createAuthService(), _createAuthPrefsHelper());
  _i59.GoogleLocationsService _createGoogleLocationsService() =>
      _i59.GoogleLocationsService(
          _createGoogleLocationsManager(), _createLocationPreferencesHelper());
  _i60.GoogleLocationsManager _createGoogleLocationsManager() =>
      _i60.GoogleLocationsManager(_createGoogleLocationRepository());
  _i61.GoogleLocationRepository _createGoogleLocationRepository() =>
      _i61.GoogleLocationRepository();
  _i62.LocationPreferencesHelper _createLocationPreferencesHelper() =>
      _i62.LocationPreferencesHelper();
  _i63.CommentManager _createCommentManager() =>
      _i63.CommentManager(_createCommentRepository());
  _i64.CommentRepository _createCommentRepository() => _i64.CommentRepository();
  _i4.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i4.AuthGuard(_createSharedPreferencesHelper());
  _i65.EventDetailsScreen _createEventDetailsScreen() =>
      _i65.EventDetailsScreen(_createEventDetailsBloc());
  _i66.EventDetailsBloc _createEventDetailsBloc() => _i66.EventDetailsBloc(
      _createEventService(),
      _createLocationListService(),
      _createCommentManager(),
      _createSharedPreferencesHelper());
  _i67.AddLocationScreen _createAddLocationScreen() =>
      _i67.AddLocationScreen(_createAddLocationBloc());
  _i68.AddLocationBloc _createAddLocationBloc() => _i68.AddLocationBloc(
      _createImageUploadService(), _createLocationDetailsService());
  _i69.ImageUploadService _createImageUploadService() =>
      _i69.ImageUploadService(_createUploadManager());
  _i70.UploadManager _createUploadManager() =>
      _i70.UploadManager(_createUploadRepository());
  _i71.UploadRepository _createUploadRepository() => _i71.UploadRepository();
  _i72.GuideListModule _createGuideListModule() => _i72.GuideListModule();
  _i73.OrderModule _createOrderModule() =>
      _i73.OrderModule(_createOrdersListScreen(), _createGuideOrdersScreen());
  _i74.OrdersListScreen _createOrdersListScreen() => _i74.OrdersListScreen(
      _createOrdersListBloc(),
      _createAuthService(),
      _createGuideOrdersListBloc());
  _i75.OrdersListBloc _createOrdersListBloc() => _i75.OrdersListBloc(
      _createTouristOrdersService(), _createGuideOrdersService());
  _i76.TouristOrdersService _createTouristOrdersService() =>
      _i76.TouristOrdersService(_createOrdersManager(), _createAuthService());
  _i77.OrdersManager _createOrdersManager() =>
      _i77.OrdersManager(_createOrdersRepository());
  _i78.OrdersRepository _createOrdersRepository() =>
      _i78.OrdersRepository(_createHttpClient());
  _i79.FormsModule _createFormsModule() =>
      _i79.FormsModule(_createRequestGuideScreen());
  _i80.RequestGuideScreen _createRequestGuideScreen() =>
      _i80.RequestGuideScreen(_createRequestGuideBloc());
  _i81.RequestGuideBloc _createRequestGuideBloc() => _i81.RequestGuideBloc(
      _createRequestGuideService(), _createLocationDetailsService());
  _i82.RequestGuideService _createRequestGuideService() =>
      _i82.RequestGuideService(
          _createGuideListService(), _createRequestGuideManager());
  _i83.RequestGuideManager _createRequestGuideManager() =>
      _i83.RequestGuideManager(_createRequestGuideRepository());
  _i84.RequestGuideRepository _createRequestGuideRepository() =>
      _i84.RequestGuideRepository(_createHttpClient());
  _i85.SearchModule _createSearchModule() =>
      _i85.SearchModule(_createSearchScreen());
  _i86.SearchScreen _createSearchScreen() =>
      _i86.SearchScreen(_createSearchBloc());
  _i87.SearchBloc _createSearchBloc() =>
      _i87.SearchBloc(_createGoogleLocationsService());
  _i88.ProfileModule _createProfileModule() =>
      _i88.ProfileModule(_createMyProfileScreen());
  _i89.MyProfileScreen _createMyProfileScreen() =>
      _i89.MyProfileScreen(_createMyProfileStateManager());
  _i90.MyProfileStateManager _createMyProfileStateManager() =>
      _i90.MyProfileStateManager(_createImageUploadService(),
          _createProfileService(), _createAuthService(), _createSearchBloc());
  _i91.ProfileService _createProfileService() => _i91.ProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createLocationListService());
  _i92.MyProfileManager _createMyProfileManager() =>
      _i92.MyProfileManager(_createMyProfileRepository());
  _i93.MyProfileRepository _createMyProfileRepository() =>
      _i93.MyProfileRepository();
  _i94.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i94.ProfileSharedPreferencesHelper();
  @override
  _i6.MyApp get app => _createMyApp();
}
