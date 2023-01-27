import 'package:firebase_test/model/model.dart';
import 'package:firebase_test/widget/image_network.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  final ProductModel info;

  const ProductPage({
    super.key,
    required this.info,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int buyCount = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                CustomImageNetwork(
                    height: 300,
                    width: double.infinity,
                    image: widget.info.image),
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 80,
                      height: 50,
                      margin: const EdgeInsets.only(left: 20, top: 60),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                            color: const Color.fromARGB(255, 103, 103, 103),
                          ),
                          color: const Color.fromARGB(255, 130, 130, 130)
                              .withOpacity(0.3)),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 22, top: 12),
              child: Text(
                widget.info.name,
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Describtion",
                    style: GoogleFonts.raleway(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 34),
                  child: Text(
                    widget.info.year,
                    style: GoogleFonts.raleway(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 94, 93, 93)),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 24, top: 5, right: 24),
              child: Text(
                widget.info.desc,
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: const Color.fromARGB(255, 100, 100, 100),
                    letterSpacing: 0.5,
                    height: 1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 150, top: 20, bottom: 10),
              child: Text('Price: \$${widget.info.price}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700)),
            )
          ],
        ),
      ),
    );
  }
}
