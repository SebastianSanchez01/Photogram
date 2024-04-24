import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:photo_gram/backend/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:photo_gram/screens/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:photo_gram/backend/utils.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  Uint8List? _image;

  void signUp() async {
    final authService = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      if (emailController.text.isNotEmpty ||
          passwordController.text.isNotEmpty ||
          usernameController.text.isNotEmpty ||
          bioController.text.isNotEmpty) {
        await authService.auth.signUpWithEmailAndPassword(
            emailController.text,
            passwordController.text,
            usernameController.text,
            bioController.text,
            _image!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Registration Success you may now login",
        )));

        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              Icon(Icons.camera, size: 80),
              SizedBox(
                height: 50,
              ),
              Text(
                  "Register Page: Click on the icon to add your profile picture"),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.red,
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                AssetImage('assets/images/default.png'),
                            backgroundColor: Colors.red,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Username",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: bioController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Bio",
                ),
              ),
              SizedBox(height: 15),
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
                height: 15,
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
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () => signUp(), child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
