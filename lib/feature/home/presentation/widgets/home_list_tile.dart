part of '../home_page.dart';

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.audioCollection,
  });

  final AudioCollection audioCollection;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ListTileImage(url: audioCollection.imageUrl ?? ''),
          const SizedBox(width: 16),
          Expanded(
            child: _ListTileContent(audioCollection: audioCollection),
          ),
        ],
      ),
    );
  }
}

class _ListTileContent extends StatelessWidget {
  const _ListTileContent({
    required this.audioCollection,
  });

  final AudioCollection audioCollection;

  @override
  Widget build(BuildContext context) {
    final duration =
        Duration(seconds: (audioCollection.chaptersDuration ?? 0).toInt())
            .format();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          audioCollection.title ?? '-',
          softWrap: true,
          maxLines: 2,
          textAlign: TextAlign.start,
          style: context.textTheme.titleSmall,
        ),
        Text(
          audioCollection.author ?? '-',
          textAlign: TextAlign.start,
          style: context.textTheme.bodySmall,
        ),
        const Spacer(),
        RichText(
          text: TextSpan(
            text: 'Duração: ',
            style: context.textTheme.bodySmall?.apply(fontWeightDelta: 8),
            children: [
              TextSpan(
                text: duration,
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
