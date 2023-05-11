import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final _googleSignIn = GoogleSignIn(
    scopes: [
      'openid',
      'profile',
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
      // 'https://www.googleapis.com/auth/userinfo.profile'
    ],
    // serverClientId:
    //     '1061087383163-fs1fv5agdpe0a0kin2k89vuk17atiaiq.apps.googleusercontent.com',
    clientId:
        '1061087383163-qmgljg5hrrh4jk1j4imf2r9rhfcrcc9t.apps.googleusercontent.com');

Future<void> _configureGoogleSignIn() async {
  GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  print("Printing google user info");
  print(googleAuth.accessToken);
  print(googleUser.displayName);
  print(googleAuth.idToken);
  print('##########################################');
  Future<Map<String, String>> myFuture = googleUser.authHeaders;

  myFuture.then(
    (Map<String, String> myMap) {
      String myString = "";
      myMap.forEach((key, value) {
        myString += "$key:$value\n";
        print(myString);
      });
    },
  );
  print('*******************************************');

  // String token = 'example';
  // myFuture.then((Map<String, String> keys) {
  //   String? authorization = keys['Authorization'];
  //   print(authorization);
  // });
}

Future<void> _handleGoogleSignIn() async {
  print('call handle function');
  try {
    await _configureGoogleSignIn();

    // final user = _googleSignIn.currentUser;
    // if (user == null) {
    //   print('there is no user');
    //   throw Exception('Google sign-in failed.');
    // } else {
    //   print('there is a user');
    // }

    // Obtain the user's ID token.
    // final authentication = await user.authentication;
    // final idToken = authentication.idToken;
    // print(idToken);
  } catch (e) {
    print(e);
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Screen'),
        actions: [
          TextButton(
            onPressed: () {
              _googleSignIn.disconnect();
              print('Logged Out');
            },
            child: const Text(
              'Log out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: const Center(
        child: ElevatedButton(
          onPressed: _handleGoogleSignIn,
          child: Text('Sign Up with Google'),
        ),
      ),
    );
  }
}
