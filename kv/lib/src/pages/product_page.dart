import 'package:flutter/material.dart';
import 'package:kv/src/utils/utils.dart' as utils;
import 'package:kv/src/models/product_model.dart';
import 'package:kv/src/block/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  ProductModel product = new ProductModel();
  ProductsBloc productsBloc;
  @override
  Widget build(BuildContext context) {
    productsBloc = Provider.productsBloc(context);

    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) product = prodData;

    return Scaffold(
      appBar: AppBar(title: Text('Product'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.photo_size_select_actual),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {},
        )
      ]),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _showPhoto(),
                _formName(),
                _formPrize(),
                _submit_button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showPhoto() {
    if (product.urlPhoto != null) {
      return Container(
        child: CachedNetworkImage(
          imageUrl: product.urlPhoto,
          placeholder: (context, url) => Image(
            image: AssetImage('assets/Spinner-1s-800px.gif'),
            height: 200,
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

  Widget _formName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Product'),
      onSaved: (value) => product.title = value,
      validator: (value) {
        if (value.length < 3) {
          return 'To short name';
        }
        return null;
      },
    );
  }

  Widget _formPrize() {
    return TextFormField(
      initialValue: product.prize.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Prize'),
      onSaved: (value) => product.prize = double.parse(value),
      validator: (value) {
        if (utils.is_number(value)) {
          return null;
        }
        return 'Prize has to be a number';
      },
    );
  }

  Widget _submit_button() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: _submit,
    );
  }

  void _submit() {
    if (!(formKey.currentState.validate())) {
      return;
    }
    formKey.currentState.save();
    productsBloc.modProduct(product);
    Navigator.pop(context, 'home');
    showSnackbar("Success");
  }

  void showSnackbar(String msg) {
    final snackbar = SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1500),
    );

    Scaffold.of(context).showSnackBar(snackbar);
  }
}
