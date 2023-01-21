import 'package:flutter/widgets.dart';
import 'package:movies_app_flutter/app/presentation/modules/splash/views/splash_view.dart';
import 'package:movies_app_flutter/app/presentation/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {Routes.splash: (context) => const SplashView()};
}
