import 'package:flutter/material.dart';
// import 'package:alan_voice/alan_voice.dart';
import 'package:project2implement/main.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with RouteAware {
  MyHomePageState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => setVisuals("first"));

    // /// Init Alan Button with project key from Alan Studio
    // AlanVoice.addButton(
    //     "05a16312c245fa39b49f03e9dd09b1c72e956eca572e1d8b807a3e2338fdd0dc/stage",
    //     buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    // /// Handle commands from Alan Studio
    // AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // void setVisuals(String screen) {
  //   var visual = "{\"screen\":\"$screen\"}";
  //   AlanVoice.setVisualState(visual);
  // }

  // @override
  // void didPushNext() {
  //   debugPrint("didPush");
  //   setVisuals("second");
  // }

  // void _handleCommand(Map<String, dynamic> command) {
  //   switch (command["command"]) {
  //     case "forward":
  //       Navigator.popUntil(context, (route) {
  //         if (route.settings.name == '/') {
  //           Navigator.pushNamed(context, '/second');
  //         }
  //         return true;
  //       });
  //       // if (ModalRoute.of(context)?.settings.name == '/') {
  //       //   Navigator.pushNamed(context, '/second');
  //       // }
  //       break;
  //     case "back":
  //       Navigator.popUntil(context, (route) {
  //         if (route.settings.name == '/') {
  //           AlanVoice.playText("You are already on the home page");
  //         } else if (route.settings.name == '/second') {
  //           setVisuals("first");
  //           Navigator.pop(context);
  //         }
  //         return true;
  //       });
  //       break;
  //     default:
  //       debugPrint("Unknown command");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "Instructions",
        //   style: TextStyle(color: Colors.white),
        // ),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(25),
        //           bottomRight: Radius.circular(25)),
        //       color: Color(0xff375079)),
        // ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 160, left: 10),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'images/Logo.png', // replace with your logo image path
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Center(
                      child: Text(
                        "IPAD .co",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.5,
                          // fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text(
                          "Welcome to IPAD co.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.5,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, right: 5),
                        child: Text(
                          "Our app is here to make your life easier. With our help, you can stay connected to the world around you, access important information, and navigate your day-to-day with confidence. We're proud to be your partner in empowerment, and we're excited to get started.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // add your button's onPressed function here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          minimumSize: Size(170, 50),
                        ),
                        child: Text(
                          'GET STARTED',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15, bottom: 10),
                          child: Column(
                            children: [
                              Semantics(
                                excludeSemantics: true,
                                enabled: true,
                                container: false,
                                button: true,
                                label: "Navigate to next screen",
                                onTapHint: "navigate",
                                onTap: () =>
                                    Navigator.pushNamed(context, '/second'),
                                child: FloatingActionButton(
                                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        '/second'); // Navigate to second screen when tapped!
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(top: 190),
                //       child: Column(
                //         children: [
                //           Row(
                //             children: [
                //               Container(
                //                 child: Icon(
                //                   Icons.mic_outlined,
                //                   color: Color(0xff375079),
                //                   size: 30,
                //                 ),
                //               ),
                //               Container(
                //                 child: Align(
                //                   alignment: Alignment.topLeft,
                //                   child: Text(
                //                     "You can navigate through the app with your\nvoice if you are blind",
                //                     style: TextStyle(
                //                       color: Colors.grey[600],
                //                       fontSize: 14.5,
                //                       fontFamily: "Roboto",
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
