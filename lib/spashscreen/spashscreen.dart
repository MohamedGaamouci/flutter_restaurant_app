import 'dart:async';

import 'package:flutter/material.dart';
import 'package:offi_memoire/start.dart';

class Myspashscreen extends StatefulWidget {
  const Myspashscreen({super.key});

  @override
  State<Myspashscreen> createState() => _MyspashscreenState();
}

class _MyspashscreenState extends State<Myspashscreen> {
  startTimer() {
    Timer(Duration(seconds: 5), () async {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const start(),
          ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  Future<bool> _onPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Material(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Container(
                  height: 400,
                  width: double.infinity,
                  child: Image(image: AssetImage('images/project_logo.png'))),
                
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    'sell food online',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black54,
                      fontFamily: 'Signatra',
                      letterSpacing: 3,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
