import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutter/constants/routes.dart';
import 'package:note_flutter/services/auth/auth_exceptions.dart';
import 'package:note_flutter/services/auth/auth_service.dart';
import 'package:note_flutter/services/auth/bloc/auth_bloc.dart';
import 'package:note_flutter/services/auth/bloc/auth_event.dart';
import 'package:note_flutter/services/auth/bloc/auth_state.dart';
import 'package:note_flutter/utils/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
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
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) async {
                      if (state is AuthStateLoggedOut) {
                        if (state.exception is UserNotFoundAuthException) {
                          await showErrorDialog(context, 'User not found');
                        } else if (state.exception
                            is WrongPasswordAuthException) {
                          await showErrorDialog(
                            context,
                            "Wrong credentials",
                          );
                        } else if (state.exception is GenericAuthException) {
                          await showErrorDialog(
                            context,
                            "Authentication error",
                          );
                        }
                      }
                    },
                    child: TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        context.read<AuthBloc>().add(
                              AuthEventLogin(
                                email,
                                password,
                              ),
                            );
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute,
                        (route) => false,
                      );
                    },
                    child: const Text("Not Registered yet? Register here!"),
                  )
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
