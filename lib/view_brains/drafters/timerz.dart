import 'package:intl/intl.dart';
// -----------------------------------------------------------------
/// "2019-07-19 8:40:23"
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
// -----------------------------------------------------------------
String cipherDateTimeToString(DateTime dateTime){
  return dateFormat.format(dateTime);
}
// -----------------------------------------------------------------
DateTime decipherDateTimeString(String dateTimeString){
  return dateFormat.parse(dateTimeString);
}
// -----------------------------------------------------------------
