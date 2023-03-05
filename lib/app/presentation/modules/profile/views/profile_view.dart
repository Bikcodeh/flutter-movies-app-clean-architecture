import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/theme_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SwitchListTile(
            value: themeController.darkMode,
            onChanged: ((value) => themeController.onChanged(value)),
          )
        ],
      ),
    );
  }
}
