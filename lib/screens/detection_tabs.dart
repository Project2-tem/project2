import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:project2implement/screens/button_detection.dart';

class DetectionTabs extends StatefulWidget {
  static const routeName = 'detect';

  const DetectionTabs({Key? key}) : super(key: key);

  @override
  State<DetectionTabs> createState() => _DetectionTabsState();
}

class _DetectionTabsState extends State<DetectionTabs> {
  bool moneyClick = false;
  FlutterTts flutterTts = FlutterTts();
  late ImageLabeler _imageLabeler;
  late final modelPath;

  String imageUrl = '';
  final storage = FirebaseStorage.instance;

  List<IconData> icon = [
    Icons.camera,
    Icons.shopping_bag,
    Icons.currency_exchange,
  ];

  @override
  void initState() {
    super.initState();

    getImageUrl();

    // loadModel();
  }

  Future<void> getImageUrl() async {
    final ref = storage.ref().child('data/photo.jpg');
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  bool imageLabelChecking = false;

  XFile? imageFile;

  String imageLabel = "";
  List? result;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Object detection",
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Colors.white),
        ),
        // backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (imageLabelChecking) const CircularProgressIndicator(),
            if (!imageLabelChecking && imageUrl == "")
              Container(
                width: 300,
                height: 300,
                color: Colors.grey[350],
              )
            else
              Image.network(imageUrl),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Choose categories',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Divider(
                height: 2,
                thickness: 1,
                color: Colors.grey[200],
              ),
            ),
            // ButtonDetection(
            //   imageUrl: imageUrl,
            //   loadModel: loadModel,
            //   index: 0,
            //   icon: Icons.camera,
            // ),
            // ButtonDetection(
            //   imageUrl: imageUrl,
            //   loadModel: loadModel,
            //   index: 1,
            //   icon: Icons.shopping_bag,
            // ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: icon.length,
                itemBuilder: (context, index) {
                  return ButtonDetection(
                      imageUrl: imageUrl,
                      loadModel: loadModel,
                      index: index,
                      icon: icon[index]);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Text(
                "${result?[0]["label"] ?? ""}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        )),
      ),
    );
  }

  void _speak() async {
    await flutterTts.speak("${result?[0]["label"]}");
  }

  getImageFileFromNetwork(String url) async {
    var response = await http.get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    final file2 = io.File('${documentDirectory.path}/temp.jpg');
    file2.writeAsBytesSync(response.bodyBytes);
    classifyImage(file2.path);
    setState(() {
      // imageUrl = url;
      imageLabelChecking = true;
      imageUrl = "";
    });
  }

  loadModel(String imageUrl, int index) async {
    switch (index) {
      case 0:
        await Tflite.loadModel(
          model: "ml/model_unquant.tflite",
          labels: "ml/labels.txt",
        );
        getImageFileFromNetwork(imageUrl);
        break;
      case 1:
        await Tflite.loadModel(
          model: "ml/clothes_model.tflite",
          labels: "ml/clothes_labels.txt",
        );
        getImageFileFromNetwork(imageUrl);
        break;
      case 2:
        await Tflite.loadModel(
          model: "ml/money_model_unquant.tflite",
          labels: "ml/money_labels.txt",
        );
        getImageFileFromNetwork(imageUrl);
        break;
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(String image) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: image,
        imageMean: 127.5, // defaults to 117.0
        imageStd: 127.5, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.5, // defaults to 0.1
        asynch: true,
      );

      if (output!.isNotEmpty) {
        setState(() {
          imageLabelChecking = false;
          result = output;
          _speak();
        });
      } else {
        setState(() {
          imageLabelChecking = false;
        });
      }
    } catch (e) {
      // Handle the exception here
      print('An error occurred while classifying the image: $e');
      // Perform any necessary error handling or display error messages
    }
  }

  // classifyImage(String image) async {
  //   var output = await Tflite.runModelOnImage(
  //     path: image,
  //     imageMean: 127.5, // defaults to 117.0
  //     imageStd: 127.5, // defaults to 1.0
  //     numResults: 2, // defaults to 5
  //     threshold: 0.5, // defaults to 0.1
  //     asynch: true,
  //   );
  //   setState(() {
  //     imageLabelChecking = false;
  //     result = output;
  //     _speak();
  //   });
  // }
}


// class DetectionTabs extends StatefulWidget {
//   static const routeName = 'detect';

//   const DetectionTabs({Key? key}) : super(key: key);

//   @override
//   State<DetectionTabs> createState() => _DetectionTabsState();
// }

// class _DetectionTabsState extends State<DetectionTabs> {
//   bool moneyClick = false;
//   FlutterTts flutterTts = FlutterTts();
//   late ImageLabeler _imageLabeler;
//   late final modelPath;
//   File? _image;
//   late String imageUrl;
//   final storage = FirebaseStorage.instance;

//   @override
//   void initState() {
//     super.initState();

//     loadModel();
//     imageUrl = '';
//     // getImageFileFromNetwork();
//   }

//   // Future<void> getImageUrl() async {
//   //   final ref = storage.ref().child('data/photo.jpg');
//   //   final url = await ref.getDownloadURL();
//   //   setState(() {
//   //     imageUrl = url;
//   //   });
//   // }
//   getImageFileFromNetwork() async {
//     final ref = storage.ref().child('data/photo.jpg');
//     final url = await ref.getDownloadURL();
//     var response = await http.get(Uri.parse(url));
//     var documentDirectory = await getApplicationDocumentsDirectory();
//     // XFile file = XFile('${documentDirectory.path}/temp.jpeg');
//     final file2 = io.File('${documentDirectory.path}/photo.jpg');
//     file2.writeAsBytesSync(response.bodyBytes);
//     classifyImage(file2.path);

//     setState(() {
//       imageUrl = url;
//     });
//   }

//   bool imageLabelChecking = false;

//   // XFile? imageFile;

//   String imageLabel = "";
//   List? result;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Object detection",
//           style: TextStyle(color: Colors.white),
//         ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(25),
//                   bottomRight: Radius.circular(25)),
//               color: Color(0xff375079)),
//         ),
//         // backgroundColor: Colors.grey[100],
//         elevation: 0,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//             child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if (imageLabelChecking) const CircularProgressIndicator(),
//             if (!imageLabelChecking && imageUrl == "")
//               Container(
//                 width: 300,
//                 height: 300,
//                 color: Colors.grey[350],
//               ),
//             if (imageUrl != "")
//               // Image.file(
//               //   io.File(imageFile!.path),
//               //   width: 450,
//               //   height: 450,
//               // ),
//               SizedBox(
//                 height: 300,
//                 child: Image(
//                   image: NetworkImage(imageUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             Container(
//               margin: const EdgeInsets.only(top: 30),
//               child: const Text(
//                 'Choose categories',
//                 style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.only(top: 10),
//               child: Divider(
//                 height: 2,
//                 thickness: 1,
//                 color: Colors.grey[200],
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.only(top: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // DetectTabs(
//                   //   iconData: Icons.storefront,
//                   //   getImage: getImage,
//                   // ),
//                   Container(
//                     margin: const EdgeInsets.only(left: 15),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.grey[400],
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0)),
//                       ),
//                       onPressed: () {
//                         // loadModel();
//                         classifyImage(imageUrl);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 5,
//                           horizontal: 5,
//                         ),
//                         child: Column(
//                           children: const [
//                             Icon(
//                               Icons.apple,
//                               size: 30,
//                               color: Color(0xff375079),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.only(top: 50),
//               child: Text(
//                 "${result?[0]["label"]}",
//                 style: const TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             )
//           ],
//         )),
//       ),
//     );
//   }

//   void _speak() async {
//     await flutterTts.speak("${result?[0]["label"]}");
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: "ml/model_unquant.tflite",
//       labels: "ml/labels.txt",
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }

//   // void getImage() async {
//   //   try {
//   //     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//   //     if (pickedImage != null) {
//   //       imageLabelChecking = true;
//   //       imageUrl = pickedImage as String;
//   //       setState(() {
//   //         imageLabelChecking = true;
//   //         imageUrl = pickedImage as String;
//   //       });
//   //       classifyImage(pickedImage as File);
//   //     }
//   //   } catch (e) {
//   //     imageLabelChecking = false;
//   //     imageUrl = "";
//   //     imageLabel = "Error occurred while getting image Label";
//   //     setState(() {});
//   //   }
//   // }

//   classifyImage(String image) async {
//     var output = await Tflite.runModelOnImage(
//       path: image,
//       imageMean: 127.5, // defaults to 117.0
//       imageStd: 127.5, // defaults to 1.0
//       numResults: 2, // defaults to 5
//       threshold: 0.5, // defaults to 0.1
//       asynch: true,
//     );
//     setState(() {
//       imageLabelChecking = false;
//       result = output;
//       _speak();
//     });
//   }
// }
