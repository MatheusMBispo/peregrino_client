import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/feature/auth/repository/auth_repository.dart';
import 'package:peregrino/feature/playlist/model/audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_network_data_source.g.dart';

class PlaylistNetworkDataSource with RepositoryLoggy {
  PlaylistNetworkDataSource({
    required this.client,
    required this.authRepository,
  });

  final http.Client client;
  final baseURI = 'peregrino-app.appspot.com';
  final AuthRepository authRepository;

  Future<List<Audio>> loadBy({required String? id}) async {
    if (id == null) {
      throw Exception('Failed to load audio collection details');
    }
    final uri = Uri.https(baseURI, '/api/v1/audio-progress/collections/$id');
    final token = await authRepository.getToken();
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final audioCollectionJson = json.decode(response.body) as List<dynamic>;
      final audioCollectionList = audioCollectionJson
          .map(
            (json) => Audio.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      return audioCollectionList;
    } else {
      throw Exception('Failed to load audio collection details');
    }
  }
}

@riverpod
PlaylistNetworkDataSource playlistNetworkDataSource(
  PlaylistNetworkDataSourceRef ref,
) {
  return PlaylistNetworkDataSource(
    client: http.Client(),
    authRepository: ref.read(authRepositoryProvider),
  );
}
