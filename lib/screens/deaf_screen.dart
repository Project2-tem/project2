import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:alan_voice/alan_voice.dart';
import 'package:project2implement/main.dart';
import 'package:project2implement/screens/second_screen.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:avatar_glow/avatar_glow.dart';

class DeafScreen extends StatefulWidget {
  static const routeName = 'Deaf';
  @override
  DeafScreenState createState() => DeafScreenState();
}

class DeafScreenState extends State<DeafScreen> {
  //Applying the latest flutter speech to text
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListining = false;
  String _lastWords = 'Tap the mic to start listening';

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
    );
    setState(() {});
  }

  void listen() async {
    if (!_isListining) {
      _initSpeech();
      if (_speechEnabled) {
        setState(() {
          _isListining = true;
        });
        _startListening();
      }
    } else {
      setState(() {
        _isListining = false;
      });
      _speechToText.stop();
    }
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deaf Screen",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Color(0xff375079)),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    // If listening is active show recognized words
                    '$_lastWords'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    ),
              ),
            ),
          ],
        ),
      ),
      //Floating button listen
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: true,
        glowColor: Colors.black,
        showTwoGlows: true,
        endRadius: 90.0,
        duration: Duration(microseconds: 2000),
        repeatPauseDuration: Duration(microseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: listen,
          tooltip: 'Listen',
          child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
        ),
      ),
    );
  }
}
