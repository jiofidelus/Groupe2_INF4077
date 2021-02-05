import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HLocation extends Equatable {
  static const List<HLocation> regions = [
  
    HLocation(name: "Adamawa", code: "AD", id: 1),
  
    HLocation(name: "Center", code: "CE", id: 2),
  
    HLocation(name: "East", code: "ES", id: 3),
  
    HLocation(name: "Far North", code: "FN", id: 4),
  
    HLocation(name: "Littoral", code: "LT", id: 5),
  
    HLocation(name: "North", code: "NT", id: 6),
  
    HLocation(name: "Northwest", code: "NW", id: 7),
  
    HLocation(name: "South", code: "ST", id: 8),
  
    HLocation(name: "Southwest", code: "SW", id: 9),
  
    HLocation(name: "West", code: "WT", id: 10),
  

  ];

  final String name;
  final String code;
  final int id;
  final double lat;
  final double long;

  const HLocation(
      {@required this.name,
      @required this.code,
      @required this.id,
      this.lat,
      this.long});

  factory HLocation.fromMap(Map<String, dynamic> map) {
    return new HLocation(
      name: map['name'] as String,
      code: map['code'] as String,
      lat: map['lat'] as double,
      long: map['long'] as double,
      id: map['id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'code': this.code,
      'id': this.id,
      'lat': this.lat,
      'long': this.long,
    } as Map<String, dynamic>;
  }


  @override
  List<Object> get props => [name, code, id, lat, long];
}