import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  bool _showSubTitle = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Tampilkan subjudul setelah delay
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() => _showSubTitle = true);
    });

    // Jalankan progress bar
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 0.02;
      });

      if (_progress >= 1.0) {
        _timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2196F3),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF6EC6FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo1.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 36),
                  const Text(
                    'Data Indikator Makro Sumedang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedOpacity(
                    opacity: _showSubTitle ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: const Text(
                      'Kabupaten Sumedang',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 40,
              right: 40,
              child: LinearProgressIndicator(
                value: _progress.clamp(0.0, 1.0),
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
