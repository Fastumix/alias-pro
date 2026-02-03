import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF3B2FB0);
    final verticalShift = MediaQuery.of(context).size.height * 0.15;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bgColor,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 20 + verticalShift,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () => context.go('/home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      elevation: 8,
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Text(
                          'Get Started',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 68 + verticalShift,
              child: Center(
                child: SizedBox(
                  width: 320,
                  height: 320,
                  child: SvgPicture.asset(
                    'assets/start_monster.svg',
                    fit: BoxFit.contain,
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