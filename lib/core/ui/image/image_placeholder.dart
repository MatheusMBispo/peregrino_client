import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:peregrino/core/extension/context.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

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
          child: Icon(
            Icons.warning,
            color: context.theme.disabledColor,
          ),
        ),
      ),
    );
  }
}
