import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scanner App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0B0D25),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E284F),
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          elevation: 10,
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0B0D25),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E284F),
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
        ),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}