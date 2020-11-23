import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kv/src/block/provider.dart';
import 'package:kv/src/models/product_model.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int homeArgs = 0;

  @override
  Widget build(BuildContext context) {
    final productbloc = Provider.productsBloc(context);
    productbloc.loadProducts();
    homeArgs = ModalRoute.of(context).settings.arguments;
    homeArgs = (homeArgs == null) ? 0 : homeArgs;
    print(homeArgs);
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: AppBar(title: Text('Home'))),
      body: _ptoductList(productbloc),
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

  Widget _showPhoto(ProductModel product, BuildContext context) {
    if (product.urlPhoto != null) {
      return Container(
        child: CachedNetworkImage(
          imageUrl: product.urlPhoto,
          height: MediaQuery.of(context).size.height / 5,
          placeholder: (context, url) => Image(
            image: AssetImage('assets/Spinner-1s-800px.gif'),
            height: MediaQuery.of(context).size.height / 5,
          ),
        ),
      );
    } else {
      return Image(
        image: AssetImage('assets/no_image.png'),
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 3,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _createProductItem(
      ProductModel product, BuildContext context, ProductsBloc productsBloc) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: 5),
          GestureDetector(
            child: _showPhoto(product, context),
            onTap: () =>
                Navigator.pushNamed(context, 'product', arguments: product),
          ),
          ListTile(
            title: Text('${product.prize} €'),
            subtitle: Text('${product.title}'),
            onTap: () =>
                Navigator.pushNamed(context, 'product', arguments: product),
          ),
        ],
      ),
    );
  }

  Widget _ptoductList(ProductsBloc productsBloc) {
    return StreamBuilder(
      stream: productsBloc.productStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return RefreshIndicator(
            onRefresh: () {},
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 0,
                    childAspectRatio:
                        MediaQuery.of(context).size.height / 1200),
                itemCount: products.length,
                itemBuilder: (context, i) {
                  return _createProductItem(products[i], context, productsBloc);
                }),
          );
        } else {
          return Center(
            child: Image(
              image: AssetImage('assets/Spinner-1s-800px.gif'),
              height: MediaQuery.of(context).size.height / 1200,
            ),
          );
        }
      },
    );
  }

  Future<void> _onRefresh(ProductsBloc productsBloc) async {
    await productsBloc.loadProducts();
  }
}
