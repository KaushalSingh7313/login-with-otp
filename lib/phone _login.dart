// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:login_with_otp/phone _login.dart';
// class phone_login extends StatefulWidget {
//   const phone_login({super.key});
//
//   @override
//   State<phone_login> createState() => _phone_loginState();
// }
//
// class _phone_loginState extends State<phone_login> {
//   TextEditingController email= TextEditingController();
//   TextEditingController password= TextEditingController();
//   TextEditingController phonenumber= TextEditingController();
//   TextEditingController Password= TextEditingController();
//
//   signIn() async {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
//     await FirebaseAuth.instance.signInWithEmailAndPassword(email: phonenumber.text, password: Password.text);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     appBar:AppBar(title: Text("login"),
//     ),
//       body:Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           TextField(
//             controller: email,
//             decoration: InputDecoration(hintText:"Enter email"   ),
//           ),
//           TextField(
//             controller: email,
//             decoration: InputDecoration(hintText:"Enter phone password"   ),
//           ),
//           TextField(
//             controller: email,
//             decoration: InputDecoration(hintText:"Enter phone number"   ),
//           ),
//           TextField(
//             controller: password ,
//             decoration: InputDecoration(hintText:"Enter password"),
//           ),
//
//           ElevatedButton(onPressed: null, child: Text('login',style: TextStyle(color: Colors.black),))
//
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailRegister extends StatefulWidget {
  const EmailRegister({super.key});

  @override
  State<EmailRegister> createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // Navigate to the next screen after successful registration
    } catch (e) {
      print('Registration failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Enter email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Enter password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}





