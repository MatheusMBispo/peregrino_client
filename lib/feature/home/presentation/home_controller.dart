import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/core/navigation/route.dart';
import 'package:peregrino/core/navigation/router.dart';
import 'package:peregrino/feature/auth/repository/auth_repository.dart';
import 'package:peregrino/feature/home/model/audio_collection.dart';
import 'package:peregrino/feature/home/repository/audio_collection_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
@riverpod
class HomeController extends _$HomeController with ControllerLoggy {
  List<AudioCollection> allAudioCollections = [];

  @override
  Future<List<AudioCollection>> build() async {
    loggy.info('HomeController initiated');
    state = const AsyncValue.loading();
    try {
      allAudioCollections =
          await ref.read(audioCollectionRepositoryProvider).getAudioBooks();
    } catch (error, stackTrace) {
      loggy.error(error.toString(), error, stackTrace);
      state = AsyncValue.error(error, stackTrace);
    }
    return allAudioCollections;
  }

  void searchBy({required String searchText}) {
    final filteredAudioCollections = allAudioCollections
        .where(
          (element) =>
              element.title?.toLowerCase().contains(searchText.toLowerCase()) ??
              false,
        )
        .toList();
    state = AsyncValue.data(filteredAudioCollections);
  }

  void onTap({required AudioCollection audioCollection}) {
    ref
        .read(goRouterProvider)
        .push(AppRoute.playlist.path, extra: audioCollection);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    ref.read(goRouterProvider).go(AppRoute.auth.path);
  }
}
