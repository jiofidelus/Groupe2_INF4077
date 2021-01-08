import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HLocation extends Equatable {
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
  // TODO: implement props
  List<Object> get props => [name, code, id, lat, long];
}
