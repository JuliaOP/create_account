import 'package:create_account/features/account/presentation/pages/account_form.dart';
import 'package:create_account/features/account/presentation/widgets/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _validate = false;
  late String _name;
  late String _cpfOrCnpj;
  late String _credentialsHintText;
  late dynamic _credentialsMask;

  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  final maskCNPJ = MaskTextInputFormatter(
      mask: "##.###.###/####-##", filter: {"#": RegExp(r'[0-9]')});

  final TextEditingController _credentialsController = TextEditingController();

  @override
  void initState() {
    _credentialsHintText = 'CPF';
    _credentialsMask = maskCpf;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: _formBody(context),
    );
  }

  Widget _formBody(BuildContext context) {
    const _themeColor = Colors.greenAccent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            TextFormField(
              cursorColor: _themeColor,
              decoration: const InputDecoration(
                hintText: 'Nome Completo',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _themeColor)),
              ),
              keyboardType: TextInputType.text,
              maxLength: 50,
              validator: (value) {
                String? _response = _validateName(value!);
                return _response;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton(
                value: _credentialsHintText,
                onChanged: (item) {},
                items: [
                  DropdownMenuItem(
                    value: 'CPF',
                    onTap: () {
                      setState(() {
                        _credentialsHintText = 'CPF';
                        _credentialsController.text = '';
                        _credentialsMask = maskCpf;
                      });
                    },
                    child: Text("CPF"),
                  ),
                  DropdownMenuItem(
                      value: 'CNPJ',
                      onTap: () {
                        setState(() {
                          _credentialsHintText = 'CNPJ';
                          _credentialsController.text = '';
                          _credentialsMask = maskCNPJ;
                        });
                      },
                      child: Text("CNPJ"))
                ],
              ),
            ),
            TextFormField(
              controller: _credentialsController,
              cursorColor: _themeColor,
              decoration: InputDecoration(
                  hintText: _credentialsHintText,
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: _themeColor))),
              keyboardType: TextInputType.number,
              validator: (value) {
                String? _response = _validateCredentials(value!);
                return _response;
              },
              inputFormatters: [_credentialsMask],
              onSaved: (value) {
                _cpfOrCnpj = value!;
              },
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
              onPressed: () {
                _sendForm();
              },
              style: ElevatedButton.styleFrom(
                  primary: _themeColor,
                  textStyle: const TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 1.5)),
              child: Text("CONTINUAR")),
        )
      ],
    );
  }

  String? _validateCredentials(String value) {
    bool _isCPF = _credentialsHintText == 'CPF';

    if (value.length == 0) {
      return "Informe o CPF ou CNPJ";
    } else if (value.length < 18 && value.length > 14 ||
        value.length == 14 && !_isCPF) {
      return 'Informe um CNPJ válido';
    } else if (value.length < 14 && _isCPF) {
      return 'Informe um CPF válido';
    } else {
      return null;
    }
  }

  String? _validateName(String value) {
    if (value.length == 0) {
      return "Informe seu nome";
    } else if (!value.contains(' ')) {
      return 'Informe seu nome completo';
    } else {
      return null;
    }
  }

  void _sendForm() {
    if (_formKey.currentState!.validate()) {
      // Sem erros na validação
      _formKey.currentState!.save();
      print("Nome $_name");
      print("cpf/cnpj $_cpfOrCnpj");
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => AccountForm([Address(), "Endereço"])));
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }
}
