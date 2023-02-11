import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../domain/repository/authentication_repository.dart';
import '../../domain/repository/connectivity_repository.dart';
import '../../domain/repository/movie_repository.dart';
import '../../domain/repository/trending_repository.dart';
import '../../presentation/global/controllers/favorites/favorites_controller.dart';
import '../../presentation/global/controllers/favorites/state/favorites_state.dart';
import '../../presentation/global/controllers/session_controller.dart';
import '../repository/account_repository_impl.dart';
import '../repository/authentication_repository_impl.dart';
import '../repository/connectivity_repository_impl.dart';
import '../repository/movie_repository_impl.dart';
import '../repository/trending_repository_impl.dart';
import '../service/local/session_service.dart';
import '../service/remote/apis/account_api.dart';
import '../service/remote/apis/authentication_api.dart';
import '../service/remote/apis/movie_api.dart';
import '../service/remote/apis/trending_api.dart';
import '../service/remote/http/network.dart';
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

  static Provider provideTrendingRepository() {
    return Provider<TrendingRepository>(
      create: (context) => TrendingRepositoryImpl(
        TrendingApi(_http),
      ),
    );
  }

  static Provider provideMovieRepository() {
    return Provider<MovieRepository>(
      create: (context) => MovieRepositoryImpl(
        MovieApi(_http),
      ),
    );
  }

  static ChangeNotifierProvider provideSessionControllerNotifier() {
    return ChangeNotifierProvider<SessionController>(
      create: (context) => SessionController(
        authenticationRepository: context.read(),
      ),
    );
  }

  static ChangeNotifierProvider provideFavoritesControllerNotifier() {
    return ChangeNotifierProvider<FavoritesController>(
      create: (context) => FavoritesController(FavoritesState.loading()),
    );
  }
}
