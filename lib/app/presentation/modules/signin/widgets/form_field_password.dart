import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/sign_in_controller.dart';

class FormFielPassword extends StatefulWidget {
  const FormFielPassword({super.key});

  @override
  State<FormFielPassword> createState() => _FormFielPasswordState();
}

class _FormFielPasswordState extends State<FormFielPassword> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Provider.of(context);
    return TextFormField(
      obscureText: _showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (text) => signInController.onPasswordChange(text),
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Password *',
          suffixIcon: IconButton(
            onPressed: () => _toggleVisibilityPassword(),
            icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
          )),
      validator: (String? text) {
        text = text?.replaceAll(' ', '') ?? '';
        if (text.isEmpty) {
          return 'Password required';
        } else if (text.length < 4) {
          return 'Password must be at least 4 characters';
        }
        return null;
      },
    );
  }

  void _toggleVisibilityPassword() {
    _showPassword = !_showPassword;
    setState(() {});
  }
}
