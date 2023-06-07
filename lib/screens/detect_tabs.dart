import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class DetectTabs extends StatelessWidget {
  Function? getImage;
  IconData? iconData;

  DetectTabs({required this.iconData, required this.getImage});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: () => getImage!(ImageSource.camera),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 30,
              color: const Color(0xff375079),
            ),
          ],
        ),
      ),
    );
  }
}
