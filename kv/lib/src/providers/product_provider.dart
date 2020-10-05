import 'dart:convert';

import 'package:kv/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  final String _url = "https://kv-backend-fba39.firebaseio.com";
  //insert Product
  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json';
    final resp = await http.post(url, body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  //get Product
  Future<List<ProductModel>> loadProducts() async {
    final url = '$_url/products.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = new List();
    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;
      products.add(prodTemp);
    });
    return products;
  }

  //delete Product
  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    await http.delete(url);
    return 1;
  }

  //mod Product
  Future<bool> modProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json';
    final resp = await http.put(url, body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }
}
