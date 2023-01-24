import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/common/http/error.dart';
import '../../../../domain/repository/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../controller/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInController(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(builder: (context) {
                final signInController =
                    Provider.of<SignInController>(context, listen: true);
                return AbsorbPointer(
                  absorbing: signInController.fetching,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (text) =>
                              signInController.onUsernameChange(text),
                          decoration: const InputDecoration(
                            labelText: 'Username *',
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? text) {
                            return (text != null && text.isEmpty)
                                ? 'Required'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (text) =>
                              signInController.onPasswordChange(text),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password *',
                          ),
                          validator: (String? text) {
                            text = text?.replaceAll(' ', '') ?? '';
                            if (text.isEmpty) {
                              return 'Password required';
                            } else if (text.length < 4) {
                              return 'Password must be at least 4 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        signInController.fetching
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final isValid =
                                        Form.of(context)!.validate();
                                    if (isValid) {
                                      _submit(context);
                                    }
                                  },
                                  child: const Text('Sign in'),
                                ),
                              ),
                      ]),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final SignInController signInController = context.read();
    signInController.setFetching(true);
    final result = await context.read<AuthenticationRepository>().signIn(
          signInController.username,
          signInController.password,
        );
    if (!mounted) {
      return;
    }
    result.fold((failure) {
      signInController.setFetching(false);
      final message = {
        Failure.notFound: 'Not found.',
        Failure.unauthorized: 'User unauthorized.',
        Failure.unknown: 'An unknow error ocurred.',
        Failure.connectivity: 'Network connection error'
      }[failure];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message!)),
      );
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}
