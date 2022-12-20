import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_screen_project/feature/view/screen/splash_screen.dart';
import 'package:ui_screen_project/feature/viewModel/view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViewModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          themeMode: ThemeMode.system,
          darkTheme: ThemeData.dark(),
          home: SplashScreen()),
    );
  }
}
