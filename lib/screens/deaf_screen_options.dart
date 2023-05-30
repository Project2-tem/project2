import 'package:flutter/material.dart';

import 'deaf_screen.dart';

class DeafScreenOptions extends StatefulWidget {
  static const routeName = 'DeafOptions';
  @override
  DeafScreenOptionsState createState() => DeafScreenOptionsState();
}

class DeafScreenOptionsState extends State<DeafScreenOptions> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 200, 40),
              child: Text(
                'Deaf Services',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Semantics(
              excludeSemantics: true,
              enabled: true,
              container: false,
              button: true,
              label: 'Speech to Text',
              onTapHint: "open",
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, DeafScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 160, 40),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 100,
                    child: Text(
                      'speech to text',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Semantics(
              excludeSemantics: true,
              enabled: true,
              container: false,
              button: true,
              label: 'Sign Language with gloves',
              onTapHint: "open",
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, DeafScreen.routeName);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 100,
                  child: Text(
                    'Sign Language with gloves',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
