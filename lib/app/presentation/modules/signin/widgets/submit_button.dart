import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';
import '../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Provider.of(context);

    return Builder(builder: (context) {
      return Container(
        child: signInController.state.fetching
            ? const CircularProgressIndicator()
            : SizedBox(
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
              ),
      );
    });
  }

  Future<void> _submit(BuildContext context) async {
    final SignInController signInController = Provider.of(
      context,
      listen: false,
    );
    final SessionController sessionController = context.read();
    await signInController.submit();

    if (!signInController.mounted) {
      return;
    }
    if (signInController.state.success == true) {
      sessionController.setUser(signInController.state.user!);
      Navigator.pushReplacementNamed(context, Routes.home);
    }

    if (signInController.state.errorMessage != null &&
        !signInController.state.fetching) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(signInController.state.errorMessage!)),
      );
    }
  }
}
