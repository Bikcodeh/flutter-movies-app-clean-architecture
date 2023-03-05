import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/theme_controller.dart';
import '../../../global/extensions/build_context_ext.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SwitchListTile(
            value: context.darkMode,
            onChanged: ((value) =>
                context.read<ThemeController>().onChanged(value)),
          )
        ],
      ),
    );
  }
}
