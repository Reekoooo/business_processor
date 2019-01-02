import 'dart:convert';

class Location {
  String name;
  String wise;
  String counter;
  String rating;
  Location({this.name, this.wise, this.counter, this.rating});

  factory Location.fromMap(Map<String, dynamic> json) => new Location(
        name: json['name'],
        wise: json['wise'],
        counter: json['counter'],
        rating: json['rating'],
      );

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['wise'] = wise;
    map['counter'] = counter;
    map['rating'] = rating;
    return map;
  }
}

Location locationFromJson(String str) {
  final jsonData = json.decode(str);
  return Location.fromMap(jsonData);
}

String locationToJson(Location data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

List<Location> listOfLocFromJson(String str) {
  List<Location> _list =[];
  List<String> _jsonList = json.decode(str);
  _jsonList.forEach((_json) {_list.add(locationFromJson(_json));});
  return _list;
}

String listOfLocToJson(List<Location> data) {
  List<String> _jsonList;
  data.forEach((_location) {_jsonList.add(locationToJson(_location));});
  return json.encode(_jsonList);
}

