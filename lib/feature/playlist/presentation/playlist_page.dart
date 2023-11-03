import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:peregrino/core/extension/context.dart';
import 'package:peregrino/core/extension/duration.dart';
import 'package:peregrino/core/ui/image/image_thumbnail.dart';
import 'package:peregrino/feature/audio_player/presentation/audio_player.dart';
import 'package:peregrino/feature/audio_player/presentation/audio_player_controller.dart';
import 'package:peregrino/feature/home/model/audio_collection.dart';
import 'package:peregrino/feature/playlist/model/audio.dart';
import 'package:peregrino/feature/playlist/presentation/playlist_controller.dart';

part 'widgets/audio_list.dart';
part 'widgets/audio_list_grouped.dart';
part 'widgets/audio_list_ungrouped.dart';
part 'widgets/audio_page_header.dart';

class PlaylistPage extends ConsumerWidget {
  const PlaylistPage({
    required this.audioCollection,
    super.key,
  });

  final AudioCollection audioCollection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        playlistControllerProvider(audioCollection: audioCollection);
    final controller = ref.read(provider.notifier);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.colorScheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _AppBar(),
                    const SizedBox(height: 24),
                    _Header(
                      audioCollection: audioCollection,
                      onStartPressed: () {
                        // ignore: inference_failure_on_function_invocation
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (context) {
                            return AudioPlayer(
                              audioIndex: 0,
                              audios: controller.getLoadedAudios(),
                            );
                          },
                        ).whenComplete(() {
                          ref
                              .read(
                                audioPlayerControllerProvider(
                                  index: 0,
                                  audios: controller.getLoadedAudios(),
                                ).notifier,
                              )
                              .pause();
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: _AudioList(audioCollection: audioCollection),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
