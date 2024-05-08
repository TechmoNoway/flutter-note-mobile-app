import 'package:flutter/material.dart';
import 'package:note_flutter/constants/routes.dart';
import 'package:note_flutter/services/auth/auth_exceptions.dart';
import 'package:note_flutter/services/auth/auth_service.dart';
import 'package:note_flutter/utils/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    // enableSuggestions: false,
                    // autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Enter your email here'),
                  ),
                  TextField(
                    controller: _password,
                    decoration: const InputDecoration(
                      hintText: "Enter your password here",
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        AuthService.firebase().createUser(
                          email: email,
                          password: password,
                        );
                        AuthService.firebase().sendEmailVerification();
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                      } on WeakPasswordAuthException {
                        showErrorDialog(context, "Week password");
                      } on EmailAlreadyInUseAuthException {
                        showErrorDialog(context, "Email is already in use");
                      } on InvalidEmailAuthException {
                        showErrorDialog(context, "Invalid email entered");
                      } on GenericAuthException {
                        showErrorDialog(context, "Failed to register");
                      }
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      },
                      child: const Text("Already registered? Login here!"))
                ],
              );
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
