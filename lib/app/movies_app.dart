import 'package:flutter/material.dart';

import 'presentation/routes/movies_routes.dart';
import 'presentation/routes/routes.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.splash,
      routes: appRoutes,
    );
  }
}
