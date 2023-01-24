import 'package:firebase_test/pages/add_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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
                ),
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
                      child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/1024px-Facebook_Logo_%282019%29.png')),
                  onTap: () async {
                    final fb = FacebookLogin();
                    final res = await fb.logIn(permissions: [
                      FacebookPermission.publicProfile,
                      FacebookPermission.email,
                    ]);
                    switch (res.status) {
                      case FacebookLoginStatus.success:
                        // Logged in

                        // Send access token to server for validation and auth
                        final FacebookAccessToken? accessToken =
                            res.accessToken;
                        print('Access token: ${accessToken?.token}');

                        // Get profile data
                        final profile = await fb.getUserProfile();
                        print(
                            'Hello, ${profile?.name}! You ID: ${profile?.userId}');

                        // Get user profile image url
                        final imageUrl =
                            await fb.getProfileImageUrl(width: 100);
                        print('Your profile image: $imageUrl');

                        // Get email (since we request email permission)
                        final email = await fb.getUserEmail();
                        // But user can decline permission
                        if (email != null) print('And your email is $email');

                        break;
                      case FacebookLoginStatus.cancel:
                        // User cancel log in
                        break;
                      case FacebookLoginStatus.error:
                        // Log in failed
                        print('Error while log in: ${res.error}');
                        break;
                    }
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
