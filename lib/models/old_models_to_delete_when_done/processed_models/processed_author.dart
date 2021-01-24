import 'package:flutter/foundation.dart';

class ProcessedAuthorData{
      final String authorID;
      final String authorName;
      final String authorPic;
      final String authorTitle;
      final List<String> authorFlyersIDs;
      final int authorFlyersCount; // should remove this and calculate length of authorFlyersIDs
      final int authorPhone;
      final String authorEmail;
      final String authorFacebook;
      final String authorTwitter;
      final String authorInstagram;
      final String authorLinkedIn;
      final bool authorWhatsAppIsOn;

      ProcessedAuthorData({
        @required this.authorID,
        @required this.authorName,
        @required this.authorPic,
        @required this.authorTitle,
        @required this.authorFlyersIDs,
        @required this.authorFlyersCount,
        this.authorPhone,
        this.authorEmail,
        this.authorFacebook,
        this.authorTwitter,
        this.authorInstagram,
        this.authorLinkedIn,
        this.authorWhatsAppIsOn,
    });

    }