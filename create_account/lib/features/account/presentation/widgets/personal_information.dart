import 'package:create_account/features/account/model/person_account.dart';
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
  late PersonAccount _personAccount = PersonAccount();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _validate = false;
  late String _name = '';
  late String _cpfOrCnpj = '';
  late String _email = '';
  late String _phone = '';
  late String _credentialsHintText;
  late dynamic _credentialsMask;

  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  final maskCNPJ = MaskTextInputFormatter(
      mask: "##.###.###/####-##", filter: {"#": RegExp(r'[0-9]')});
  final maskPhone = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});

  final TextEditingController _credentialsController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _credentialsHintText = 'CPF';
    _credentialsMask = maskCpf;
    _personAccount = PersonAccount();
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
                prefixIcon: Icon(
                  Icons.person,
                  color: _themeColor,
                ),
                labelText: 'Nome Completo *',
                floatingLabelStyle: TextStyle(color: _themeColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _themeColor)),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                String? _response = _validateName(value!);
                return _response;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Text(
                "Forneça pelo menos uma das opções de contato abaixo:",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: _emailController,
              cursorColor: _themeColor,
              decoration: const InputDecoration(
                labelText: 'Email',
                floatingLabelStyle: TextStyle(color: _themeColor),
                prefixIcon: Icon(
                  Icons.email,
                  color: _themeColor,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _themeColor)),
              ),
              keyboardType: TextInputType.text,
              /*validator: (value) {
                String? _response = _validateName(value!);
                return _response;
              },*/
              onChanged: (value) {
                _email = value;
              },
            ),
            TextFormField(
              controller: _phoneController,
              cursorColor: _themeColor,
              inputFormatters: [maskPhone],
              decoration: const InputDecoration(
                labelText: 'Telefone',
                floatingLabelStyle: TextStyle(color: _themeColor),
                prefixIcon: Icon(
                  Icons.phone,
                  color: _themeColor,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _themeColor)),
              ),
              keyboardType: TextInputType.text,
              /*validator: (value) {
                String? _response = _validateName(value!);
                return _response;
              },*/
              onChanged: (value) {
                _phone = value;
              },
            ),
            SizedBox(
              height: 24,
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

  bool _validateContactInformation() {
    bool _hasEmail = _email.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_email) &&
        _email == _emailController.text;
    bool _hasPhone = _phone.isNotEmpty &&
        RegExp(r"^\(?[1-9]{2}\)? ?(?:[2-8]|9[1-9])[0-9]{3}\-?[0-9]{4}$")
            .hasMatch(_phone) &&
        _phone == _phoneController.text;

    return _hasEmail || _hasPhone;
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

  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      elevation: 4.0,
      backgroundColor: Colors.greenAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25.0))),
      content: Text("Favor fornecer ao menos uma opção de contato válida. ",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    ));
  }

  _sendForm() {
    bool _validateContact = _validateContactInformation();
    if (_formKey.currentState!.validate() && _validateContact) {
      // Sem erros na validação
      _personAccount.name = _name;
      _personAccount.credential = _cpfOrCnpj;
      _personAccount.email = _email.isNotEmpty &&
              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(_email)
          ? _email
          : '';
      _personAccount.phone = _phone.isNotEmpty &&
              RegExp(r"^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$")
                  .hasMatch(_phone)
          ? _phone
          : '';

      _formKey.currentState!.save();

      print(_personAccount.toJson());
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  AccountForm([Address(_personAccount), "Endereço"])));
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
      return _errorMessage(context);
    }
  }
}
