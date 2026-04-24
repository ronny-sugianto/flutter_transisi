part of 'base_api_client.dart';

class ApiClient extends BaseApiClient {
  @override
  Future get(
    String url, {
    String? token,
    String contentType = 'application/json',
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    int msTimeout = 10000,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: queryParams?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final Map<String, String> stringHeaders = {
      if (headers != null)
        ...headers.map((key, value) => MapEntry(key, value.toString())),
      if (token != null) 'Authorization': 'Bearer $token',
      'Accept': contentType,
    };

    try {
      final response = await http.Client()
          .get(uri, headers: stringHeaders)
          .timeout(Duration(milliseconds: msTimeout));

      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw BadRequestException(response.body);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(response.body);
      } else if (response.statusCode == 403) {
        throw ForbiddenException(response.body);
      } else if (response.statusCode == 404) {
        throw NotFoundException(response.body);
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw InternalServerErrorException(response.body);
      }

      return response;
    } on TimeoutException catch (e) {
      throw TimeoutException(e.toString());
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  @override
  Future post(
    String url, {
    data,
    String? token,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String contentType = 'application/json',
    int msTimeout = 30000,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: queryParams?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final Map<String, String> stringHeaders = {
      if (headers != null)
        ...headers.map((key, value) => MapEntry(key, value.toString())),
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': contentType,
    };

    try {
      final response = await http.Client()
          .post(uri, body: jsonEncode(data), headers: stringHeaders)
          .timeout(Duration(milliseconds: msTimeout));

      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw BadRequestException(response.body);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(response.body);
      } else if (response.statusCode == 403) {
        throw ForbiddenException(response.body);
      } else if (response.statusCode == 404) {
        throw NotFoundException(response.body);
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw InternalServerErrorException(response.body);
      }

      return response;
    } on TimeoutException catch (e) {
      throw TimeoutException(e.toString());
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  @override
  Future put(
    String url, {
    data,
    String? token,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: queryParams?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final Map<String, String> stringHeaders = {
      if (headers != null)
        ...headers.map((key, value) => MapEntry(key, value.toString())),
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': contentType,
    };

    try {
      final response = await http.Client()
          .put(uri, body: jsonEncode(data), headers: stringHeaders)
          .timeout(Duration(milliseconds: msTimeout));
      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw BadRequestException(response.body);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(response.body);
      } else if (response.statusCode == 403) {
        throw ForbiddenException(response.body);
      } else if (response.statusCode == 404) {
        throw NotFoundException(response.body);
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw InternalServerErrorException(response.body);
      }

      return response;
    } on TimeoutException catch (e) {
      throw TimeoutException(e.toString());
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  @override
  Future patch(
    String url, {
    data,
    String? token,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: queryParams?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final Map<String, String> stringHeaders = {
      if (headers != null)
        ...headers.map((key, value) => MapEntry(key, value.toString())),
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': contentType,
    };
    try {
      final response = await http.Client()
          .patch(uri, body: jsonEncode(data), headers: stringHeaders)
          .timeout(Duration(milliseconds: msTimeout));

      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw BadRequestException(response.body);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(response.body);
      } else if (response.statusCode == 403) {
        throw ForbiddenException(response.body);
      } else if (response.statusCode == 404) {
        throw NotFoundException(response.body);
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw InternalServerErrorException(response.body);
      }

      return response;
    } on TimeoutException catch (e) {
      throw TimeoutException(e.toString());
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  @override
  Future delete(
    String url, {
    data,
    String? token,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: queryParams?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final Map<String, String> stringHeaders = {
      if (headers != null)
        ...headers.map((key, value) => MapEntry(key, value.toString())),
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': contentType,
    };
    try {
      final response = await http.Client()
          .delete(uri, body: jsonEncode(data), headers: stringHeaders)
          .timeout(Duration(milliseconds: msTimeout));

      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw BadRequestException(response.body);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(response.body);
      } else if (response.statusCode == 403) {
        throw ForbiddenException(response.body);
      } else if (response.statusCode == 404) {
        throw NotFoundException(response.body);
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw InternalServerErrorException(response.body);
      }

      return response;
    } on TimeoutException catch (e) {
      throw TimeoutException(e.toString());
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
