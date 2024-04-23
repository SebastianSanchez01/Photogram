import 'package:flutter/material.dart';
import 'package:photo_gram/auth_service.dart';
import 'package:photo_gram/home_page.dart';
import 'package:photo_gram/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Success')));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (HomePage())));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                ),
                Icon(Icons.camera, size: 80),
                SizedBox(
                  height: 50,
                ),
                Text("Welcome to Photogram Login or Register below"),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Email",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Password",
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => signIn(),
                  child: Text("Sign In"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text("Register"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
