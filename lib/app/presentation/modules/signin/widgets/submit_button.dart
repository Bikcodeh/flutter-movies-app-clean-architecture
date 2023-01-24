import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/common/http/error.dart';
import '../../../../domain/repository/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Provider.of(context);
    if (signInController.fetching) {
      return const CircularProgressIndicator();
    }
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final isValid = Form.of(context)!.validate();
          if (isValid) {
            _submit(context);
          }
        },
        child: const Text('Sign in'),
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
    if (!signInController.mounted) {
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
