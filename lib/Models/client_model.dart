import 'dart:convert';

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
}

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
