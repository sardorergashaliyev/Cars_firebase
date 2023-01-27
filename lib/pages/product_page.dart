import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_test/model/model.dart';
import 'package:firebase_test/pages/add_product.dart';
import 'package:firebase_test/pages/info_page.dart';
import 'package:firebase_test/widget/image_network.dart';
import 'package:firebase_test/widget/on_unfocused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;

class GetProductPage extends StatefulWidget {
  const GetProductPage({Key? key}) : super(key: key);

  @override
  State<GetProductPage> createState() => _GetProductPageState();
}

class _GetProductPageState extends State<GetProductPage> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<ProductModel> list = [];
  List listOfDoc = [];
  QuerySnapshot? data;
  bool isLoading = true;

  Future<void> getInfo({String? text}) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("fcm: $fcmToken");

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("onBackgroundMessage");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage");
    });

    isLoading = true;
    setState(() {});
    if (text == null) {
      data = await fireStore.collection("product").get();
    } else {
      data = await fireStore
          .collection("product")
          .orderBy("name")
          .startAt([text]).endAt(["$text\uf8ff"]).get();
    }
    list.clear();
    listOfDoc.clear();
    // ignore: avoid_function_literals_in_foreach_calls
    for (QueryDocumentSnapshot element in data?.docs ?? []) {
      list.add(ProductModel.fromJson(element));
      listOfDoc.add(element.id);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OnUnFocusTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Search"),
                  onChanged: (s) {
                    getInfo(text: s);
                  },
                  autofocus: false,
                ),
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (a) =>
                                        ProductPage(info: list[index]),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 10, left: 12, right: 12),
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 220, 231, 232),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomImageNetwork(
                                        image: list[index].image),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              list[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              list[index].desc,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50),
                                                child: Text(
                                                  '\$${list[index].price.toString()}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 102, 102, 102)),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    print(list.length);
                                                    print(listOfDoc.length);
                                                    fireStore
                                                        .collection("product")
                                                        .doc(listOfDoc[index])
                                                        .delete()
                                                        .then(
                                                          (doc) => print(
                                                              "Document deleted"),
                                                          onError: (e) => print(
                                                              "Error updating document $e"),
                                                        );
                                                    list.removeAt(index);
                                                    listOfDoc.removeAt(index);
                                                    print(list.length);
                                                    print(listOfDoc.length);
                                                    setState(() {});
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete)),
                                              IconButton(
                                                  onPressed: () async {
                                                    const productLink =
                                                        'https://github.com/sardorergashaliyev';

                                                    const dynamicLink =
                                                        'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyDkhdvbYRbWQgnUGfqJThNEWj13U8Al9YQ';

                                                    final dataShare = {
                                                      "dynamicLinkInfo": {
                                                        "domainUriPrefix":
                                                            'https://authlessonnewonlyfirestore.page.link',
                                                        "link": productLink,
                                                        "androidInfo": {
                                                          "androidPackageName":
                                                              'com.example.auth_lesson_new_only_firestore',
                                                        },
                                                        "iosInfo": {
                                                          "iosBundleId":
                                                              "com.example.authLessonNewOnlyFirestore",
                                                        },
                                                        "socialMetaTagInfo": {
                                                          "socialTitle":
                                                              list[index].name,
                                                          "socialDescription":
                                                              "Year: ${list[index].year}",
                                                          "socialImageLink":
                                                              list[index].image,
                                                        }
                                                      }
                                                    };

                                                    final res = await http.post(
                                                        Uri.parse(dynamicLink),
                                                        body: jsonEncode(
                                                            dataShare));

                                                    var shareLink = jsonDecode(
                                                        res.body)['shortLink'];
                                                    await FlutterShare.share(
                                                      text: "Cars",
                                                      title: "Buy new cars",
                                                      linkUrl: shareLink,
                                                    );

                                                    print(shareLink);
                                                  },
                                                  icon: const Icon(
                                                    Icons.share,
                                                    color: Colors.black,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddProductPage()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
