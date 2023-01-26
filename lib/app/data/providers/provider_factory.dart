import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../domain/common/http/network.dart';
import '../../domain/repository/authentication_repository.dart';
import '../../domain/repository/connectivity_repository.dart';
import '../repository/account_repository_impl.dart';
import '../repository/authentication_repository_impl.dart';
import '../repository/connectivity_repository_impl.dart';
import '../service/local/session_service.dart';
import '../service/remote/account_api.dart';
import '../service/remote/authentication_api.dart';
import '../service/remote/internet_checker.dart';

class ProviderFactory {
  static final SessionService _sessionService = SessionService(
    const FlutterSecureStorage(),
  );

  static final Http _http = Http(
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: '4662e7a7fe13c9d91c80552e10a09dc1',
    client: Client(),
  );

  static final AccountApi _accountApi = AccountApi(_http);

  static Provider provideAuthenticationRepository() {
    return Provider<AuthenticationRepository>(
      create: (context) => AuthenticationRepositoryImpl(
        _sessionService,
        AuthenticationApi(_http),
        AccountRepositoryImpl(_accountApi, _sessionService),
      ),
    );
  }

  static Provider provideConnectivityRepository() {
    return Provider<ConnectivityRepository>(
      create: (context) => ConnectivityRepositoryImpl(
        Connectivity(),
        InternetChecker(),
      ),
    );
  }
}
