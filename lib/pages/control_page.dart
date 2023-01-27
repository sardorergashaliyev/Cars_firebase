import 'package:firebase_test/pages/chats_page.dart';
import 'package:firebase_test/pages/home_page.dart';
import 'package:firebase_test/pages/product_page.dart';
import 'package:firebase_test/pages/profile_page.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  int index = 0;

  List pages = [
    const MyHomePage(),
    const GetProductPage(),
    const ChatsPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_travel), label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.sms), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
