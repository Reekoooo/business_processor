import 'package:business_processor/BLoC/bloc_provider.dart';
import 'package:business_processor/BLoC/client_bloc.dart';
import 'package:business_processor/Models/client_model.dart';
import 'package:business_processor/Screens/list_screen.dart';
import 'package:business_processor/Models/info_model.dart';
import 'package:flutter/material.dart';


class EditClient extends StatelessWidget {
  final Client client;
  final String _title = 'edit client';
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _companyController = new TextEditingController();

  EditClient({this.client});
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
                    decoration: InputDecoration(hintText: client.name))),
            ListTile(
                title: TextField(
                    controller: _companyController,
                    decoration: InputDecoration(hintText: client.company))),
            Row(
              children: <Widget>[
                RaisedButton(
                    child: Icon(Icons.check),
                    onPressed: () {
                      bloc.sinkUp.add(Client(
                        id: client.id,
                        info: infoToJson(Info(
                          name: _nameController.text??client.name,
                          company: _companyController.text??client.company)),
                        locations: client.locations
                      ),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  bloc: ClientBloc(), child: ListScreen()))));}
                    ),
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
