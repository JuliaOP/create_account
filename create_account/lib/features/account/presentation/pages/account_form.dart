import 'package:create_account/features/account/presentation/widgets/personal_information.dart';
import 'package:flutter/material.dart';

import '../widgets/form_card.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({Key? key}) : super(key: key);

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context){
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FormCard(
                  PersonalInformation(),
                  "Informações Pessoais"

              ),
              SizedBox(
                height: 8.0,
              ),
              FormCard(
                PersonalInformation(),
                "Endereço"

              ),
              SizedBox(
                height: 8.0,
              ),
              FormCard(
                  PersonalInformation(),
                  "Contato"

              ),
            ],
          ),
        )
      ),
    );
  }
}
