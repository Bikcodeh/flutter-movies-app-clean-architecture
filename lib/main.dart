import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import 'app/data/repository/authentication_repository_impl.dart';
import 'app/data/repository/connectivity_repository_impl.dart';
import 'app/data/service/remote/authentication_api.dart';
import 'app/data/service/remote/internet_checker.dart';
import 'app/domain/common/http/network.dart';
import 'app/domain/repository/authentication_repository.dart';
import 'app/domain/repository/connectivity_repository.dart';
import 'app/movies_app.dart';

void main() {
  runApp(Injector(
    connectivityRepository: ConnectivityRepositoryImpl(
      Connectivity(),
      InternetChecker(),
    ),
    authenticationRepository: AuthenticationRepositoryImpl(
      const FlutterSecureStorage(),
      AuthenticationApi(
        Http(
          baseUrl: 'https://api.themoviedb.org/3',
          apiKey: '4662e7a7fe13c9d91c80552e10a09dc1',
          client: Client(),
        ),
      ),
    ),
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
