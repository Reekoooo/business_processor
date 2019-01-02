import 'dart:async';
import 'package:business_processor/BLoC/bloc_provider.dart';
import 'package:business_processor/DB/database.dart';
import 'package:business_processor/Models/client_model.dart';


class ClientBloc implements BlocBase {
  final DatabaseHelper _db = DatabaseHelper();

  final StreamController<List<Client>> _listController = StreamController<List<Client>>();
  Sink<List<Client>> get  sinkList => _listController.sink;
  Stream<List<Client>> get streamList => _listController.stream;

  final StreamController<Client> _saveClientCtrl = StreamController<Client>();
  Sink<Client> get  sinkSave => _saveClientCtrl.sink;

  final StreamController<Client> _delClientCtrl = StreamController<Client>();
  Sink<Client> get  sinkDel => _delClientCtrl.sink;
  
  final StreamController<Client> _upClientCtrl = StreamController<Client>();
  Sink<Client> get  sinkUp => _upClientCtrl.sink;

  ClientBloc(){
    _upList();
    _saveClientCtrl.stream.listen(_saveClient);
    _delClientCtrl.stream.listen(_delClient);
    _upClientCtrl.stream.listen(_upClient);
  }

  @override
  void dispose() {
    _listController.close();
    _saveClientCtrl.close();
    _delClientCtrl.close();
    _upClientCtrl.close();
  }
 
  void _saveClient(Client client) {
    _db.saveClient(client);
    _upList();
  }

  void _delClient(Client client) {
    _db.deleteClient(client);
    _upList();
  }

  void _upClient(Client client) {
    _db.updateClient(client);
    _upList();
  }

  void _upList() async {
    List<Client> _list = await _db.getClientsList();
    sinkList.add(_list);
  }

}