import 'package:collection/collection.dart';
import 'package:peregrino/feature/auth/repository/auth_repository.dart';
import 'package:peregrino/feature/home/data_source/audio_collection_network_data_source.dart';
import 'package:peregrino/feature/home/model/audio_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_collection_repository.g.dart';

class AudioCollectionRepository {
  AudioCollectionRepository({
    required this.networkDatasource,
    required this.authRepository,
  });

  List<AudioCollection> _loadedAudioCollections = [];
  AudioCollectionNetworkDataSource networkDatasource;
  AuthRepository authRepository;

  Future<List<AudioCollection>> getAudioBooks() async {
    if (await authRepository.isLogged()) {
      return _loadedAudioCollections =
          await networkDatasource.getAllAudioBooks();
    }

    return _loadedAudioCollections =
        await networkDatasource.getFreeAudioBooks();
  }

  AudioCollection? getAudioById(String id) {
    return _loadedAudioCollections.firstWhereOrNull(
      (element) => element.id == id,
    );
  }
}

@riverpod
AudioCollectionRepository audioCollectionRepository(
  AudioCollectionRepositoryRef ref,
) {
  return AudioCollectionRepository(
    networkDatasource: ref.read(audioCollectionNetworkDataSourceProvider),
    authRepository: ref.read(
      authRepositoryProvider,
    ),
  );
}
