import 'package:create_account/features/account/presentation/pages/confirmation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../model/person_account.dart';
import '../bloc/create_user_account_bloc.dart';

class EndpointEntry extends StatefulWidget {
  PersonAccount personAccount;

  EndpointEntry(this.personAccount);

  @override
  State<EndpointEntry> createState() => _EndpointEntryState();
}

class _EndpointEntryState extends State<EndpointEntry> {
  final cubit = GetIt.instance<CreateUserAccountCubit>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _validate = false;

  late String _endpoint = '';

  final TextEditingController _endpointController = TextEditingController();

  final _themeColor = Colors.greenAccent;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: BlocProvider<CreateUserAccountCubit>(
          create: (context) => cubit,
          child: _body(context),
        ));
  }

  Widget _body(BuildContext context) {
    return BlocListener<CreateUserAccountCubit, CreateUserAccountState>(
      listener: (context, state) {
        _createUserAccountBlocListener(context, state);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _endpointController,
            cursorColor: _themeColor,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.link,
                color: _themeColor,
              ),
              labelText: 'URL *',
              floatingLabelStyle: TextStyle(color: _themeColor),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _themeColor)),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              String? _response = _validateEndpoint(value!);
              return _response;
            },
            onChanged: (value) {
              _endpoint = value;
            },
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
                child: Text("ENVIAR CADASTRO")),
          )
        ],
      ),
    );
  }

  _createUserAccountBlocListener(context, state) {
    if (state is CreateUserAccountLoadingState) {
      return const CircularProgressIndicator();
    } else if (state is CreateUserAccountLoadedState) {
      if (state.data != null && state.data.userId != null) {
        //navigator para tela de confirmação
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Confirmation()));
      } else {
        _errorMessage(context);
      }
    } else if (state is CreateUserAccountErrorState) {
      _errorMessage(context);
    }
  }

  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      elevation: 4.0,
      duration: Duration(seconds: 6),
      backgroundColor: Colors.greenAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25.0))),
      content: Text("Não foi possível cadastrar o usuário. ",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    ));
  }

  String? _validateEndpoint(String value) {
    if (value.length == 0) {
      return "Favor informar a URL";
    } else if (!value.startsWith('https://')) {
      return 'Favor informar uma URL válida';
    } else {
      return null;
    }
  }

  void _sendForm() {
    if (_formKey.currentState!.validate()) {
      // Sem erros na validação
      _formKey.currentState!.save();
      print(widget.personAccount.toJson());
      cubit..registerUserAccount(widget.personAccount, _endpoint);

      /* Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => AccountForm(
                  [ContactInformation(widget.personAccount), "Endereço"])));*/
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }
}
