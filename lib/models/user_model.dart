import 'package:flutter/foundation.dart';

class UserModel{
  final String userID;
  final String name;
  final String pic;
  final String title;
  final String userCity;
  final String userCountry;
  final bool userWhatsAppIsOn;

  UserModel({
    @required this.userID,
    @required this.name,
    @required this.pic,
    @required this.title,
    @required this.userCity,
    @required this.userCountry,
    this.userWhatsAppIsOn,
});
}