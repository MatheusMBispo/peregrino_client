part of '../playlist_page.dart';

class _Header extends StatelessWidget {
  const _Header({
    required this.audioCollection,
    required this.onStartPressed,
  });

  final AudioCollection audioCollection;
  final void Function() onStartPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageThumbnail(
            imageUrl: audioCollection.imageUrl ?? '',
            backgroundImageUrl: audioCollection.backgroundImage ?? '',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    audioCollection.title ?? '-',
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    audioCollection.author ?? '-',
                    style: context.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  _StartButton(
                    audioCollection: audioCollection,
                    onPressed: onStartPressed,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton({required this.audioCollection, required this.onPressed});

  final AudioCollection audioCollection;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final duration =
        Duration(seconds: (audioCollection.chaptersDuration ?? 0).toInt())
            .format();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.play_arrow_solid,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Iniciar',
                style: context.textTheme.bodyMedium,
              ),
            ),
            Text(
              duration,
              style: context.textTheme.bodyMedium?.apply(
                color: context.theme.disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButton(
          onPressed: () => context.pop(),
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.back,
            color: context.colorScheme.onBackground,
          ),
        ),
        CupertinoButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.info,
            color: context.colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
