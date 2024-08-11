// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// //
// // class otp_with extends StatefulWidget {
// //   const otp_with({super.key});
// //
// //   @override
// //   State<otp_with> createState() => _otp_withState();
// // }
// //
// // class _otp_withState extends State<otp_with> {
// //   final user=FirebaseAuth.instance.currentUser;
// //
// //   signout()async{
// //     await FirebaseAuth.instance.signOut();
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Optwith"),),
// //       body: Center(
// //         child: Text('${user!.email}'),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed:(()=>signout()),
// //         child: Icon(Icons.login_rounded),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class OtpVerification extends StatefulWidget {
//   final String verificationId;
//
//   const OtpVerification({super.key, required this.verificationId});
//
//   @override
//   State<OtpVerification> createState() => _OtpVerificationState();
// }
//
// class _OtpVerificationState extends State<OtpVerification> {
//   final TextEditingController _otpController = TextEditingController();
//
//   void _verifyOtp() async {
//     final otp = _otpController.text.trim();
//     final credential = PhoneAuthProvider.credential(
//       verificationId: widget.verificationId,
//       smsCode: otp,
//     );
//     try {
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       // Navigate to the next screen after successful authentication
//     } catch (e) {
//       print('OTP verification failed: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Verify OTP')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _otpController,
//               decoration: InputDecoration(labelText: 'Enter OTP'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _verifyOtp,
//               child: Text('Verify OTP'),
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

class LoginWithPhone extends StatefulWidget {
  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final _auth = FirebaseAuth.instance;
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  String _verificationId = '';
  bool _isPhoneAuth = true;

  void _loginWithPhone() async {
    if (_phoneController.text.isEmpty) {
      // Show error message if phone number is empty
      _showErrorDialog('Please enter your phone number.');
      return;
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        // Navigate to the main screen or another screen here
      },
      verificationFailed: (FirebaseAuthException e) {
        _showErrorDialog(e.message ?? 'Verification failed.');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _verifyOtp() async {
    if (_otpController.text.isEmpty) {
      _showErrorDialog('Please enter the OTP.');
      return;
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _otpController.text,
    );
    try {
      await _auth.signInWithCredential(credential);
      // Navigate to the main screen or another screen here
    } catch (e) {
      _showErrorDialog('OTP verification failed.');
    }
  }

  void _loginWithEmail() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog('Please enter email and password.');
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to the main screen or another screen here
    } catch (e) {
      _showErrorDialog('Email login failed.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _isPhoneAuth
                ? Column(
              children: <Widget>[
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loginWithPhone,
                  child: Text('Send OTP'),
                ),
                TextField(
                  controller: _otpController,
                  decoration: InputDecoration(labelText: 'OTP'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _verifyOtp,
                  child: Text('Verify OTP'),
                ),
              ],
            )
                : Column(
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loginWithEmail,
                  child: Text('Login with Email'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isPhoneAuth = !_isPhoneAuth;
                });
              },
              child: Text(
                _isPhoneAuth ? 'Login with Email' : 'Login with Phone',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
