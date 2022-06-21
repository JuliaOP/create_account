import 'package:flutter/material.dart';

import '../widgets/form_card.dart';

class AccountForm extends StatefulWidget {
  final body;

  AccountForm(this.body);

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormCard(widget.body[0], widget.body[1]),
          ),
        ),
      ),
    );
  }
}
