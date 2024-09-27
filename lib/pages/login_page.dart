import 'package:flutter/material.dart';
import 'package:flutter_minimal_chat_app/auth/auth_service.dart';
import 'package:flutter_minimal_chat_app/components/my_button.dart';
import 'package:flutter_minimal_chat_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;

  // email and pw controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  LoginPage({super.key, this.onTap});

  // login method
  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              "Welcome Back",
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
            // loign button
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),
            SizedBox(
              height: 25,
            ),
            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register Now",
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
    );
  }
}
