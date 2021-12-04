import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './validators_auth.dart';
import './signup_screen.dart';
import '../../services/auth_service.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(child: Text(' Login')),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => ValidarorsAuth.emailValidator(value!),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => ValidarorsAuth.passwordValidator(value!),
              ),
              const SizedBox(
                height: 25,
              ),
              loading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            User? result = await AuthService.login(
                                emailController.text,
                                passwordController.text,
                                context);
                            setState(() {
                              loading = false;
                            });

                            if (result != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                              setState(() {
                                loading = true;
                              });
                            }
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text('Don\'t have an account? Register Here'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
