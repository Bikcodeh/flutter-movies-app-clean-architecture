import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repository/authentication_repository.dart';
import '../../../routes/routes.dart';

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
              context.read<AuthenticationRepository>().signOut();
              Navigator.pushReplacementNamed(context, Routes.signIn);
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
