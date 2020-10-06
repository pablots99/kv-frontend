//import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kv/src/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kv/src/providers/product_provider.dart';
import 'package:kv/src/utils/utils.dart' as utils;
//import 'package:path/path.dart' as Path;

class NewProductPage extends StatefulWidget {
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductModel product = new ProductModel();
  final productProvider = new ProductProvider();
  PickedFile foto;
  String _uploadedFileURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: AppBar(title: Text('New Product'), actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _selectPhoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _takePhoto,
            )
          ])),
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
      child: Icon(Icons.arrow_forward_ios_rounded),
      onPressed: () {
        _submit();
      },
    );
  }

  void _submit() async {
    if (!(formKey.currentState.validate())) {
      return;
    }
    if (foto != null) {
      product.urlPhoto = await productProvider.uploadImage(File(foto.path));
    }
    formKey.currentState.save();
    productProvider.createProduct(product);
    Navigator.pop(context, 'home');
  }

  void showSnackbar(String msg, GlobalKey<ScaffoldState> mainscafoldKey) {
    final snackbar = SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1500),
    );

    mainscafoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _showPhoto() {
    if (product.urlPhoto != null) {
      return Container();
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/no_image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  void _selectPhoto() async {
    // ignore: invalid_use_of_visible_for_testing_member
    foto = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (foto != null) {
      //clean
    }
    setState(() {});
  }

  void _takePhoto() async {
    // ignore: invalid_use_of_visible_for_testing_member
    foto = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (foto != null) {
      //clean
    }
    setState(() {});
  }
}
