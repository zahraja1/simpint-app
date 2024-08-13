import 'package:flutter/material.dart';
import 'package:katalog/presentation/auth/pages/login_page.dart';
import 'package:katalog/data/dataSource/auth_local_datasource.dart'; // Pastikan AuthLocalDataSource diimport
import 'screens.dart';  // Pastikan file Screens.Page.dart diimport

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Durasi SplashScreen ditampilkan
    bool isAuthenticated = await AuthLocalDataSource().isAuth();
    if (isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Screens()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 186, 208, 246),
              Color.fromARGB(255, 187, 227, 245)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo (3).png',
                width: 250,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
