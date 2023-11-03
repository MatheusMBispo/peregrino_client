import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/feature/home/model/audio_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_collection_network_data_source.g.dart';

class AudioCollectionNetworkDataSource with ProviderLoggy {
  AudioCollectionNetworkDataSource({
    required this.client,
  });

  final http.Client client;
  final baseURI = 'peregrino-app.appspot.com';

  Future<List<AudioCollection>> getAllAudioBooks() async {
    final queryParameters = <String, dynamic>{
      'filter': '{"status": 1,"type": 0}',
      'sort': '{"updatedAt": -1}',
    };
    final uri = Uri.https(baseURI, '/api/v1/audio-collection', queryParameters);
    final response = await http.get(uri);
    loggy.info("Pegando livros pagos");
    if (response.statusCode == 200) {
      final audioCollectionJson = json.decode(response.body) as List<dynamic>;
      final audioCollectionList = audioCollectionJson
          .map((json) => AudioCollection.fromJson(json as Map<String, dynamic>))
          .toList();
      return audioCollectionList;
    } else {
      throw Exception('Failed to load audio collection');
    }
  }

  Future<List<AudioCollection>> getFreeAudioBooks() async {
    final queryParameters = <String, dynamic>{
      'filter': '{"status": 1,"type": 0}',
      'isFree': 'true',
      'sort': '{"updatedAt": -1}',
    };
    loggy.info("Pegando livros free");
    final uri = Uri.https(baseURI, '/api/v1/audio-collection', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final audioCollectionJson = json.decode(response.body) as List<dynamic>;
      final audioCollectionList = audioCollectionJson
          .map((json) => AudioCollection.fromJson(json as Map<String, dynamic>))
          .toList();
      return audioCollectionList;
    } else {
      throw Exception('Failed to load audio collection');
    }
  }
}

@riverpod
AudioCollectionNetworkDataSource audioCollectionNetworkDataSource(
  AudioCollectionNetworkDataSourceRef ref,
) {
  return AudioCollectionNetworkDataSource(client: http.Client());
}
