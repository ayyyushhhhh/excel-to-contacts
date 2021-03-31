import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class finalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    popOfScreen(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Import Contacts Successful',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
              SvgPicture.asset(
                'assets/done.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future popOfScreen(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 3));
  Navigator.pop(context);
}
