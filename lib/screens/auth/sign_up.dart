import 'package:flutter/material.dart';

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
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _signUp ? () {} : () {},
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
