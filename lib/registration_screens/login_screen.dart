import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskhanloapp/dashboard.dart';
import 'package:taskhanloapp/models/UserModel.dart';
import 'package:taskhanloapp/models/scoop_model.dart';
import 'package:taskhanloapp/registration_screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routename = '/login';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                    color: Color(0xFF219653),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0))),
                child: Center(child: FlutterLogo(size: 120.0)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "SIGN IN ACCOUNT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email or Username",
                      hintText: "abc123@xyz.com"),
                  validator: (value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return "Invalid Email...!!!";
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "**********"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Invalid Password...!!!";
                    }
                  },
                ),
              ),
              ScopedModelDescendant<ScopModel>(
                builder: (BuildContext context, Widget child, ScopModel model) {
                  return model.loginProgress
                      ? AlertDialog(
                          title: Text('Sign In Successful'),
                          actions: <Widget>[
                              FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(Dashboard.routename);
                                  })
                            ])
                      : Container(
                          width: 200,
                          height: 50.0,
                          margin: EdgeInsets.only(
                              top: 40.0, left: 20.0, right: 20.0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Color(0xFF219653),
                            child: Text(
                              'SIGN IN',
                              textScaleFactor: 1.5,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                print("Sign In Button");
                                _LogIn(model);
                              });
                            },
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        );
                },
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Text('Does not have account?'),
                  FlatButton(
                    textColor: Color(0xFF219653),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignupScreen.routename);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _LogIn(ScopModel model) {
    if (_formKey.currentState.validate()) {
      String email = emailCtrl.text;
      String pass = passCtrl.text;

      UserMod user = UserMod();
      user.email = email;
      user.pass = pass;
      model.signinUser(user).then((Map<String, dynamic> res) {
        if (res['success']) {
          print('SignIn Press');
          print('Login Successful');
          Navigator.of(context).pushNamed(Dashboard.routename);
        } else {
          var msg =
              'Authentication is failed... Please Recheck your Email & Password!';
          _errDialog(msg);
        }
      });
    }
  }

  void _errDialog(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
