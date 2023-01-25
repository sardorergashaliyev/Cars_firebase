import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/model/model.dart';
import 'package:firebase_test/pages/add_product.dart';
import 'package:firebase_test/widget/image_network.dart';
import 'package:flutter/material.dart';

class GetProductPage extends StatefulWidget {
  const GetProductPage({Key? key}) : super(key: key);

  @override
  State<GetProductPage> createState() => _GetProductPageState();
}

class _GetProductPageState extends State<GetProductPage> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<ProductModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder(
        future: fireStore.collection("product").get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            list.clear();
            // ignore: avoid_function_literals_in_foreach_calls
            snapshot.data?.docs.forEach((element) {
              list.add(ProductModel.fromJson(element));
            });
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Row(
                        children: [
                          CustomImageNetwork(image: list[index].image),
                          Column(
                            children: [
                              Text(list[index].name),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  list[index].desc,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Text(list[index].price.toString()),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddProductPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
