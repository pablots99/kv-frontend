import 'package:flutter/material.dart';
import 'package:kv/src/models/product_model.dart';
import 'package:kv/src/providers/product_provider.dart';

class HomePage extends StatelessWidget {
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
          preferredSize: Size.fromHeight(40), child: AppBar(title: Text('KV'))),
      body: _ptoductList(),
      floatingActionButton: _createButton(context),
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

  Widget _createButton(BuildContext context) {
    if (homeArgs != null && homeArgs > 1) {
      showSnackbar(homeArgs);
    }
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).buttonColor,
        onPressed: () => Navigator.pushNamed(context, 'newProduct'));
  }

  Widget _createProductItem(ProductModel product, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      child: ListTile(
        title: Text('${product.title} - ${product.prize}'),
        subtitle: Text('${product.id}'),
        onTap: () =>
            Navigator.pushNamed(context, 'product', arguments: product),
      ),
      onDismissed: (direction) {
        //delete product
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
