import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

enum UserTab {
  profile,
  notifications,
  following,
  settings,
}

class UserTabber {
  // -----------------------------------------------------------------------------

  const UserTabber();

  // -----------------------------------------------------------------------------

  /// USER TABS

  // --------------------
  static const List<UserTab> userProfileTabsList = <UserTab>[
    UserTab.profile,
    UserTab.notifications,
    UserTab.following,
    UserTab.settings,
  ];
  // --------------------
  static String getUserTabIcon(UserTab userTab){
    switch(userTab){
      case UserTab.profile        : return Iconz.normalUser   ; break;
      case UserTab.notifications  : return Iconz.notification ; break;
      case UserTab.following      : return Iconz.follow       ; break;
      case UserTab.settings       : return Iconz.gears        ; break;
      default : return null;
    }
  }
  // --------------------
  /// CAUTION : THIS HAS TO REMAIN IN ENGLISH ONLY WITH NO TRANSLATIONS
  static String getUserTabID(UserTab userTab){
    /// BECAUSE THESE VALUES ARE USED IN WIDGETS KEYS
    switch(userTab){
      case UserTab.profile        : return  'Profile'       ; break;
      case UserTab.notifications  : return  'Notifications' ; break;
      case UserTab.following      : return  'Following'     ; break;
      case UserTab.settings       : return  'Settings'      ; break;
      default: return null;
    }
  }
  // --------------------
  static String _getUserTabPhid(UserTab userTab){
    switch(userTab){
      case UserTab.profile        : return  'phid_profile'       ; break;
      case UserTab.notifications  : return  'phid_notifications' ; break;
      case UserTab.following      : return  'phid_followed_bz'   ; break;
      case UserTab.settings       : return  'phid_settings'      ; break;
      default: return null;
    }
  }
  // --------------------
  static Verse translateUserTab({
    @required BuildContext context,
    @required UserTab userTab,
  }){
    final String _tabPhraseID = _getUserTabPhid(userTab);
    return Verse(
      text: _tabPhraseID,
      translate: true,
    );
  }
  // --------------------
  static int getUserTabIndex(UserTab userTab){
    final int _index = userProfileTabsList.indexWhere((tab) => tab == userTab);
    return _index;
  }


  // -----------------------------------------------------------------------------
  void f(){}
}