import 'package:business_processor/BLoC/bloc_provider.dart';
import 'package:business_processor/BLoC/client_bloc.dart';
import 'package:business_processor/Models/client_model.dart';
import 'package:business_processor/Models/info_model.dart';
import 'package:business_processor/Models/location_model.dart';
import 'package:business_processor/Screens/list_screen.dart';
import 'package:flutter/material.dart';

class SaveClient extends StatelessWidget {
  final String _title = 'new client';
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _companyController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ClientBloc bloc = BlocProvider.of<ClientBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
                title: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'client name'))),
            ListTile(
                title: TextField(
                    controller: _companyController,
                    decoration: InputDecoration(hintText: 'client company'))),
            Row(
              children: <Widget>[
                RaisedButton(
                    child: Icon(Icons.save),
                    onPressed: () {
                      bloc.sinkSave.add(
                          Client(
                              info: infoToJson(Info(
                                  name: _nameController.text,
                                  company: _companyController.text)),
                              locations: listOfLocToJson([])),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                      bloc: ClientBloc(),
                                      child: ListScreen()))));
                    }),
                RaisedButton(
                  child: Icon(Icons.backspace),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                              bloc: ClientBloc(), child: ListScreen()))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
