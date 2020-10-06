import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kv/src/models/product_model.dart';
import 'package:kv/src/providers/product_provider.dart';

class ProductListPage extends StatelessWidget {
  final productProvider = new ProductProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int homeArgs = 0;
  @override
  Widget build(BuildContext context) {
    homeArgs = ModalRoute.of(context).settings.arguments;
    homeArgs = (homeArgs == null) ? 0 : homeArgs;
    print(homeArgs);
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: AppBar(title: Text('Home'))),
      body: _ptoductList(),
    );
  }

  void showSnackbar(int n) {
    String msg;
    if (n == 1) {
      msg = 'uploaded';
    } else
      msg = 'nose';
    final snackbar = SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _showPhoto(ProductModel product) {
    if (product.urlPhoto != null) {
      return Container(
        child: CachedNetworkImage(
          imageUrl: product.urlPhoto,
          height: 200,
          placeholder: (context, url) => Image(
            image: AssetImage('assets/Spinner-1s-800px.gif'),
            height: 100,
          ),
        ),
      );
    } else {
      return Image(
        image: AssetImage('assets/no_image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _createProductItem(ProductModel product, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      child: Column(
        children: [
          GestureDetector(
            child: _showPhoto(product),
            onTap: () =>
                Navigator.pushNamed(context, 'product', arguments: product),
          ),
          ListTile(
            title: Text('${product.title} - ${product.prize}'),
            subtitle: Text('${product.id}'),
            onTap: () =>
                Navigator.pushNamed(context, 'product', arguments: product),
          ),
        ],
      ),
      onDismissed: (direction) {
        //delete product
        //productProvider.deleteImage(product.urlPhoto);
        productProvider.deleteProduct(product.id);
      },
    );
  }

  Widget _ptoductList() {
    return FutureBuilder(
      future: productProvider.loadProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) {
                return _createProductItem(products[i], context);
              });
        } else {
          return Center(
            child: Image(
              image: AssetImage('assets/Spinner-1s-800px.gif'),
              height: 130.0,
            ),
          );
        }
      },
    );
  }
}
