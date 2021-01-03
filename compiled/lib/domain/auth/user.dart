import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String name;
  final String telephone;

  @override
  // TODO: implement props
  List<Object> get props => [name, telephone];

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const User({
    @required this.name,
    @required this.telephone,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      name: map['name'] as String,
      telephone: map['telephone'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'telephone': this.telephone,
    } as Map<String, dynamic>;
  }
}
