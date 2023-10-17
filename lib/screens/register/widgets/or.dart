import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../login/login_screen.dart';

class OrSignUpWith extends StatefulWidget {
  const OrSignUpWith({Key? key}) : super(key: key);

  @override
  State<OrSignUpWith> createState() => _OrSignUpWithState();
}

class _OrSignUpWithState extends State<OrSignUpWith> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Row(children: const <Widget>[
            Expanded(
                child: Divider(
              color: Colors.black,
            )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Or Sign up with",
                style: TextStyle(),
              ),
            ),
            Expanded(
                child: Divider(
              color: Colors.black,
            )),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // google.png
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/google.png'),
            ),
            SizedBox(
              width: 10,
            ),
            // appleicon

            CircleAvatar(
              radius: 33,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/facebook.png'),
            ),
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/appleicon.png'),
            ),
          ],
        ),
        Row(children: const <Widget>[
          Expanded(
              child: Divider(
            color: Colors.black,
          )),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "OR",
              style: TextStyle(),
            ),
          ),
          Expanded(
              child: Divider(
            color: Colors.black,
          )),
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(
                  color: Color(0xFF767F94),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                },
                child: const Text(
                  '  Log in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
