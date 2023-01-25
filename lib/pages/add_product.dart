import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/model/model.dart';
import 'package:firebase_test/pages/product_page.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: "Price",
              ),
            ),
            TextFormField(
              controller: yearController,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                labelText: "Year",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  firestore
                      .collection("product")
                      .add(ProductModel(
                              name: nameController.text,
                              desc: descController.text,
                              price: priceController.text,
                              year: yearController.text)
                          .toJson())
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GetProductPage()),
                        (route) => false);
                  });
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
