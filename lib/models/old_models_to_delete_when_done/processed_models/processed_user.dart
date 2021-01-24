import 'package:flutter/material.dart';

class ProcessedUserData with ChangeNotifier{
  final String userID;
  final String name;
  final String pic;
  final String title;
  final String userCity;
  final String userCountry;
  final int userPhone;
  final bool userWhatsAppIsOn;
  final String userEmail;
  final String userFacebook;
  final String userTwitter;
  final String userInstagram;
  final String userLinkedIn;

  ProcessedUserData({
    @required this.userID,
    @required this.name,
    @required this.pic,
    @required this.title,
    @required this.userCity,
    @required this.userCountry,
    this.userPhone,
    this.userWhatsAppIsOn,
    this.userEmail,
    this.userFacebook,
    this.userTwitter,
    this.userInstagram,
    this.userLinkedIn,

  });
}
