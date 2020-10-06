import 'dart:convert';
import 'dart:io';
import 'package:kv/src/user_config/user_config.dart';
import 'package:mime_type/mime_type.dart';
import 'package:kv/src/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductProvider {
  final String _url = "https://kv-backend-fba39.firebaseio.com";
  final _config = new UserConfig();

  //insert Product

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json?auth=${_config.token}';
    final resp = await http.post(url, body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  //get Product
  Future<List<ProductModel>> loadProducts() async {
    final url = '$_url/products.json?auth=${_config.token}';
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
    final url = '$_url/products/$id.json?auth=${_config.token}';
    await http.delete(url);
    return 1;
  }

  //mod Product
  Future<bool> modProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json?auth=${_config.token}';
    final resp = await http.put(url, body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<String> uploadImage(File image) async {
    if (_config.token != null) {
      final url = Uri.parse(
          'https://api.cloudinary.com/v1_1/dvs17jblc/image/upload?upload_preset=o9j8nyr5');
      final mimeType = mime(image.path).split('/');

      final imageUploadRequest = http.MultipartRequest('POST', url);
      final file = await http.MultipartFile.fromPath('file', image.path,
          contentType: MediaType(mimeType[0], mimeType[1]));
      imageUploadRequest.files.add(file);
      final streamResponse = await imageUploadRequest.send();
      final res = await http.Response.fromStream(streamResponse);

      if (res.statusCode != 200 && res.statusCode != 201) {
        print('Algo salio mal');
        print(res.body);
        return null;
      }
      final resData = json.decode(res.body);
      return resData['secure_url'];
    }
  }

  Future<int> deleteImage(String path) async {
    final url = Uri.parse(path);
    http.delete(url);
    return 1;
  }
}
