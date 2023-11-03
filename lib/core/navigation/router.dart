import 'package:go_router/go_router.dart';
import 'package:peregrino/core/navigation/route.dart';
import 'package:peregrino/feature/auth/presentation/auth_page.dart';
import 'package:peregrino/feature/home/model/audio_collection.dart';
import 'package:peregrino/feature/home/presentation/home_page.dart';
import 'package:peregrino/feature/playlist/presentation/playlist_page.dart';
import 'package:peregrino/feature/splash/splash_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.auth.path,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoute.playlist.path,
        builder: (context, state) {
          final audioCollection = state.extra;
          if (audioCollection == null) {
            throw UnimplementedError();
          }
          return PlaylistPage(
            audioCollection: audioCollection as AudioCollection,
          );
        },
      ),
    ],
  );
}
