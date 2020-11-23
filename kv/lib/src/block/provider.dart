import 'package:flutter/material.dart';
import 'package:kv/src/block/login_block.dart';
import 'package:kv/src/block/products_bloc.dart';
export 'package:kv/src/block/products_bloc.dart';
export 'package:kv/src/block/login_block.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }
  final _productsBloc = new ProductsBloc();

  final _loginBloc = new LoginBloc();
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static ProductsBloc productsBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }
}
