import 'package:blue_controller_companion/features/auth/data/repository/user_repository.dart';
import 'package:blue_controller_companion/features/auth/domain/user_credential_model.dart';
import 'package:blue_controller_companion/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blue_controller_companion/extensions/build_context_extension.dart';
import 'package:blue_controller_companion/features/auth/presentation/widgets/password_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
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
                        child: MySignUpFormCard(
                          emailController: emailController,
                          usernameController: usernameController,
                          passwordController: passwordController,
                        ),
                      ),
                      const SizedBox(height: 48),
                      FilledButton(
                        onPressed: () => _onSignUpButtonPressed(
                          context,
                          ref,
                          emailController: emailController,
                          usernameController: usernameController,
                          passwordController: passwordController,
                        ),
                        child: const Text("Sign up"),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {
                          const LoginScreenRoute().go(context);
                        },
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

  Future<void> _onSignUpButtonPressed(
    BuildContext context,
    WidgetRef ref, {
    required TextEditingController emailController,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) async {
    final userCredential = UserCredentialModel(
      email: emailController.text,
      username: usernameController.text,
      password: passwordController.text,
    );
    try {
      await ref
          .read(userRepositoryProvider)
          .createUser(userCredential: userCredential);
      if (!context.mounted) return;
      const LoginScreenRoute().go(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          content: Text("Account created"),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          content: Text(e.toString()),
        ),
      );
    }
  }
}

class MySignUpFormCard extends ConsumerWidget {
  const MySignUpFormCard({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Username",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            PasswordTextField(
              controller: passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
