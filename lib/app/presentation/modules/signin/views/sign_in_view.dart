import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/sign_in_controller.dart';
import '../controller/state/sign_in_state.dart';
import '../widgets/form_field_password.dart';
import '../widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInController(
        const SignInState(
          username: '',
          password: '',
          fetching: false,
          success: false,
        ),
        authenticationRepository: context.read(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(builder: (context) {
                final signInController =
                    Provider.of<SignInController>(context, listen: true);
                return AbsorbPointer(
                  absorbing: signInController.state.fetching,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (text) =>
                              signInController.onUsernameChange(text),
                          decoration: const InputDecoration(
                            labelText: 'Username *',
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? text) {
                            return (text != null && text.isEmpty)
                                ? 'Required'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const FormFielPassword(),
                        const SizedBox(
                          height: 20,
                        ),
                        const SubmitButton()
                      ]),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
