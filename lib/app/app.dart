import 'package:advanced_flutter_arabic/presentation/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key); //?Defult Constructor
  //!Named Constructor
  const MyApp._internal();

  static const MyApp _instance =
      MyApp._internal(); //! singleton or single instance
  factory MyApp() => _instance; //!Factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
    );
  }
}
