import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage3 extends StatefulWidget {
  const LoginPage3({Key? key}) : super(key: key);

  @override
  State<LoginPage3> createState() => _LoginPage3State();
}

class _LoginPage3State extends State<LoginPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'urbanmalta',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            const Text(
              'Your terms, our platform. Enjoy 100%',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'of your earning',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              child: Lottie.asset(
                "animation/5Djtc8ikOX.json",
                fit: BoxFit.cover,
                reverse: true,
                repeat: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
