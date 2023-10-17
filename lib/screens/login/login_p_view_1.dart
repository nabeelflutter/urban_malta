import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_p_view_2.dart';

class LoginView1 extends StatefulWidget {
  final PageController pageControllered;
  const LoginView1({Key? key, required this.pageControllered})
      : super(key: key);

  @override
  State<LoginView1> createState() => _LoginView1State();
}

class _LoginView1State extends State<LoginView1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Container(
              height: 100,
              width: 130,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/login_pageview1.png',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Text(
              'where your skills\nmeet opportunity',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            GestureDetector(
              onTap: () {
                widget.pageControllered.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Row(
                children: [
                  const Text(
                    'Get Started',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                    size: 20,
                  ),
                ],
              ),
            ),
        

          ],
        ),
      ),
    );
  }
}
