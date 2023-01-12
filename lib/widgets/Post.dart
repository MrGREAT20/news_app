import 'dart:async';
//
// import 'package:animator/animator.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/home.dart';

//
class Post extends StatefulWidget {
  final String description;
  final String mediaUrl;

  Post({
    required this.description,
    required this.mediaUrl,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      description: (doc.data() as dynamic)['description'],
      mediaUrl: (doc.data() as dynamic)['mediaUrl'],
    );
  }

  @override
  _PostState createState() => _PostState(
        description: this.description,
        mediaUrl: this.mediaUrl,
      );
}

class _PostState extends State<Post> {
  final String description;
  final String mediaUrl;

  _PostState({
    required this.description,
    required this.mediaUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
