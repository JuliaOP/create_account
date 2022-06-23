import 'package:flutter/material.dart';

class FormCard extends StatefulWidget {
  Widget formFields;
  String header;

  FormCard(this.formFields, this.header);

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
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
    final _boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: _boxShadow,
    );

    return Container(
      alignment: Alignment.center,
      decoration: _boxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                widget.header,
                style: _headerStyle,
              ),
            ),
            widget.formFields,
          ],
        ),
      ),
    );
  }
}
