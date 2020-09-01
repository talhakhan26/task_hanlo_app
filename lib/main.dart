import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskhanloapp/add_data_screen.dart';
import 'package:taskhanloapp/dashboard.dart';
import 'package:taskhanloapp/models/scoop_model.dart';
import 'package:taskhanloapp/onboard_ui.dart';
import 'package:taskhanloapp/registration_screens/signup_screen.dart';
import 'package:taskhanloapp/registration_screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScopedModel(
    model: ScopModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      routes: {
        SignupScreen.routename: (ctx) => SignupScreen(),
        LoginScreen.routename: (ctx) => LoginScreen(),
        MyApp.routename: (ctx) => MyApp(),
        OnBoardScreen.routename: (ctx) => OnBoardScreen(),
        Dashboard.routename: (ctx) => Dashboard(),
        Add_DataList.routename: (ctx) => Add_DataList(),
      },
      theme: ThemeData(primaryColor: Color(0xFF219653)),
    ),
  ));
}

class MyApp extends StatefulWidget {
  static const routename = '/MyApp';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation =
        new CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();

    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.of(context).pushNamed(OnBoardScreen.routename);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Color(0xFF219653)),
        child: FlutterLogo(
          size: _animation.value * 120,
        ),
      ),
    );
  }
}
