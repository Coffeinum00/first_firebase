import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/auth/data/providers/auth_state.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _signUp = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.flutter_dash)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                          .hasMatch(_emailController.text)) {
                        return 'Please enter a valid e-mail';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8) {
                        return 'Password need to be 8 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _signUp
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthState>(context, listen: false)
                                  .signOnWithEmail(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());
                            }
                          }
                        : () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthState>(context, listen: false)
                                  .signInWithEmail(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());
                            }
                          },
                    child: Text(_signUp ? 'Sign up' : 'Log in'),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _signUp = !_signUp;
                      });
                    },
                    child: Text(!_signUp ? 'Sign up' : 'Log in'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
