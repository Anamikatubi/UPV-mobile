import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upv_mobile/service_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Map<String, dynamic> jsonMap;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 236, 241, 244),
            Color.fromARGB(255, 26, 61, 122)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 50),
            _inputField("userid", usernameController),
            const SizedBox(height: 20),
            _inputField("password", passwordController, isPassword: true),
            const SizedBox(height: 50),
            _loginBox(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBox() {
    return ElevatedButton(
        onPressed: () {
          loginUser();
        },
        child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue,
            backgroundColor: const Color.fromARGB(255, 228, 226, 226),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16)));
  }

  loginUser() async {
    print("username : " + usernameController.text);
    print("password : " + passwordController.text);
    final username = usernameController.text;
    final password = passwordController.text;
    var response = await login(
      json.encode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      jsonMap = json.decode(response.body);
      print(jsonMap);
    }
  }
}
