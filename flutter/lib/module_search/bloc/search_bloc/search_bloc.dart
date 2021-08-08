import 'dart:async';

import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_locations/service/google_locations/google_locations_service.dart';

@provide
class SearchBloc {
  final _stateSubject = PublishSubject();
  final _searchSuggestionSubject = PublishSubject<List>();

  Stream get stateStream => _stateSubject.stream;

  Stream<List> get predictionStream =>
      _searchSuggestionSubject.stream;

  final GoogleLocationsService _locationsService;

  SearchBloc(this._locationsService);

  Timer _debounce;

  void getPredictions(String query) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _locationsService.getPredictions(query).then(
        (value) {
          _searchSuggestionSubject.add(value);
        },
      );
    });
  }
}
