import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  GoogleSignIn _googleSignIn = GoogleSignIn();
                  var data = await _googleSignIn.signIn();
                  print(data?.id);
                  print(data?.email);
                  print(data?.photoUrl);
                  print(data?.displayName);
                  _googleSignIn.signOut();
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Google Sign'),
            ),
          ),
        ],
      ),
    );
  }
}