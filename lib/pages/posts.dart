//import 'dart:html';
//import 'dart:html';
//import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:news_app/api/firebase_api.dart';
import 'package:news_app/pages/home.dart';
import 'package:news_app/widgets/navigation_drawer_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//this file is for the people to upload news
class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  //var placeholder = AssetImage('assets/PngItem_223968');
  TextEditingController captionController = TextEditingController();
  UploadTask? task;
  File? _image;
  bool isUploading = false;

  Future handlefromgallery() async {
    Navigator.pop(context);
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => _image = File(path));
  }

  selectimage(parentcontext) {
    return showDialog(
        context: parentcontext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Upload pic"),
            children: [
              // SimpleDialogOption(
              //   child: Text("Photo with camera"),
              //   onPressed: handlefromcamera,
              // ),
              SimpleDialogOption(
                child: Text("Photo from gallery"),
                onPressed: handlefromgallery,
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  Container BuildSplashScreen() {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepOrangeAccent.shade100,
              Colors.purpleAccent.shade100
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () => selectimage(context),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purpleAccent)),
              child: const Text('Upload Picture'),
            ),
          )
        ],
      ),
    );
  }

  clearimage() {
    setState(() {
      _image = null;
    });
  }

  Future<String> uploadImage() async {
    if (_image == null) return "";

    final filename = path.basename(_image!.path);
    final destination = '$filename';

    task = FirebaseApi.uploadFile(destination, _image!);

    if (task == null) return "";

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }

  createPostinFirestore({String? mediaUrl, String? description}) {
    FirebaseFirestore.instance.collection("mainman").add({
      "description": description,
      "mediaUrl": mediaUrl,
      "timestamp": new DateTime.now()
    }).then((response) {
      //print(response.id);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      ;
      clearimage();
    });
  }

  handlesubmit() async {
    setState(() {
      isUploading = true;
    });
    //await compressimage();
    String mediaUrl = await uploadImage();
    createPostinFirestore(
        mediaUrl: mediaUrl, description: captionController.text);
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: NewGradientAppBar(
          gradient: LinearGradient(colors: [Colors.white, Colors.white]),
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
                'assets/tpo.png',
                //alignment: Alignment.centerLeft,
                fit: BoxFit.contain,
                height: 42,
                //width: 20,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "UPLOAD TPO NEWS",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ))
            ],
          ),
          actions: [
            TextButton(
              onPressed: isUploading ? null : () => handlesubmit(),
              child: Text(
                "Post",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          ]),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepOrangeAccent.shade100,
                Colors.purpleAccent.shade100
              ]),
        ),
        child: ListView(
          children: [
            Container(
              height: 220,
              width: 360, //MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(color: Colors.redAccent, width: 1.2),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: FileImage(_image!))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            ListTile(
              title: Container(
                width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: captionController,
                  decoration: InputDecoration(
                      hintText: "Write description",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _image == null ? BuildSplashScreen() : buildUploadForm();
  }
}
