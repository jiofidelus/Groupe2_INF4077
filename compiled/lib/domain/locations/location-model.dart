import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
class Location extends Equatable{
  final String name;
  final String code;
  final int id;

  const Location({
    @required this.name,
    @required this.code,
    @required this.id,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return new Location(
      name: map['name'] as String,
      code: map['code'] as String,
      id: map['id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'code': this.code,
      'id': this.id,
    } as Map<String, dynamic>;
  }

  @override
  // TODO: implement props
  List<Object> get props => [name, code, id];
}
