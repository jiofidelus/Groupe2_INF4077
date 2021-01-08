import 'package:compiled/utils/date-formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class Patient extends Equatable {
  static var lastID = 0;
  final int id;
  final String name;
  final String email;
  final String picture;
  final String phone;
  final DateTime birthday;
  final int birthCity;
  final int createdAt;
  final DateTime createdOn;

  Patient({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.picture,
    @required this.phone,
    @required this.birthday,
    @required this.birthCity,
    @required this.createdAt,
    @required this.createdOn,
  }) {
    if (id > lastID) {
      lastID = id;
    }
  }

  factory Patient.create(
      {@required name,
      @required phone,
      @required birthday,
      @required email,
      @required birthCity,
      @required picture}) {
    return new Patient(
      id: lastID++,
      name: name,
      email: email,
      picture: picture,
      phone: phone,
      birthday: birthday,
      birthCity: birthCity,
      createdAt: 3,
      createdOn: DateTime.now(),
    );
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return new Patient(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      picture: map['picture'] as String,
      phone: map['phone'] as String,
      birthday: DateTime.tryParse(map['birthday']),
      birthCity: map['birthCity'] as int,
      createdAt: map['createdAt'] as int,
      createdOn: DateTime.tryParse(map['createdOn']),
    );
  }

  String get cleanBirthday {
    return dateFormatter(birthday);
  }

  String get cleanCreatedOn {
    return dateFormatter(createdOn);
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'picture': this.picture,
      'phone': this.phone,
      'birthday': this.birthday.toIso8601String(),
      'birthCity': this.birthCity,
      'createdAt': this.createdAt,
      'createdOn': this.createdOn.toIso8601String(),
    } as Map<String, dynamic>;
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        name,
        email,
        picture,
        phone,
        createdOn,
        birthCity,
        birthday,
        createdAt
      ];
}
