import 'package:blue_controller_companion/extensions/build_context_extension.dart';
import 'package:blue_controller_companion/features/auth/data/provider/user_provider.dart';
import 'package:blue_controller_companion/features/auth/data/repository/auth_repository.dart';
import 'package:blue_controller_companion/features/auth/domain/login_input_model.dart';
import 'package:blue_controller_companion/features/auth/presentation/widgets/login_form_card.dart';
import 'package:blue_controller_companion/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, boxConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: boxConstraints.maxHeight,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 80,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Blue controller companion",
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 100),
                      SizedBox(
                        width: 400,
                        child: MyLoginFormCard(
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                      ),
                      const SizedBox(height: 48),
                      FilledButton(
                        onPressed: () => _onSignInButtonPressed(
                          context,
                          ref,
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                        child: const Text("Sign in"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onSignInButtonPressed(
    BuildContext context,
    WidgetRef ref, {
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    final loginInput = LoginInputModel(
      email: emailController.text,
      password: passwordController.text,
    );
    try {
      final user =
          await ref.read(authRepositoryProvider).signIn(loginInput: loginInput);
      final userId = user.id;
      if (userId == null) throw Exception("No user");
      await ref.read(userProvider(id: userId).future);
      if (!context.mounted) return;
      const ControllerConfigurationListScreenRoute().go(context);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
