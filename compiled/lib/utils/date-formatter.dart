import 'package:intl/intl.dart';

String dateFormatter(DateTime date){
  final DateFormat formatter = DateFormat('MMM dd yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}
