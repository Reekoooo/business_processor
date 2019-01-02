import 'package:business_processor/BLoC/bloc_provider.dart';
import 'package:business_processor/BLoC/client_bloc.dart';
import 'package:business_processor/Models/client_model.dart';
import 'package:business_processor/Screens/client_screen.dart';
import 'package:business_processor/Screens/save_client.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  final String _title = 'select client';
  @override
  Widget build(BuildContext context) {
    final ClientBloc bloc = BlocProvider.of<ClientBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: StreamBuilder<List<Client>>(
          stream: bloc.streamList,
          builder:
              (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  padding: const EdgeInsets.all(15.0),
                  itemBuilder: (context, position) {
                    return ListTile(
                        leading: Text(
                          snapshot.data[position].id.toString(),
                          textScaleFactor: 5.0,
                        ),
                        title: Text(snapshot.data[position].name),
                        subtitle: Text(snapshot.data[position].company),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    bloc: ClientBloc(),
                                    child: ClientScreen(
                                        client: snapshot.data[position])))));
                  });
            }
            return CircularProgressIndicator();
          }),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BlocProvider(bloc: ClientBloc(), child: SaveClient())))),
    );
  }
}
