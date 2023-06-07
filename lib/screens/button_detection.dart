import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ButtonDetection extends StatelessWidget {
  ButtonDetection(
      {super.key,
      required this.imageUrl,
      required this.loadModel,
      required this.index, required this.icon});

  final String imageUrl;
  final int index;
  Function loadModel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey[400],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: () {
          if (imageUrl == "") {
            return;
          } else {
            try {
              loadModel(imageUrl, index);
            } on Exception catch (e) {}
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
                color: Color(0xff375079),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
