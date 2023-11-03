import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/feature/auth/model/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_network_data_source.g.dart';

class AuthNetworkDataSource with ProviderLoggy {
  AuthNetworkDataSource({
    required this.client,
  });

  final http.Client client;
  final baseURI = 'peregrino-app.appspot.com';

  Future<User> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.https(baseURI, '/api/v1/auth/signin');
    final response = await http.post(
      uri,
      body: {
        'password': password,
        'email': email,
      },
    );
    if (response.statusCode == 201) {
      final userJson = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(userJson);
    } else {
      loggy.error('Error on login: ${response.statusCode}');
      throw Exception('Failed on login: ');
    }
  }

  Future<User> refreshToken({
    required String accessToken,
    required String userId,
  }) async {
    final uri = Uri.https(baseURI, '/api/v1/auth/refresh-token');
    final response = await http.put(
      uri,
      body: {
        'accessToken': accessToken,
        'userId': userId,
      },
    );
    if (response.statusCode == 200) {
      final userJson = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(userJson);
    } else {
      throw Exception(
        'Failed on refresh token, status code: ${response.statusCode}',
      );
    }
  }
}

@riverpod
AuthNetworkDataSource authNetworkDataSource(AuthNetworkDataSourceRef ref) {
  return AuthNetworkDataSource(client: http.Client());
}
