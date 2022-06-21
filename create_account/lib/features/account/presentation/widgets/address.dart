import 'package:create_account/features/account/model/address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../bloc/viacep_bloc.dart';
import '../pages/account_form.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final cubit = GetIt.instance<ViaCepCubit>();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _validate = false;
  bool _enableField = false;

  late final AddressModel _address = AddressModel();
  final cepMask = MaskTextInputFormatter(
      mask: "##.###-###", filter: {"#": RegExp(r'[0-9]')});

  late String _cep;
  late String _logradouro;
  late String _numero;
  late String _bairro;
  late String _cidade;
  late String _estado;

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: BlocProvider<ViaCepCubit>(
          create: (context) => cubit, child: _formBody(context)),
    );
  }

  Widget _formBody(BuildContext context) {
    const _themeColor = Colors.greenAccent;

    return BlocListener<ViaCepCubit, ViaCepState>(
      listener: (context, state) {
        _viaCepBlocListener(context, state);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              TextFormField(
                controller: _cepController,
                cursorColor: _themeColor,
                decoration: const InputDecoration(
                  hintText: 'CEP',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _themeColor)),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [cepMask],
                validator: (value) {
                  String? _response = _validateCep(value!);
                  return _response;
                },
                /*
                onSaved: (value) {
                  _cep = value!;
                  cubit..getCepInfo(_cep);
                },*/
                onFieldSubmitted: (value) {
                  _cep = value!;
                  cubit..getCepInfo(_cep);
                },
              ),
              TextFormField(
                enabled: _enableField,
                controller: _logradouroController,
                cursorColor: _themeColor,
                decoration: const InputDecoration(
                  hintText: 'Logradouro',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _themeColor)),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  String? _response = _validateName(value!);
                  return _response;
                },
                onSaved: (value) {
                  _logradouro = value!;
                },
              ),
              TextFormField(
                enabled: _enableField,
                controller: _numeroController,
                cursorColor: _themeColor,
                decoration: const InputDecoration(
                  hintText: 'Numero',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _themeColor)),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  String? _response = _validateName(value!);
                  return _response;
                },
                onSaved: (value) {
                  _numero = value!;
                },
              ),
              TextFormField(
                enabled: _enableField,
                controller: _bairroController,
                cursorColor: _themeColor,
                decoration: const InputDecoration(
                  hintText: 'Bairro',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _themeColor)),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  String? _response = _validateName(value!);
                  return _response;
                },
                onSaved: (value) {
                  _bairro = value!;
                },
              ),
              TextFormField(
                enabled: _enableField,
                controller: _cidadeController,
                cursorColor: _themeColor,
                decoration: const InputDecoration(
                  hintText: 'Cidade',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _themeColor)),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  String? _response = _validateName(value!);
                  return _response;
                },
                onSaved: (value) {
                  _cidade = value!;
                },
              ),
              TextFormField(
                enabled: _enableField,
                controller: _estadoController,
                cursorColor: _themeColor,
                decoration: const InputDecoration(
                  hintText: 'Estado',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _themeColor)),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  String? _response = _validateName(value!);
                  return _response;
                },
                onSaved: (value) {
                  _estado = value!;
                },
              ),
            ],
          ),
          const SizedBox(
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
      ),
    );
  }

  _viaCepBlocListener(context, state) {
    if (state is ViaCepLoadingState) {
      return CircularProgressIndicator();
    } else if (state is ViaCepLoadedState) {
      if (state.data != null) {
        //TODO: do things here
      } else {
        _errorMessage(context);
      }
    } else if (state is ViaCepErrorState) {
      _errorMessage(context);
    }
  }

  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      elevation: 4.0,
      backgroundColor: Colors.greenAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25.0))),
      content: Text(
          "Não foi possível carregar os dados para o CEP informado. Favor preencher os campos de endereço. ",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    ));
  }

  String? _validateCep(String value) {
    if (value.length == 0) {
      return "Informe o CEP";
    } else if (value.length < 10) {
      return 'Informe um CEP válido';
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
      //print("Nome $_name");
      //print("cpf/cnpj $_cpfOrCnpj");
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
