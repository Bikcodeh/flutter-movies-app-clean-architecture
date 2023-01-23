import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../utils/extension/context.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome'),
          TextButton(
            onPressed: () {
              context.injector.authenticationRepository.signOut();
              Navigator.pushReplacementNamed(context, Routes.signIn);
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
