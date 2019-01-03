import 'package:business_processor/BLoC/bloc_provider.dart';
import 'package:business_processor/BLoC/client_bloc.dart';
import 'package:business_processor/Models/client_model.dart';
import 'package:business_processor/Screens/edit_client.dart';
import 'package:business_processor/Screens/list_screen.dart';
import 'package:flutter/material.dart';


class ClientScreen extends StatelessWidget {
  final Client client;
  final String _title = 'selected client';
  ClientScreen({this.client});


  @override
  Widget build(BuildContext context) {
    final ClientBloc bloc = BlocProvider.of<ClientBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Text(client.id.toString()),
              title: Text(client.name),
              subtitle: Text(client.company),
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                    child: Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                bloc: ClientBloc(),
                                child: EditClient(
                                  client: client,
                                ))))),
                RaisedButton(
                    child: Icon(Icons.delete),
                    onPressed: () {
                      bloc.sinkDel.add(client);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  bloc: ClientBloc(), 
                                  child: ListScreen()
                                  )
                                  )
                                  );
                    })
              ],
            ),
            RaisedButton(child: Icon(Icons.arrow_forward), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
