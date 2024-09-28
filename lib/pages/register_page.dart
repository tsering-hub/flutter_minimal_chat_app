import 'package:flutter/material.dart';
import 'package:flutter_minimal_chat_app/services/auth/auth_service.dart';
import 'package:flutter_minimal_chat_app/components/my_button.dart';
import 'package:flutter_minimal_chat_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;

  // email and pw controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _cpwController = TextEditingController();

  RegisterPage({super.key, this.onTap});

  // register method
  void register(BuildContext context) async {
    final authService = AuthService();

    if (_pwController.text == _cpwController.text) {
      try {
        await authService.signUpWithEmailAndPassword(
            _emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("password don't match !"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              // logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: 50,
              ),
              // welcome back message
              Text(
                "Register",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
              SizedBox(
                height: 25,
              ),
              // email textfield
              MyTextfield(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              SizedBox(
                height: 10,
              ),
              // pw textfield
              MyTextfield(
                hintText: 'Password',
                obscureText: true,
                controller: _pwController,
              ),
              SizedBox(
                height: 25,
              ),
              // cc pw textfield
              MyTextfield(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _cpwController,
              ),
              SizedBox(
                height: 25,
              ),
              // loign button
              MyButton(
                text: 'Register',
                onTap: () => register(context),
              ),
              SizedBox(
                height: 25,
              ),
              // register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have a account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
