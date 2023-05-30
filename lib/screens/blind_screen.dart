import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:alan_voice/alan_voice.dart';
import 'package:project2implement/main.dart';
import 'package:project2implement/screens/detection_tabs.dart';
import 'package:project2implement/screens/second_screen.dart';

class BlindScreen extends StatefulWidget {
  static const routeName = 'Blind';
  @override
  _BlindScreenState createState() => _BlindScreenState();
}

class _BlindScreenState extends State<BlindScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blind Screen",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Color(0xff375079)),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      drawer: Drawer(
        semanticLabel: 'Navigation menu for blind services',
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff375079),
              ),
              child: Text("Our App name"),
            ),
            ListTile(
              leading: const Icon(Icons.linked_camera_rounded),
              title: const Text("Object detection"),
              onTap: () =>
                  Navigator.pushNamed(context, DetectionTabs.routeName),
            ),
            const ListTile(
              leading: Icon(Icons.document_scanner),
              title: Text("Text recognition"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 150, left: 10),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "In this screen",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 25,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "You can open\nthe navigation menu",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff375079),
                      fontSize: 25,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "And Choose object detection,\nText recognition",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 25,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 250),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 200),
                        child: Container(
                          child: const Icon(
                            Icons.mic_outlined,
                            color: Color(0xff375079),
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "You can navigate through the app with your\nvoice if you are blind",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.5,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 70, right: 15, bottom: 20),
                      child: Column(
                        children: [
                          Semantics(
                            excludeSemantics: true,
                            enabled: true,
                            container: false,
                            button: true,
                            label: "Navigate to next screen",
                            onTapHint: "navigate",
                            onTap: () => Navigator.pushNamed(
                                context, DetectionTabs.routeName),
                            child: FloatingActionButton(
                              backgroundColor: const Color(0xff375079),
                              child: const Icon(Icons.arrow_forward,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                    DetectionTabs
                                        .routeName); // Navigate to second screen when tapped!
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
