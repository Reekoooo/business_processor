import 'package:business_processor/BLoC/bloc_provider.dart';
import 'package:business_processor/BLoC/client_bloc.dart';
import 'package:business_processor/Screens/list_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) {
    return new MaterialApp(
        title: 'baccarat app',
        home: BlocProvider(
          bloc: ClientBloc(),
          child: ListScreen(),
        ));
  }
}
