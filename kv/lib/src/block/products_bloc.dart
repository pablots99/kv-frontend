import 'dart:io';

import 'package:kv/src/models/product_model.dart';
import 'package:kv/src/providers/product_provider.dart';
import 'package:rxdart/subjects.dart';

class ProductsBloc {
  final _productsConttroller = new BehaviorSubject<List<ProductModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _productsProvider = new ProductProvider();

  Stream<List<ProductModel>> get productStream => _productsConttroller;
  Stream<bool> get loading => _loadingController;

  void loadProducts() async {
    final products = await _productsProvider.loadProducts();
    _productsConttroller.sink.add(products);
  }

  void createProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    _productsProvider.createProduct(product);
    _loadingController.sink.add(false);
  }

  Future uploadPhoto(File foto) async {
    _loadingController.sink.add(true);
    final fotoUrl = await _productsProvider.uploadImage(foto);
    _loadingController.sink.add(false);
    return fotoUrl;
  }

  void modProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    _productsProvider.modProduct(product);
    _loadingController.sink.add(false);
  }

  void delProduct(String id) async {
    await _productsProvider.deleteProduct(id);
  }

  dispose() {
    _productsConttroller?.close();
    _loadingController?.close();
  }
}
