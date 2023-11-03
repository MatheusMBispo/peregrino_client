import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:peregrino/core/extension/context.dart';
import 'package:peregrino/core/ui/input/input_field.dart';
import 'package:peregrino/core/ui/logo/app_logo.dart';
import 'package:peregrino/feature/auth/presentation/auth_controller.dart';

class AuthPage extends HookConsumerWidget with UiLoggy {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    ref.listen(authControllerProvider, (_, state) {
      if (!state.isLoading && state.hasError) {
        _showAlertDialog(context);
      }
    });

    return GestureDetector(
      onTap: () {
        _dismissKeyboard(context);
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: AppLogo(),
                ),
                const SizedBox(height: 24),
                InputField.email(
                  label: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                InputField.password(
                  label: 'Senha',
                  controller: passwordController,
                ),
                const SizedBox(height: 16),
                if (state.isLoading) ...[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ] else ...[
                  CupertinoButton(
                    color: context.colorScheme.primary,
                    onPressed: () {
                      _dismissKeyboard(context);

                      if (!(formKey.value.currentState?.validate() ?? false)) {
                        return;
                      }
                      context.closeKeyboard();

                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      controller.login(email: email, password: password);
                    },
                    child: Text(
                      'Login',
                      style: context.textTheme.bodyLarge?.apply(
                        color: context.colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton(
                    color: CupertinoColors.systemIndigo,
                    onPressed: () {
                      controller.anonymousLogin();
                      _dismissKeyboard(context);
                    },
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Continuar sem Login\n(Não é possível ouvir os audio books)',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.apply(
                        color: context.colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dismissKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Algo errado aconteceu!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Nosso dev tá cansado, segura as pontas, aguarde alguns instantes! :)',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
