import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_firebase/utiils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: secondaryColor
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: primaryColor,
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}