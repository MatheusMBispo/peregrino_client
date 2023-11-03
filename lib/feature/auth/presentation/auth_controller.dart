import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/core/navigation/route.dart';
import 'package:peregrino/core/navigation/router.dart';
import 'package:peregrino/feature/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController with ControllerLoggy {
  @override
  Future<void> build() async {}

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    loggy.debug('Logging in!');
    try {
      await ref
          .read(authRepositoryProvider)
          .login(email: email, password: password);
      loggy.debug('User Logged!');
      state = const AsyncValue.data(null);
      await ref.read(goRouterProvider).push(AppRoute.home.path);
    } catch (error, stackTrace) {
      loggy.debug('Something went wrong: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> anonymousLogin() async {
    await ref.read(goRouterProvider).push(AppRoute.home.path);
  }
}
