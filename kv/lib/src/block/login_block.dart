import 'dart:async';

import 'package:kv/src/block/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //listen to data stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePasword);
  Stream<int> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => 1);
  //insert values on the stream=
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
//obtener ultimo valor de los strems

  String get email => _emailController.value;
  String get password => _passwordController.value;
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
