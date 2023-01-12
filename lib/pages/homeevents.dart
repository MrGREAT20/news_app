import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/MainPage.dart';
import 'package:news_app/pages/login.dart';
import 'package:news_app/pages/loginevents.dart';
import 'package:news_app/pages/posts.dart';
import 'package:news_app/pages/postsevents.dart';
import 'package:news_app/pages/timeline.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/pages/timelineevents.dart';
import 'package:news_app/widgets/navigation_drawer_widget.dart';
import 'package:news_app/widgets/notauthorized.dart';

//this file is for the homepage
//var storageref = FirebaseStorage.instance.ref();
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
var postsref = FirebaseFirestore.instance.collection('events');

class HomeEvents extends StatefulWidget {
  @override
  _HomeEventsState createState() => _HomeEventsState();
}

class _HomeEventsState extends State<HomeEvents> {
  int pageindex = 0;
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onPageChanged(int pageIndex) {
      setState(() {
        this.pageindex = pageindex;
      });
    }

    onTap(int pageindex) {
      pageController.animateToPage(pageindex,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      body: PageView(
        children: [
          TimelineEvents(),
          (isAuth2 ? UploadEvents() : notauth()),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageindex,
        onTap: onTap,
        activeColor: Colors.pink,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.whatshot,
            size: 50.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.photo_camera,
            size: 50.0,
            color: Colors.pink,
          )),
        ],
      ),
    );
  }
}
