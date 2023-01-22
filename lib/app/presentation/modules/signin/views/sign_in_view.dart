import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (text) => {
                  setState((() {
                    _username = text.trim().toLowerCase();
                  }))
                },
                decoration: const InputDecoration(
                  labelText: "Username *",
                  border: OutlineInputBorder(),
                ),
                validator: (String? text) {
                  return (text != null && text.isEmpty) ? 'Required' : null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (text) => {
                  setState((() {
                    _password = text.replaceAll(' ', '').toLowerCase();
                  }))
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password *",
                ),
                validator: (String? text) {
                  text = text?.replaceAll(' ', '') ?? '';
                  if (text.isEmpty) {
                    return 'Password required';
                  } else if (text.length < 4) {
                    return 'Password must be at least 4 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Builder(builder: (context) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final isValid = Form.of(context)!.validate();
                      if (isValid) {}
                    },
                    child: const Text('Sign in'),
                  ),
                );
              })
            ]),
          ),
        ),
      ),
    );
  }
}
