import 'package:flutter/material.dart';
import 'package:shiftswift/login/login_home.dart';

class AnimationLogo extends StatefulWidget {
  const AnimationLogo({super.key});

  @override
  State<AnimationLogo> createState() => _AnimatedSequencePageState();
}

class _AnimatedSequencePageState extends State<AnimationLogo> {
  bool showImage = false;
  bool showText = false;

  @override
  void initState() {
    super.initState();

    // Start image animation
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        showImage = true;
      });

      // After 2 seconds, show the text
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          showText = true;
        });

        // After 3 more seconds, navigate
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  LoginHome()),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // صورة متحركة من الشمال
            AnimatedSlide(
              offset: showImage ? Offset.zero : const Offset(-2, 0),
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              child: Image.asset(
                'asstes/logo.png', // ← غيّر إلى مسار الصورة عندك
                width: 350,
                height: 350,
              ),
            ),
            const SizedBox(height: 20),

            // الكلمة تنزل من فوق
            AnimatedSlide(
              offset: showText ? Offset.zero : const Offset(0, -2),
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: showText ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: const Text(
                  'S H I F T   S W I F T',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF255B93),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
