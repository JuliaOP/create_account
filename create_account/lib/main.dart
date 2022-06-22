import 'package:create_account/features/account/presentation/pages/account_form.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/account/presentation/widgets/personal_information.dart';
import 'shared/data/locator.dart' as locator;

GetIt getIt = GetIt.instance;

void main() {
  locator.getSetupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccountForm([PersonalInformation(), "Informações Pessoais"]),
    );
  }
}
