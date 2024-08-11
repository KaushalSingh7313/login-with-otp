// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:login_with_otp/otp_with.dart';
// // import 'package:login_with_otp/phone _login.dart';
// //
// // class with_otp extends StatefulWidget {
// //   const with_otp({super.key});
// //
// //   @override
// //   State<with_otp> createState() => _with_otpState();
// // }
// //
// // class _with_otpState extends State<with_otp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: StreamBuilder(
// //         stream: FirebaseAuth.instance.authStateChanges(),
// //         builder: (context,snapshot){
// //           if (snapshot.hasData){
// //             return otp_with();
// //           }else{
// //             return phone_login();
// //           }
// //
// //         }
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'otp_with.dart';
//
// class PhoneLogin extends StatefulWidget {
//   const PhoneLogin({super.key});
//
//   @override
//   State<PhoneLogin> createState() => _PhoneLoginState();
// }
//
// class _PhoneLoginState extends State<PhoneLogin> {
//   final TextEditingController _phoneController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String _verificationId = '';
//
//   void _sendOtp() async {
//     final phoneNumber = _phoneController.text.trim();
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await _auth.signInWithCredential(credential);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         // Handle errors here
//         print('Verification failed: ${e.message}');
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         _verificationId = verificationId;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpVerification(verificationId: verificationId),
//           ),
//         );
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Phone Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(labelText: 'Enter phone number'),
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _sendOtp,
//               child: Text('Send OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otp_with.dart';

class ProfilePage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  BuildContext get context =>null!;
  void _signOut() async {
    // await _auth.signOut();
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => LoginPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Profile'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Profile Details'),
              onTap: () {
                // Handle profile details tap
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: _signOut,
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome ${user?.email ?? 'User'}'),
      ),
    );
  }
}


