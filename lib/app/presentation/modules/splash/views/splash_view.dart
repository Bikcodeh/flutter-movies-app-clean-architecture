import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repository/authentication_repository.dart';
import '../../../../domain/repository/connectivity_repository.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  Future<void> _init() async {
    final connectivityRepository = context.read<ConnectivityRepository>();
    final authenticationRepository = context.read<AuthenticationRepository>();
    final sessionContraoller = context.read<SessionController>();
    final hasInternet = await connectivityRepository.hasInternet;
    if (hasInternet) {
      final isSignedIn = await authenticationRepository.isSignedIn;
      if (isSignedIn) {
        final user = await authenticationRepository.getUserData();
        if (user != null) {
          sessionContraoller.setUser(user);
          _goTo(Routes.home);
        } else {
          _goTo(Routes.signIn);
        }
      } else if (mounted) {
        _goTo(Routes.signIn);
      }
    } else {
      _goTo(Routes.offline);
    }
  }

  void _goTo(String route) {
    Navigator.pushReplacementNamed(
      context,
      route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
