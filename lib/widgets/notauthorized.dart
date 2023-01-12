import 'package:flutter/material.dart';

class notauth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "NOT AUTHORIZED PERSONNEL",
        style: TextStyle(color: Colors.red),
      ),
    ));
  }
}
