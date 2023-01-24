import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app/data/repository/authentication_repository_impl.dart';
import 'app/data/repository/connectivity_repository_impl.dart';
import 'app/data/service/remote/authentication_api.dart';
import 'app/data/service/remote/internet_checker.dart';
import 'app/domain/common/http/network.dart';
import 'app/domain/repository/authentication_repository.dart';
import 'app/domain/repository/connectivity_repository.dart';
import 'app/movies_app.dart';

void main() {
  runApp(
    Provider<ConnectivityRepository>(
      create: ((context) => ConnectivityRepositoryImpl(
            Connectivity(),
            InternetChecker(),
          )),
      child: Provider<AuthenticationRepository>(
        create: (context) => AuthenticationRepositoryImpl(
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
      ),
    ),
  );
}
