part of '../playlist_page.dart';

class _AudioListWithoutGroups extends ConsumerWidget {
  const _AudioListWithoutGroups({
    required this.controller,
  });

  final PlaylistController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audios = controller.getLoadedAudios();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: ListView.builder(
        itemCount: audios.length,
        itemBuilder: (context, index) {
          return _AudioListRow(
            detail: audios[index],
            // ignore: inference_failure_on_function_invocation
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) {
                return AudioPlayer(
                  audioIndex: index,
                  audios: audios,
                );
              },
            ).whenComplete(
              () {
                ref
                    .read(
                      audioPlayerControllerProvider(
                        index: index,
                        audios: audios,
                      ).notifier,
                    )
                    .pause();
              },
            ),
          );
        },
      ),
    );
  }
}
