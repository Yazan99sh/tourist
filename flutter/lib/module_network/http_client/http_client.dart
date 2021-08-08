import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_network/network_client/network_client.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
class HttpClient extends NetworkClient {
  final _client = Dio(BaseOptions(
    baseUrl: Urls.baseAPI,
    connectTimeout: 5000,
    receiveTimeout: 5000,
    sendTimeout: 5000,
  ));

  final _logger = Logger();
  final performanceInterceptor = DioFirebasePerformanceInterceptor();
  final String tag = 'HttpClient';

  HttpClient() {
    _client.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: Urls.baseAPI)).interceptor);
    _client.interceptors.add(performanceInterceptor);
  }

  @override
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic> queryParams,
    Map<String, String> headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting GET to: ' + url);
      _logger.info(tag, 'Headers: ' + headers.toString());
      _logger.info(tag, 'Query: ' + queryParams.toString());

      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          _client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      var response = await _client.get(
        url,
        queryParameters: queryParams,
      );
      return _processResponse(response);

    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response != null) {
          if (err.response?.statusCode != 404) {
            _logger.error(
                tag, err.message + ', GET: ' + url, StackTrace.current);
          }
        }
      } else {
        _logger.error(tag, e.toString() + ', GET: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      _logger.info(tag, 'POST: ' + jsonEncode(payLoad));
      _logger.info(tag, 'Headers: ' + jsonEncode(headers));
      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          _client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      _client.interceptors.add(performanceInterceptor);
      var response = await _client.post(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err?.response?.statusCode != 404) {
          _logger.error(
              tag, err.message + ', POST: ' + url, StackTrace.current);
        }
        return null;
      } else {
        _logger.error(tag, e.toString() + ', POST: ' + url, StackTrace.current);
        return null;
      }
    }
  }

  @override
  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting PUT to: ' + url);
      _logger.info(tag, 'PUT: ' + jsonEncode(payLoad));

      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          _client.options.headers['Authorization'] = headers['Authorization'];
        }
      }

      _client.interceptors.add(performanceInterceptor);
      var response = await _client.put(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
        options: Options(headers: headers),
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response.statusCode != 404) {
          _logger.error(tag, err.message + ', PUT: ' + url, StackTrace.current);
        }
      } else {
        _logger.error(tag, e.toString() + ', PUT: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting DELETE to: ' + url);
      _logger.info(tag, 'Headers: ' + headers.toString());
      _logger.info(tag, 'Query: ' + queryParams.toString());

      _client.interceptors.add(performanceInterceptor);
      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          _client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      var response = await _client.delete(
        url,
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response.statusCode != 404) {
          _logger.error(
              tag, err.message + ', DELETE: ' + url, StackTrace.current);
        }
      } else {
        _logger.error(
            tag, e.toString() + ', DELETE: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  Map<String, dynamic> _processResponse(Response response) {
    _logger.info(tag, 'Processing Response');
    if (response.statusCode >= 200 && response.statusCode < 400) {
      _logger.info(tag, response.data.toString());
      return response.data;
    } else if (response.statusCode <= 400 && response.statusCode < 500) {
      _logger.error(tag,
          '${response.statusCode}\n\nBad Request: ${response.data} \n${StackTrace.current}');
      return null;
    } else {
      _logger.error(tag,
          '${response.statusCode}\n\nUnknown Error from response: ${response.data} \n${StackTrace.current}');
      return null;
    }
  }
}
