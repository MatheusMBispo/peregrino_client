import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_data_source.g.dart';

class AuthLocalDataSource with ProviderLoggy {
  AuthLocalDataSource();

  final storage = const FlutterSecureStorage();

  Future<void> save({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return storage.read(key: key);
  }

  Future<void> deleteAll() async {
    return storage.deleteAll();
  }
}

@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  return AuthLocalDataSource();
}
