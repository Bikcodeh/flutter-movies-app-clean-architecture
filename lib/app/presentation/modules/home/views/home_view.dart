import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repository/authentication_repository.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = context.read();
    final user = sessionController.state;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${user!.username}'),
            TextButton(
              onPressed: () {
                context.read<AuthenticationRepository>().signOut();
                sessionController.signOut();
                Navigator.pushReplacementNamed(context, Routes.signIn);
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
