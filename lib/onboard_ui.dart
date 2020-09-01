import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:taskhanloapp/registration_screens/login_screen.dart';

class OnBoardScreen extends StatefulWidget {
  static const routename = 'onboard';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OnBoardState();
  }
}

class OnBoardState extends State<OnBoardScreen> {
  final pageDecoration = PageDecoration(
      titleTextStyle:
          PageDecoration().titleTextStyle.copyWith(color: Colors.black),
      bodyTextStyle:
          PageDecoration().bodyTextStyle.copyWith(color: Colors.black),
      contentPadding: const EdgeInsets.all(20));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: IntroductionScreen(
              globalBackgroundColor: Colors.white,
              pages: getPages(),
              done: Text("Done", style: TextStyle(color: Colors.black)),
              onDone: () {
                Navigator.of(context).pushNamed(LoginScreen.routename);
              },
              showSkipButton: true,
              skip: const Text("Skip", style: TextStyle(color: Colors.black)),
              dotsDecorator: DotsDecorator(
                  size: const Size.square(10.0),
                  activeSize: const Size(20.0, 10.0),
                  activeColor: Theme.of(context).primaryColor,
                  color: Colors.black26,
                  spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)))),
        ));
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Image.asset("assets/find_person.png"),
          title: "Find Person",
          body: "Find your type of person.",
          decoration: pageDecoration),
      PageViewModel(
          image: Image.asset("assets/match.png"),
          title: "Match Your Qualities",
          body: "A person which you have find, Match your Qualities with him.",
          decoration: pageDecoration),
      PageViewModel(
          image: Image.asset("assets/schedule.png"),
          title: "Schedule Meeting",
          body: "Meet with your finded person to know each other.",
          decoration: pageDecoration),
    ];
  }
}
