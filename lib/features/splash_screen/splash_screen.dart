import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';

import '../../color.dart';
import '../../common/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double fontSize = size.width * 0.04;
    return Scaffold(
      body: Expanded(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.11),
              Image.asset(
                'assets/bg.png',
                height: size.height / 2.3,
                width: size.width / 1.1,
                color: tabColor,
                fit: BoxFit.fill,
              ),
              SizedBox(height: size.height * 0.11),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                  style: TextStyle(color: greyColor, fontSize: fontSize * 0.6),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.75,
                child: CustomButton(
                  text: 'AGREE AND CONTINUE',
                  //go to login screen
                  onPressed: () => navigateToLoginScreen(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
