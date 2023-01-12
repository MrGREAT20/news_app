import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:news_app/pages/login.dart';
import 'package:news_app/pages/logincomps.dart';
import 'package:news_app/pages/loginevents.dart';
import 'package:cached_network_image/cached_network_image.dart';

//
String signUpUrlImage =
    "https://www.pvppcoe.ac.in/vppcoa/assets/img/banner%201.jpg";

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/college_logo1.jpg',
              //alignment: Alignment.centerLeft,
              fit: BoxFit.contain,
              height: 42,
              //width: 20,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'VPP NEWS',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        gradient: LinearGradient(colors: [Colors.white, Colors.white]),
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: signUpUrlImage,
            placeholder: (context, url) => Image.asset(
              'assets/college.jpg',
              fit: BoxFit.fill,
            ),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/tpo.png',
                      fit: BoxFit.contain,
                      height: 50,
                    ),
                    label: Text(
                      'TPO-DEP',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginDemo()));
                    },
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(Size.fromHeight(100)),
                        elevation: MaterialStateProperty.all(16.0),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 70, vertical: 20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/comps logo.jpeg',
                      fit: BoxFit.contain,
                      height: 50,
                    ),
                    label: Text('COMPS',
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginComps()));
                    },
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(Size.fromHeight(100)),
                        elevation: MaterialStateProperty.all(16.0),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 70, vertical: 20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/college_logo1.jpg',
                      fit: BoxFit.contain,
                      height: 50,
                    ),
                    label: Text(
                      'EVENTS',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginEvents()));
                    },
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(Size.fromHeight(100)),
                        elevation: MaterialStateProperty.all(16.0),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 70, vertical: 20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
