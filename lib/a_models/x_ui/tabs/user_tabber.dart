import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';

enum UserTab {
  profile,
  notifications,
  following,
  settings,
}
/// => TAMAM
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
  /// TAMAM : WORKS PERFECT
  static String? getUserTabIcon(UserTab? userTab){
    switch(userTab){
      case UserTab.profile        : return UsersProvider.proGetMyUserModel(
                                                context: getMainContext(),
                                                listen: false
                                              )?.picPath;
      case UserTab.notifications  : return Iconz.notification ;
      case UserTab.following      : return Iconz.follow       ;
      case UserTab.settings       : return Iconz.gears        ;
      default : return null;
    }
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static String? getUserTabID(UserTab? userTab){
    /// CAUTION : THIS HAS TO REMAIN IN ENGLISH ONLY WITH NO TRANSLATIONS
    /// BECAUSE THESE VALUES ARE USED IN WIDGETS KEYS
    switch(userTab){
      case UserTab.profile        : return  'Profile'       ;
      case UserTab.notifications  : return  'Notifications' ;
      case UserTab.following      : return  'Following'     ;
      case UserTab.settings       : return  'Settings'      ;
      default: return null;
    }
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static String? _getUserTabPhid(UserTab? userTab){
    switch(userTab){
      case UserTab.profile        : return  'phid_profile'       ;
      case UserTab.notifications  : return  'phid_notifications' ;
      case UserTab.following      : return  'phid_followed_bz'   ;
      case UserTab.settings       : return  'phid_settings'      ;
      default: return null;
    }
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static Verse translateUserTab(UserTab userTab){
    final String? _tabPhraseID = _getUserTabPhid(userTab);
    return Verse(
      id: _tabPhraseID,
      translate: true,
    );
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static int getUserTabIndex(UserTab userTab){
    final int _index = userProfileTabsList.indexWhere((tab) => tab == userTab);
    return _index;
  }
  // -----------------------------------------------------------------------------
}
