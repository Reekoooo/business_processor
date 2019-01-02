import 'dart:convert';

class Info {
  final String name;
  final String company;
  Info({this.name,this.company});

  factory Info.fromMap(Map<String, dynamic> json) => new Info(
        name: json['name'],
        company: json['company'],
    );

  Map<String, dynamic> toMap()  {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['company'] = company;
      return map;
  }
}

Info infoFromJson(String str) {
  final jsonData = json.decode(str);
  return Info.fromMap(jsonData);
}

String infoToJson(Info data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
