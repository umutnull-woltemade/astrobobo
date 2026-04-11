import 'dart:convert';
import 'package:http/http.dart' as http;

/// Base API client for connecting to the NestJS backend
class ApiClient {
  // Default to localhost for development (with /api prefix)
  static const String _defaultBaseUrl = 'http://localhost:3000/api';

  final String baseUrl;
  final http.Client _client;
  String? _authToken;

  ApiClient({String? baseUrl, http.Client? client})
    : baseUrl = baseUrl ?? _defaultBaseUrl,
      _client = client ?? http.Client();

  /// Set the auth token for authenticated requests
  void setAuthToken(String? token) {
    _authToken = token;
  }

  /// Get default headers
  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  /// GET request
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final uri = _buildUri(path, queryParams);
      final response = await _client.get(uri, headers: _headers);
      return _handleResponse(response, fromJson);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  /// POST request
  Future<ApiResponse<T>> post<T>(
    String path, {
    Map<String, dynamic>? body,
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final uri = _buildUri(path);
      final response = await _client.post(
        uri,
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response, fromJson);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  /// DELETE request
  Future<ApiResponse<void>> delete(String path) async {
    try {
      final uri = _buildUri(path);
      final response = await _client.delete(uri, headers: _headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.success(null);
      }
      return ApiResponse.error('Delete failed: ${response.statusCode}');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Uri _buildUri(String path, [Map<String, dynamic>? queryParams]) {
    final uri = Uri.parse('$baseUrl$path');
    if (queryParams != null && queryParams.isNotEmpty) {
      return uri.replace(
        queryParameters: queryParams.map(
          (key, value) => MapEntry(key, value?.toString()),
        ),
      );
    }
    return uri;
  }

  ApiResponse<T> _handleResponse<T>(
    http.Response response,
    T Function(dynamic json)? fromJson,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return ApiResponse.success(null as T);
      }
      final json = jsonDecode(response.body);
      if (fromJson != null) {
        return ApiResponse.success(fromJson(json));
      }
      return ApiResponse.success(json as T);
    }

    String errorMessage;
    try {
      final json = jsonDecode(response.body);
      errorMessage = json['message'] ?? 'Unknown error';
    } catch (_) {
      errorMessage = response.body.isNotEmpty
          ? response.body
          : 'HTTP ${response.statusCode}';
    }
    return ApiResponse.error(errorMessage, statusCode: response.statusCode);
  }

  void dispose() {
    _client.close();
  }
}

/// API response wrapper
class ApiResponse<T> {
  final T? data;
  final String? error;
  final int? statusCode;
  final bool isSuccess;

  ApiResponse._({
    this.data,
    this.error,
    this.statusCode,
    required this.isSuccess,
  });

  factory ApiResponse.success(T? data) {
    return ApiResponse._(data: data, isSuccess: true);
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse._(
      error: message,
      statusCode: statusCode,
      isSuccess: false,
    );
  }
}
