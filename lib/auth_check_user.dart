import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_register_flutter/login_page.dart';
import 'package:login_register_flutter/home_page.dart';
import 'package:login_register_flutter/data/user_data.dart'; 

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? userEmail = prefs.getString('userEmail');

    if (isLoggedIn && userEmail != null && userData.containsKey(userEmail)) {
      //if (!mounted) return;
      // Jika sudah login, navigasi ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            fullName: userData[userEmail]!['fullName']!,
          ),
        ),
      );
    } else {
      //if (!mounted) return;
      // Jika belum login, navigasi ke LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan loading screen sementara
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}