import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  Confirmation({Key? key}) : super(key: key);

  final _headerStyle = const TextStyle(
      fontFamily: 'roboto',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      letterSpacing: 1.5);

  final _boxShadow = [
    const BoxShadow(
      color: Colors.greenAccent,
      offset: Offset(
        0.0,
        5.0,
      ),
      blurRadius: 10.0,
      spreadRadius: 1.0,
    ), //BoxShadow
    const BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ), //BoxShadow
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final _boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: _boxShadow,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          height: 150,
          decoration: _boxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Sua conta foi criada com sucesso!',
                  textAlign: TextAlign.center,
                  style: _headerStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
