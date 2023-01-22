import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextFormField(
            controller: textEditingController,
            keyboardType: TextInputType.number,
          ),
        ),
      ),
      floatingActionButton: IconButton(
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
