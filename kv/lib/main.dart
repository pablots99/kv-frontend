import 'package:flutter/material.dart';
import 'package:kv/src/block/provider.dart';
import 'package:kv/src/pages/home_page.dart';
import 'package:kv/src/pages/login_page.dart';
import 'package:kv/src/pages/new_poduct_page.dart';
import 'package:kv/src/pages/product_page.dart';
import 'package:kv/src/pages/sign_up_page.dart';
import 'package:kv/src/user_config/user_config.dart';

void main() async {
  final config = new UserConfig();
  runApp(MyApp());
  await config.initPrefs();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _config = new UserConfig();
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KV',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'newProduct': (BuildContext context) => NewProductPage(),
        'product': (BuildContext context) => ProductPage(),
        'sign_up': (BuildContext context) => SignUpPage(),
        'user': (BuildContext context) => SignUpPage(),
      },
      theme: ThemeData(
          primaryColor: Color.fromRGBO(200, 0, 100, 1.0),
          buttonColor: Color.fromRGBO(200, 0, 100, 0.4)),
    ));
  }
}
