import 'package:firebase_test/pages/add_number.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      var data = await googleSignIn.signIn();
                      print('id ${data?.id}');
                      print('id ${data?.email}');
                      print('id ${data?.photoUrl}');
                      print(data?.displayName);
                      image = data?.photoUrl ?? '';
                      setState(() {});
                      googleSignIn.signOut();
                    } catch (e) {
                      print('error: $e');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0x30858C94),
                    ),
                    child: Image.network(
                      'https://companieslogo.com/img/orig/GOOG-0ed88f7c.png?t=1633218227',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                !image.isNotEmpty
                    ? const SizedBox.shrink()
                    : Image.network(image),
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0x30858C94),
                      ),
                      child: const Icon(Icons.sms)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (a) => const Addnumber(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
