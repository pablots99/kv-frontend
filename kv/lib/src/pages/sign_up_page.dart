import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:kv/src/block/login_block.dart';
import 'package:kv/src/block/provider.dart';
import 'package:kv/src/providers/user_provider.dart';
import 'package:kv/src/providers/user_provider.dart';
import 'package:kv/src/utils/utils.dart';

class SignUpPage extends StatelessWidget {
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crerFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(height: size.height * 0.2),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _emailImput(bloc),
                _passwordImput(bloc),
                SizedBox(
                  height: 23.0,
                ),
                _sendButton(bloc, context)
              ],
            ),
          ),
          SizedBox(height: 20),
          FlatButton(
            child: Text('You alredy have an account?'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      ),
    );
  }

  Widget _passwordImput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'password',
                errorText: snapshot.error,
                icon: Icon(
                  Icons.vpn_key_sharp,
                  color: Color.fromRGBO(200, 0, 100, 1.0),
                )),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _emailImput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'example@example.com',
                labelText: 'Email address',
                errorText: snapshot.error,
                icon: Icon(
                  Icons.alternate_email,
                  color: Color.fromRGBO(200, 0, 100, 1.0),
                )),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _sendButton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Text(
              'Next',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Theme.of(context).buttonColor,
            onPressed:
                snapshot.data == 1 ? () => _register(bloc, context) : null);
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    //Navigator.pushReplacementNamed(context, 'home');
    Map info = await userProvider.login(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, 'Email arredy in use', 'Invalid Email');
    }
  }

  Widget _crerFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(255, 0, 130, 1.0),
        Color.fromRGBO(72, 0, 98, 1.0),
      ])),
    );
    return Stack(
      children: <Widget>[
        fondo,
        Container(
            height: size.height * 0.4,
            child: Center(
                child: Text("KV",
                    style: TextStyle(color: Colors.white, fontSize: 50)))),
      ],
    );
  }
}
