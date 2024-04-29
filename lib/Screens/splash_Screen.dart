import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/Screens/mainScreen.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  AnimationController? anime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    anime = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
          child: Lottie.asset(
        controller: anime,
        "assets/lottie/loading.json",
        height: 200,
        width: 500,
        onLoaded: (value) async {
          anime!
            ..duration = value.duration
            ..forward();
          await Future.delayed(value.duration);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));
        },
      )),
    );
  }
}
