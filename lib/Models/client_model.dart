import 'dart:convert';
import 'package:business_processor/Models/info_model.dart';
import 'package:business_processor/Models/location_model.dart';

class Client {
  int id;
  String info;
  String locations;

  Client({
    this.id,
    this.info,
    this.locations,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json['id'],
        info: json['info'],
        locations: json['locations']
      );

  Map<String, dynamic> toMap()  {
    var map = new Map<String, dynamic>();
        if (id != null) {
      map['id'] = id;
    }
    map['info'] = info;
    map['locations'] = locations;
      return map;
    }

    String get name => infoFromJson(info).name;
    String get company => infoFromJson(info).company;
    List<Location> get locationList => listOfLocFromJson(locations);

    void setInfo(String _name, String _company) => info=infoToJson(Info(company: _company, name: _name ));
  
}

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
