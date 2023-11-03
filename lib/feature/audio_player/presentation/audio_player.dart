import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peregrino/core/extension/context.dart';
import 'package:peregrino/core/ui/image/image_thumbnail.dart';
import 'package:peregrino/feature/audio_player/presentation/audio_player_controller.dart';
import 'package:peregrino/feature/playlist/model/audio.dart';

class AudioPlayer extends HookConsumerWidget {
  const AudioPlayer({
    required this.audioIndex,
    required this.audios,
    super.key,
  });

  final int audioIndex;
  final List<Audio> audios;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = audioPlayerControllerProvider(
      index: audioIndex,
      audios: audios,
    );

    ref.watch(provider);
    final controller = ref.read(provider.notifier);
    final currentDetail = controller.getCurrentDetail();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.6,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 180,
                      child: ImageThumbnail(
                        imageUrl: currentDetail?.imageUrl ?? '',
                        backgroundImageUrl:
                            currentDetail?.backgroundImage ?? '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      child: Text(
                        currentDetail?.title ?? 'Not Found!',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ActionButton(
                          onTap: controller.goPrevious,
                          iconData: Icons.skip_previous_rounded,
                        ),
                        _ActionButton(
                          onTap: controller.toggle,
                          iconData: controller.currentIcon(),
                        ),
                        _ActionButton(
                          onTap: controller.goNext,
                          iconData: Icons.skip_next_rounded,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ProgressBar(
                      progress: controller.currentDuration,
                      total: controller.totalDuration(),
                      onSeek: controller.seek,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.onTap,
    required this.iconData,
  });

  final IconData iconData;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: context.colorScheme.primary,
        child: Icon(
          iconData,
          size: 32,
        ),
      ),
    );
  }
}
