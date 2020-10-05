import 'package:flutter/material.dart';
import 'package:kv/src/block/provider.dart';
import 'package:kv/src/pages/home_page.dart';
import 'package:kv/src/pages/login_page.dart';
import 'package:kv/src/pages/new_poduct_page.dart';
import 'package:kv/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZV',
      initialRoute: 'home',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'newProduct': (BuildContext context) => NewProductPage(),
        'product': (BuildContext context) => ProductPage(),
      },
      theme: ThemeData(
          primaryColor: Color.fromRGBO(200, 0, 100, 1.0),
          buttonColor: Color.fromRGBO(200, 0, 100, 0.4)),
    ));
  }
}
