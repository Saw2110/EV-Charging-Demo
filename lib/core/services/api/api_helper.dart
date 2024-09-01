import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_response_check.dart';

class APIProvider {
  Future<Either<ResponseError, dynamic>> _request(
    String apiUrl,
    String method,
    dynamic body,
  ) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await _makeRequest(apiUrl, method, headers, body);

      debugPrint("*********************");
      debugPrint("----- API DETAILS --------");
      debugPrint("URL [$method] -> $apiUrl");
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
      debugPrint("*********************");

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = jsonDecode(response.body);
        return Either.success(data: responseBody);
      } else {
        final error = ResponseError.fromJson(jsonDecode(response.body));
        return Either.error(error: error);
      }
    } on SocketException {
      return Either.error(error: ResponseError('No Internet Connection'));
    } on TimeoutException {
      return Either.error(error: ResponseError('Connection Timed Out'));
    } catch (e) {
      debugPrint('Error in API Request: $e');
      return Either.error(error: ResponseError('Something went wrong'));
    }
  }

  Future<http.Response> _makeRequest(
    String apiUrl,
    String method,
    Map<String, String> headers,
    dynamic body,
  ) {
    switch (method) {
      case 'GET':
        return http.get(Uri.parse(apiUrl), headers: headers);
      case 'POST':
        return http.post(
          Uri.parse(apiUrl),
          headers: headers,
          body: json.encode(body),
        );
      case 'PUT':
        return http.put(
          Uri.parse(apiUrl),
          headers: headers,
          body: json.encode(body),
        );
      default:
        throw ResponseError('Invalid HTTP method');
    }
  }

  Future<Either<ResponseError, dynamic>> getAPI({required String api}) async {
    return _request(api, 'GET', null);
  }

  Future<Either<ResponseError, dynamic>> postAPI({
    required String api,
    required dynamic body,
  }) async {
    return _request(api, 'POST', body);
  }

  Future<Either<ResponseError, dynamic>> putAPI({
    required String api,
    required dynamic body,
  }) async {
    return _request(api, 'PUT', body);
  }
}
