// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/buttons';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  //curved animation class -> to incresse (controller.value) bit by bit .
  Animation? animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    ); //upperBound: 100);
    //curved animation
    // animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);
    controller?.forward();
    //controller.reverse(from: 1);
    // // to knowe when animation complete .
    // animation?.addStatusListener((status) {
    //   print(' $status');
    //   // if want size increase then decrease
    //   if (status == AnimationStatus.completed) {
    //     controller?.reverse(from: 1);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller?.forward();
    //   }
    // });
    animation =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller!);
    controller?.addListener(() {
      setState(() {});
      print(animation?.value); //controller.value);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          animation?.value, //Colors.white, //red.withOpacity(controller.value),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60, //animation?.value * 100,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      // '${controller.value.toInt()}%',
                      'Flash Chat ',
                      textStyle: const TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 109, 109, 109)),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Buttons(
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: 'Log In',
            ),
            Buttons(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
