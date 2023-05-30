import 'package:flutter/material.dart';
// import 'package:alan_voice/alan_voice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project2implement/screens/blind_screen.dart';
import 'package:project2implement/screens/deaf_screen.dart';

import 'deaf_screen_options.dart';

class SecondScreen extends StatefulWidget {
  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'images/backg.jpg',
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Options",
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                color: Color(0xff375079)),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 144,
              ),
              Text(
                'Application options',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              blindCard(),
              deafCard()
            ],
          ),
        ),
      ),
    );
  }

  Widget blindCard() {
    return Container(
      height: 140,
      child: Semantics(
        excludeSemantics: true,
        enabled: true,
        container: false,
        button: true,
        label: "Blind Card",
        onTapHint: "open",
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, BlindScreen.routeName);
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Blind services',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Container(
                        width: 240,
                        child: Text(
                          'orem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor .',
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'images/glasses.png',
                  width: 100,
                  height: 90,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget deafCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 140,
      child: Semantics(
        excludeSemantics: true,
        enabled: true,
        container: false,
        button: true,
        label: "Deaf Card",
        onTapHint: "open",
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, DeafScreenOptions.routeName);
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Deaf services',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Container(
                        width: 240,
                        child: Text(
                          'orem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor .',
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'images/gloves.jpg',
                  width: 100,
                  height: 90,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
