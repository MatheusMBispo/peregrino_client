import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/feature/home/model/audio_collection.dart';
import 'package:peregrino/feature/playlist/model/audio.dart';
import 'package:peregrino/feature/playlist/repository/playlist_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_controller.g.dart';

@riverpod
class PlaylistController extends _$PlaylistController with ControllerLoggy {
  late final PlaylistRepository _repository;

  @override
  Future<List<Audio>> build({
    required AudioCollection audioCollection,
  }) async {
    _repository = ref.read(playlistRepositoryProvider);
    return _repository.loadById(audioCollection.id ?? '');
  }

  List<AudioGroup> getGroups() {
    return _repository.getGroups();
  }

  List<Audio> getAudiosBy({required AudioGroup group}) {
    return _repository.getBy(group: group);
  }

  List<Audio> getLoadedAudios() {
    return _repository.getLoaded();
  }
}
