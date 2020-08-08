import 'package:flutter/material.dart';
class Fichierep extends StatefulWidget {
  @override
  _FichierepState createState() => _FichierepState();
}

class _FichierepState extends State<Fichierep> {
  Widget _bigDisplay() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Column 1"),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Column 2"),
            ],
          ),
        )
      ],
    );
  }

  Widget _smallDisplay() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Row 1"),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Row 2"),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return _bigDisplay();
        } else {
          return _smallDisplay();
        }
      }),
    );
  }
}