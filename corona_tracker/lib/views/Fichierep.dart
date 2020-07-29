import 'package:flutter/material.dart';
    class Fichierep extends StatefulWidget {
      @override
      _FichierepState createState() => _FichierepState();
    }
    
    class _FichierepState extends State<Fichierep> {
      @override
      Widget build(BuildContext context) {
        title:Text('Questionnaire vierge');

        return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                height: MediaQuery
            .of(context)
            .size
            .height,
              width: MediaQuery
            .of(context)
            .size
        .width,
        )
        );
      }
    }
    