import 'package:flutter/material.dart';
import 'package:petition/Colors/Colors.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //Email Field
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Email Address';
                    } else if (!value.contains('@')) {
                      return 'Enter a Valid Email Address including "@"';
                    } else if (!value.contains('.')) {
                      return 'Enter a Valid Email Address including "."';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label: Text('Email')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password Missing';
                    }
                    return null;
                  },
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label: Text('Password')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    print('Handle Appropriate changes if the form is validate');
                  }
                },
                //Log In Button
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: colors.buttonColor),
                  width: width / 5,
                  height: height / 15,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              const Text(
                'Forgot Password?',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          )),
    );
  }
}
