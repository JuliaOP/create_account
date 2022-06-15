import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {

  @override
  Widget build(BuildContext context) {



    return Column(
      children: [
        Container(
          child: Text("hellooww"),
        ),
        Container()
      ],
    );
  }

}
