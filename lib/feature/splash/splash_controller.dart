import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/core/navigation/route.dart';
import 'package:peregrino/core/navigation/router.dart';
import 'package:peregrino/feature/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_controller.g.dart';

@riverpod
class SplashController extends _$SplashController with ControllerLoggy {
  @override
  Future<void> build() async {
    loggy.info('Checking refresh token!');
    Future<void>.delayed(const Duration(seconds: 2), () async {
      try {
        await ref.read(authRepositoryProvider).refreshToken();
        loggy.info('Refresh token found!');
        ref.read(goRouterProvider).go(AppRoute.home.path);
      } catch (error, _) {
        loggy.info('Refresh token not found! Error: $error');
        ref.read(goRouterProvider).go(AppRoute.auth.path);
      }
    });
  }
}
