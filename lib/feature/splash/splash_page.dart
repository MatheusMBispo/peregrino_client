import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:peregrino/core/ui/logo/app_logo.dart';
import 'package:peregrino/feature/splash/splash_controller.dart';

class SplashPage extends ConsumerWidget with UiLoggy {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashControllerProvider);
    return const Scaffold(
      body: Center(
        child: AppLogo(),
      ),
    );
  }
}
