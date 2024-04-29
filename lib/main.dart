import 'package:flutter/material.dart';
import 'package:newsapp/Screens/splash_Screen.dart';
import 'package:newsapp/provider/provider.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Data(context),
        ),
        ChangeNotifierProvider(
          create: (context) => searchdata(context),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: splash(),
      ),
    );
  }
}
