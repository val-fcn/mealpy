import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../services/user_data_services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        await AuthServices().signInWithEmailAndPassword(
          userEmailController.text,
          userPasswordController.text,
        );
      } else {
        await AuthServices().signUpWithEmailAndPassword(
          userEmailController.text,
          userPasswordController.text,
        );
        await UserDataService().createUserData(
          userId: FirebaseAuth.instance.currentUser?.uid,
          email: userEmailController.text,
          username: userNameController.text,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (_isLogin == false)
                      TextFormField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          label: Text('Nom d\'utilisateur'),
                          icon: Icon(Icons.person),
                        ),
                        validator: (userNameValue) {
                          if (userNameValue == null ||
                              userNameValue.trim().isEmpty ||
                              userNameValue.trim().length < 3) {
                            return 'Veuillez saisir au moins 3 caractères.';
                          }
                          return null;
                        },
                      ),
                    TextFormField(
                      controller: userEmailController,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                        icon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (emailValue) {
                        if (emailValue == null || emailValue.isEmpty) {
                          return 'veuillez indiquer votre email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: userPasswordController,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                        icon: Icon(
                          Icons.lock,
                        ),
                      ),
                      obscureText: true,
                      validator: (passwordValue) {
                        if (passwordValue == null || passwordValue.isEmpty) {
                          return 'veuillez indiquer un mot de passe';
                        }
                        if (passwordValue.trim().length < 6) {
                          return '6 caractères minimum';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: onSubmit,
                      child: Text(
                        !_isLogin ? 'Créer mon compte' : 'Me connecter',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        !_isLogin ? 'J\'ai déjà un compte' : 'Créer un compte',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
