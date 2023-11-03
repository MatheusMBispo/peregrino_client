part of '../playlist_page.dart';

class _AudioListWithGroups extends ConsumerWidget {
  const _AudioListWithGroups({
    required this.controller,
  });

  final PlaylistController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: ListView.builder(
        itemCount: controller.getGroups().length,
        itemBuilder: (context, index) {
          final group = controller.getGroups()[index];
          final groupDetails = controller.getAudiosBy(group: group);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _AudioListSection(group: group),
              const SizedBox(height: 16),
              for (final (index, detail) in groupDetails.indexed) ...[
                _AudioListRow(
                  detail: detail,
                  // ignore: inference_failure_on_function_invocation
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return AudioPlayer(
                        audioIndex: index,
                        audios: controller.getLoadedAudios(),
                      );
                    },
                  ).whenComplete(() {
                    ref
                        .read(
                          audioPlayerControllerProvider(
                            index: index,
                            audios: controller.getLoadedAudios(),
                          ).notifier,
                        )
                        .pause();
                  }),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _AudioListSection extends StatelessWidget {
  const _AudioListSection({
    required this.group,
  });

  final AudioGroup group;

  @override
  Widget build(BuildContext context) {
    return Text(
      group.title ?? '',
      style: context.textTheme.bodyMedium?.apply(
        color: Colors.white,
        fontWeightDelta: 3,
      ),
    );
  }
}
