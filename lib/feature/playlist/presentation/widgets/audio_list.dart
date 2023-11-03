part of '../playlist_page.dart';

class _AudioList extends ConsumerWidget with UiLoggy {
  const _AudioList({
    required this.audioCollection,
  });

  final AudioCollection audioCollection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        playlistControllerProvider(audioCollection: audioCollection);
    final watcher = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    return watcher.when(
      data: (details) {
        if (controller.getGroups().isEmpty) {
          return _AudioListWithoutGroups(controller: controller);
        }
        return _AudioListWithGroups(controller: controller);
      },
      error: (_, __) => const Center(
        child: Text(
          'Por favor realize o login para ter acesso ao conteúdo!',
          textAlign: TextAlign.center,
          softWrap: true,
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _AudioListRow extends StatelessWidget {
  const _AudioListRow({
    required this.detail,
    required this.onPressed,
  });

  final Audio detail;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            height: 32,
            child: CupertinoButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.play_arrow_solid,
                size: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              detail.title ?? '',
              softWrap: true,
              maxLines: 2,
              style: context.textTheme.bodyMedium?.apply(
                fontWeightDelta: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
