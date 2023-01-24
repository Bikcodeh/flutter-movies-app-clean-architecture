import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/data/providers/provider_factory.dart';
import 'app/movies_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ProviderFactory.provideAuthenticationRepository(),
        ProviderFactory.provideConnectivityRepository(),
      ],
      child: const MoviesApp(),
    ),
  );
}
