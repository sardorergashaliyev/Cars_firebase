import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String name;
  final String desc;
  final String price;
  final String year;
  final String image;

  ProductModel( 
      {required this.name,
      required this.desc,
      this.image = 'https://media.istockphoto.com/id/1357365823/vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo.jpg?s=612x612&w=0&k=20&c=PM_optEhHBTZkuJQLlCjLz-v3zzxp-1mpNQZsdjrbns=',
      required this.price,
      required this.year});

  factory ProductModel.fromJson(QueryDocumentSnapshot data) {
    return ProductModel(
        name: data["name"],
        desc: data["description"],
        price: data["price"],
        year: data['year'],
        image: data["image"]
        );
  }

  toJson() {
    return {"name": name, "description": desc, "price": price, "year": year, "image": image};
  }
}
