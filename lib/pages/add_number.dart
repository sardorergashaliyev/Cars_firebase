import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Addnumber extends StatefulWidget {
  const Addnumber({super.key});

  @override
  State<Addnumber> createState() => _AddnumberState();
}

class _AddnumberState extends State<Addnumber> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Icon(Icons.sms),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: textEditingController,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: IconButton(
        color: Colors.blue,
        icon: const Icon(Icons.add),
        onPressed: () async {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: textEditingController.text,
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {},
            codeSent: (String verificationId, int? resendToken) {},
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        },
      ),
    );
  }
}
