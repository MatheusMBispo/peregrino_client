import 'package:peregrino/feature/auth/data_source/auth_local_data_source.dart';
import 'package:peregrino/feature/auth/data_source/auth_network_data_source.dart';
import 'package:peregrino/feature/auth/model/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({
    required this.networkDatasource,
    required this.localDatasource,
  });

  AuthNetworkDataSource networkDatasource;
  AuthLocalDataSource localDatasource;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final user = await networkDatasource.login(
      email: email,
      password: password,
    );
    await _saveUser(user: user);
  }

  Future<void> logout() async {
    await localDatasource.deleteAll();
  }

  Future<void> refreshToken() async {
    final accessToken = await localDatasource.read(key: 'accessToken');
    final id = await localDatasource.read(key: 'userId');

    if (accessToken == null || id == null) {
      throw Exception('No user to refresh');
    }

    final user = await networkDatasource.refreshToken(
      accessToken: accessToken,
      userId: id,
    );

    await _saveUser(user: user);
  }

  Future<bool> isLogged() async {
    try {
      final accessToken = await localDatasource.read(key: 'accessToken');
      final id = await localDatasource.read(key: 'userId');

      if (accessToken == null || id == null) {
        return false;
      }
      return true;
    } catch (_, __) {
      return false;
    }
  }

  Future<String?> getToken() async {
    return localDatasource.read(key: 'accessToken');
  }

  Future<void> _saveUser({required User user}) async {
    final accessToken = user.accessToken;
    final id = user.id;

    if (accessToken == null || id == null) {
      throw Exception('Failed to login');
    }

    await localDatasource.save(key: 'accessToken', value: accessToken);
    await localDatasource.save(key: 'userId', value: id);
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    networkDatasource: ref.read(authNetworkDataSourceProvider),
    localDatasource: ref.read(authLocalDataSourceProvider),
  );
}
