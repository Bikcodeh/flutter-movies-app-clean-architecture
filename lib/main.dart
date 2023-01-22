import 'package:flutter/material.dart';

import 'app/data/repository/authentication_repository_impl.dart';
import 'app/data/repository/connectivity_repository_impl.dart';
import 'app/domain/repository/authentication_repository.dart';
import 'app/domain/repository/connectivity_repository.dart';
import 'app/movies_app.dart';

void main() {
  runApp(Injector(
    connectivityRepository: ConnectivityRepositoryImpl(),
    authenticationRepository: AuthenticationRepositoryImpl(),
    child: const MoviesApp(),
  ));
}

class Injector extends InheritedWidget {
  const Injector({
    super.key,
    required super.child,
    required this.authenticationRepository,
    required this.connectivityRepository,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  // ignore: avoid_renaming_method_parameters
  bool updateShouldNotify(_) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}
