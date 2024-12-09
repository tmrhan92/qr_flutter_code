import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home-app.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // الانتقال إلى شاشة التطبيق بعد تسجيل الدخول الناجح
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ProductApp()),
      );
    } on FirebaseAuthException catch (e) {
      // معالجة الأخطاء مثل عدم التطابق في البريد أو كلمة المرور
      String message = 'حدث خطأ: ';
      if (e.code == 'user-not-found') {
        message += 'هذا البريد الإلكتروني غير مسجل!';
      } else if (e.code == 'wrong-password') {
        message += 'كلمة المرور غير صحيحة!';
      } else {
        message += 'برجاء المحاولة مرة أخرى!';
      }
      // إظهار رسالة الخطأ للمستخدم
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('خطأ'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('حسناً'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0D25), // اللون الداكن للخلفية
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Image.asset(
                'assets/images/google.png', // شعار Google
              ),
              SizedBox(height: 20),
              // نص تسجيل الدخول
              Text(
                'تسجيل الدخول',
                style: GoogleFonts.roboto(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 40),
              // حقل إدخال البريد الإلكتروني
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'البريد الإلكتروني',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // حقل إدخال كلمة المرور
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'كلمة المرور',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // زر تسجيل الدخول
              ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: Text('التالي'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
