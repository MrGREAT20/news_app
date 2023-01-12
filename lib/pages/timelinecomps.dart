//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/painting.dart';
import 'package:news_app/pages/MainPage.dart';
import 'package:news_app/pages/logincomps.dart';
//import 'package:news_app/pages/MainPage.dart';
import 'package:news_app/widgets/Post.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:news_app/pages/login.dart';
import 'dart:collection';
import 'package:google_fonts/google_fonts.dart';

class TimelineComps extends StatefulWidget {
  @override
  _TimelineCompsState createState() => _TimelineCompsState();
}

class _TimelineCompsState extends State<TimelineComps> {
  List<Post> posts = [];
  var firestoreDB = FirebaseFirestore.instance
      .collection('compsnew')
      .orderBy('timestamp', descending: true)
      .snapshots();
  @override
  Widget build(context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/comps logo.jpeg',
                //alignment: Alignment.centerLeft,
                fit: BoxFit.contain,
                height: 42,
                //width: 20,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("COMPS NEWS",
                      style: TextStyle(color: Colors.black))),
            ],
          ),
          gradient: LinearGradient(colors: [Colors.white, Colors.white]),
        ),
        body: StreamBuilder(
            stream: firestoreDB,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                  itemBuilder: (context, int index) {
                    return Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.deepOrangeAccent.shade100,
                                Colors.purpleAccent.shade100
                              ]),
                        ),
                        child: Flexible(
                          child: Card(
                            child: Flexible(
                              child: Container(
                                height: 840,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.purple.shade300,
                                        Colors.white
                                      ]),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        height: 400.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(
                                                    (snapshot.data!
                                                                as QuerySnapshot)
                                                            .docs[index]
                                                        ['mediaUrl'])))),
                                    Text(
                                        (snapshot.data! as QuerySnapshot)
                                            .docs[index]['description'],
                                        style: GoogleFonts.oswald(
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () => buildDelete(
                                                snapshot: snapshot.data,
                                                index: index),
                                            icon: Icon(
                                              Icons.delete,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}

buildDelete({Object? snapshot, required int index}) async {
  if (isAuth1) {
    var docid = (snapshot as QuerySnapshot).docs[index].id;
    await FirebaseFirestore.instance.collection("compsnew").doc(docid).delete();
  } else {
    return null;
  }
  //await FirebaseFirestore.instance.collection("mainman").doc(docid).delete();
}
