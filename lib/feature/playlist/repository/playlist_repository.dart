import 'package:collection/collection.dart';
import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/feature/playlist/data_source/playlist_network_data_source.dart';
import 'package:peregrino/feature/playlist/model/audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_repository.g.dart';

class PlaylistRepository with RepositoryLoggy {
  PlaylistRepository({
    required this.networkDataSource,
  });

  final PlaylistNetworkDataSource networkDataSource;
  List<Audio> _playlist = [];

  Audio? getByIndex(int index) {
    return _playlist.elementAtOrNull(index);
  }

  Future<List<Audio>> loadById(String id) async {
    final details = await networkDataSource.loadBy(id: id);
    return _playlist = details;
  }

  List<Audio> getLoaded() {
    return _playlist;
  }

  List<AudioGroup> getGroups() {
    return _playlist.firstOrNull?.groups ?? [];
  }

  List<Audio> getBy({required AudioGroup group}) {
    final details = <Audio>[];
    for (final id in group.audioIds ?? []) {
      final detail = _playlist.firstWhereOrNull((element) => element.id == id);
      if (detail == null) {
        continue;
      }

      details.add(detail);
    }

    return details;
  }
}

@riverpod
PlaylistRepository playlistRepository(PlaylistRepositoryRef ref) {
  return PlaylistRepository(
    networkDataSource: ref.read(playlistNetworkDataSourceProvider),
  );
}
