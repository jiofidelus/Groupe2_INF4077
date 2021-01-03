import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Failure extends Equatable {
  final int code;
  final String message;
  final String description;
  final String hint;

  const Failure({
    @required this.code,
    @required this.message,
    this.description = "No available description",
    this.hint = "No available hint",
  });

  @override
  List<Object> get props => [code, message, description, hint];
}
