import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_test/model/model.dart';
import 'package:firebase_test/pages/control_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              imagePath == null
                  ? const SizedBox.shrink()
                  : Image.file(File(imagePath!)),
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
                keyboardType: const TextInputType.numberWithOptions(),
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
                  onPressed: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    imagePath = image?.path;
                    setState(() {});
                  },
                  child: const Text("Add Image form gallery")),
              ElevatedButton(
                  onPressed: () async {
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    imagePath = photo?.path;
                    setState(() {});
                  },
                  child: const Text("Add Image")),
              ElevatedButton(
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    final storageRef = FirebaseStorage.instance
                        .ref()
                        .child("productImage/${DateTime.now().toString()}");
                    await storageRef.putFile(File(imagePath ?? ""));

                    String url = await storageRef.getDownloadURL();

                    firestore
                        .collection("product")
                        .add(ProductModel(
                                name: nameController.text.toLowerCase(),
                                desc: descController.text,
                                price: priceController.text,
                                image: url,
                                year: yearController.text)
                            .toJson())
                        .then((value) {
                      isLoading = false;
                      setState(() {});
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ControlPage()),
                          (route) => false);
                    });
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
