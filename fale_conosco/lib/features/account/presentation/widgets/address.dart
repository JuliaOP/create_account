import 'package:create_account/features/account/model/address_model.dart';
import 'package:create_account/features/account/presentation/widgets/endpoint_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../model/person_account.dart';
import '../bloc/viacep_bloc.dart';
import '../pages/account_form.dart';

class Address extends StatefulWidget {
  PersonAccount personAccount;

  Address(this.personAccount);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final cubit = GetIt.instance<ViaCepCubit>();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _validate = false;
  bool _enablePriorityField = false;
  bool _enableSecondaryField = false;

  late AddressModel _address = AddressModel();
  final cepMask = MaskTextInputFormatter(
      mask: "##.###-###", filter: {"#": RegExp(r'[0-9]')});

  final _themeColor = Colors.greenAccent;

  late String _cep = '';
  late String _logradouro = '';
  late String _numero = '';
  late String _complemento = '';
  late String _bairro = '';
  late String _cidade = '';
  late String _estado = '';

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
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
                decoration: InputDecoration(
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
                onChanged: (value) {
                  _cep = value;
                  if (_cep.length == 10) {
                    cubit..getCepInfo(_cep);
                  }
                },
              ),
              _formField('Logradouro', TextInputType.text, (value) {
                _logradouro = value!;
              }, _enablePriorityField, _logradouroController),
              _formField('Numero', TextInputType.text, (value) {
                _numero = value!;
              }, _enableSecondaryField, _numeroController),
              _formField('Complemento', TextInputType.text, (value) {
                _complemento = value!;
              }, _enableSecondaryField, _complementoController),
              _formField('Bairro', TextInputType.text, (value) {
                _bairro = value!;
              }, _enablePriorityField, _bairroController),
              _formField('Cidade', TextInputType.text, (value) {
                _cidade = value!;
              }, _enablePriorityField, _cidadeController),
              _formField('Estado', TextInputType.text, (value) {
                _estado = value!;
              }, _enablePriorityField, _estadoController)
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: () {
                  if (_numero.isNotEmpty) {
                    _address.number = _numero;
                  }
                  if (_complemento.isNotEmpty) {
                    _address.complement = _complemento;
                  }
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

  Widget _formField(String hintText,
      TextInputType keyboardType,
      void Function(String?)? onSaved,
      bool enable,
      TextEditingController controller) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      cursorColor: _themeColor,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: _themeColor)),
      ),
      keyboardType: keyboardType,
      onSaved: onSaved,
    );
  }

  _viaCepBlocListener(context, state) {
    if (state is ViaCepLoadingState) {
      return CircularProgressIndicator();
    } else if (state is ViaCepLoadedState) {
      if (state.data != null && state.data.street != null) {
        _address = state.data;
        _setDefinedFieldsText();
      } else {
        _errorMessage(context);
        _enableManualFieldsFilling();
      }
    } else if (state is ViaCepErrorState) {
      _errorMessage(context);
      _enableManualFieldsFilling();
    }
  }

  _enableManualFieldsFilling() {
    setState(() {
      _enableSecondaryField = true;
      _enablePriorityField = true;
    });
  }

  _setDefinedFieldsText() {
    setState(() {
      _enableSecondaryField = true;
      _enablePriorityField = false;
      _estadoController.text = _address.state!;
      _bairroController.text = _address.neighborhood!;
      _cidadeController.text = _address.city!;
      _logradouroController.text = _address.street!;
    });
  }

  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      elevation: 4.0,
      duration: Duration(seconds: 6),
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

  void _sendForm() {
    bool _hasAddress = _address.zipcode!.isNotEmpty &&
        _address.state!.isNotEmpty &&
        _address.city!.isNotEmpty &&
        _address.neighborhood!.isNotEmpty &&
        _address.street!.isNotEmpty;

    if (_formKey.currentState!.validate() && _hasAddress) {
      // Sem erros na validação
      widget.personAccount.address = AddressModel();
      widget.personAccount.address = _address;
      _formKey.currentState!.save();
      print(widget.personAccount.toJson());

      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  AccountForm(
                      [
                        EndpointEntry(widget.personAccount),
                        "URL do Endpoint"
                      ])));
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }
}
