import 'package:flutter/material.dart';
import 'package:tsec/screen/home-app.dart';
import 'home_page_screen.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 59),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // SlideTransition(
              //   position: _slideAnimation,
              //   child: const Text(
              //     'TSEC',
              //     style: TextStyle(
              //       fontSize: 64,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.red,
              //       shadows: [
              //         Shadow(
              //           blurRadius: 5.0,
              //           color: Colors.black,
              //           offset: Offset(2.0, 2.0),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/tsec.png'), // تأكد من المسار الصحيح
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SlideTransition(
                position: _slideAnimation,
                child: const Text(
                  'Welcome to Scanner App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 3.0,
                        color: Colors.black,
                        offset: Offset(9.0, 9.0),
                      ),
                    ],
                  ),
                ),
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
