import 'package:flutter/widgets.dart';

import '../modules/favorites/views/favorite_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/signin/views/sign_in_view.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.offline: (context) => const OfflineView(),
    Routes.favorite: (context) => const FavoritesView(),
    Routes.profile: (context) => const ProfileView(),
  };
}
