import 'package:flutter/material.dart';

class FormCard extends StatefulWidget {
  Widget formFields;
  String header;

  FormCard(this.formFields, this.header);

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {

  bool _isExpanded = false;

  void _checkExpanded(){
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }


  @override
  void initState() {
    _isExpanded = false;
    super.initState();
  }

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
      boxShadow: _boxShadow ,

    );
    return GestureDetector(
      onTap: (){
        _checkExpanded();
      },
      child: Container(
        alignment: Alignment.center,
        //height: _isExpanded ? 150 : 40,
        decoration: _boxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.header),
                  Icon( _isExpanded ?
                  Icons.arrow_circle_up_outlined
                      : Icons.arrow_circle_down_outlined, color: Colors.greenAccent,)
                ],
              ),
              _isExpanded ?
              widget.formFields
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
