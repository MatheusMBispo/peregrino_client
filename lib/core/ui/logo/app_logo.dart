import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox.fromSize(
        size: const Size.fromRadius(64),
        child: Image.asset('assets/images/peregrino.png'),
      ),
    );
  }
}
