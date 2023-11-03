part of '../home_page.dart';

class _ListTileImage extends StatelessWidget {
  const _ListTileImage({
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) =>
          _DownloadedImage(imageProvider: imageProvider),
      placeholder: (context, _) => const _LoadingImage(),
      errorWidget: (context, url, error) => const ImagePlaceholder(),
    );
  }
}

class _LoadingImage extends StatelessWidget {
  const _LoadingImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      height: 70,
      child: DottedBorder(
        strokeCap: StrokeCap.square,
        dashPattern: const [6],
        strokeWidth: 1.2,
        borderType: BorderType.RRect,
        color: context.theme.disabledColor,
        radius: const Radius.circular(8),
        child: Center(
          child: SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              color: context.theme.disabledColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _DownloadedImage extends StatelessWidget {
  const _DownloadedImage({
    required this.imageProvider,
  });

  final ImageProvider<Object> imageProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      height: 70,
      child: Image(
        image: imageProvider,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
