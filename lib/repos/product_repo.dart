import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/product.dart';

class ProductRepository {
  final productCollection = FirebaseFirestore.instance.collection("products");

  Future<void> create(Product product) async {

    final uid = productCollection.doc().id;
    final docRef = productCollection.doc(uid);
    final newProduct = Product(name: product.name, id: uid, price: product.price);
    try {
      await docRef.set(newProduct.toMap());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> get() async {
    List<Product> productList = [];

    try {
      final productCollection = await FirebaseFirestore.instance.collection("products").get();
      productCollection.docs.forEach((element) {
        return productList.add(Product.fromMap(element.data()));
      });
      return productList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return productList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<void> update(Product product) async {


  //   final docRef = productCollection.doc(product.id);
  //   final newProduct = Product(name: product.name, id: product.id, price: product.price);
  //   try {
  //     await docRef.update(newProduct.toMap());
  //   } on FirebaseException catch (e) {
  //     if (kDebugMode) {
  //       print("Failed with error '${e.code}': ${e.message}");
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  Future<void> delete(Product product) async {
    await productCollection.doc(product.id).delete();
  }

}
