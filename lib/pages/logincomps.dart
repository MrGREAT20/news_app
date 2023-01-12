import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:news_app/pages/MainPage.dart';
//import 'HomePage.dart';
import 'package:news_app/pages/home.dart';
import 'package:news_app/pages/homecomps.dart';
import 'package:news_app/pages/homeevents.dart';
import 'package:news_app/pages/posts.dart';
import 'package:news_app/widgets/navigation_drawer_widget.dart';
import 'posts.dart';

bool isAuth1 = false;

class LoginComps extends StatefulWidget {
  @override
  _LoginCompsState createState() => _LoginCompsState();
}

class _LoginCompsState extends State<LoginComps> {
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  String result = "";
  String result2 = "";
  String mainans = "b";
  String mainans2 = "b";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
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
                child:
                    Text("Login COMPS", style: TextStyle(color: Colors.black))),
          ],
        ),
        gradient: LinearGradient(colors: [Colors.white, Colors.white]),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeComps()));
            },
            child: Text(
              "Skip",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ],
      ),
      body: Container(
        height: 760,
        width: 760,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepOrangeAccent.shade100,
                Colors.purpleAccent.shade100
              ]),
        ),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.amberAccent,
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.error_outline),
                      ),
                      Text("Skip if you are not authorised personnel"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                      // child: Image.asset('asset/images/flutter-logo.png')
                    ),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                      controller: _controller1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        //hintText: 'Enter valid email id as abc@gmail.com'
                      ),
                      onSubmitted: (String str) {
                        setState(() {
                          result = str;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                      controller: _controller2,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',

                        //hintText: 'Enter secure password'
                      ),
                      onSubmitted: (String str) {
                        setState(() {
                          result2 = str;
                        });
                      }),
                ),
                // TextButton(
                //   onPressed: () {
                //     //TODO FORGOT PASSWORD SCREEN GOES HERE
                //   },
                //   child: Text(
                //     'Forgot Password',
                //     style: TextStyle(color: Colors.blue, fontSize: 15),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        if (result == mainans && result2 == mainans2) {
                          isAuth1 = true;
                          _controller1.clear();
                          _controller2.clear();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HomeComps()));
                        } else
                          return null;
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
                // Text('New User? Create Account')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
