import 'package:flutter/material.dart';

class AskScreen extends StatefulWidget {
  AskScreen({Key key}) : super(key: key);

  @override
  _AskScreenState createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("Ask Screen")),
          body: Column(
            children: [
              Text("Ask a Qusetion?"),
              TextField(controller: ,),
              RaisedButton(child: Text("Ask"), onPressed: submitQuestion)
            ],
          )),
    );
  }

  void submitQuestion() {

  }
}
