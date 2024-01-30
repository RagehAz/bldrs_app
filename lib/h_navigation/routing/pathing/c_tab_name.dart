// ignore_for_file: constant_identifier_names
part of bldrs_routing;

class TabName {
  // -----------------------------------------------------------------------------

  const TabName();

  // -----------------------------------------------------------------------------

  /// MIRAGE BUTTONS (BID is ButtonID)

  // --------------------
  static const String bid_Home = 'bidHome';
  static const String bid_Zone = 'bidZone';
  static const String bid_Auth = 'bidAuth';
  static const String bid_MyProfile = 'bidMyProfile';
  static const String bid_MyBzz = 'bidMyBzz';
  static const String bid_AppSettings = 'bidAppSettings';
  // --------------------
  static const String bid_My_Info = 'bidMyInfo';
  static const String bid_My_Saves = 'bidMySaves';
  static const String bid_My_Notes = 'bidMyNotes';
  static const String bid_My_Follows = 'bidMyFollows';
  static const String bid_My_Settings = 'bidMySettings';
  // --------------------
  static const String bid_MyBz_Info = 'bidMyBzInfo';
  static const String bid_MyBz_Flyers = 'bidMyBzFlyers';
  static const String bid_MyBz_Team = 'bidMyBzTeam';
  static const String bid_MyBz_Notes = 'bidMyBzNotes';
  static const String bid_MyBz_Settings = 'bidMyBzSettings';
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateAllBids({
    required BuildContext context,
    required bool listen,
  }){

    const List<String> _initialList = [
      bid_Home,
      bid_Zone,
      bid_Auth,
      bid_MyProfile,
      bid_MyBzz,
      bid_AppSettings,

      bid_My_Info,
      bid_My_Notes,
      bid_My_Saves,
      bid_My_Follows,
      bid_My_Settings,
    ];

    final List<String> _myBzzBids = generateMyBzzBids(
      context: context,
      listen: listen,
    );

    return Stringer.addStringsToStringsIfDoNotContainThem(
      listToTake: _initialList,
      listToAdd: _myBzzBids,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateMyBzzBids({
    required BuildContext context,
    required bool listen,
  }){
    final List<String> _output = [];

    final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(
        context: context,
        listen: listen
    );

    if (Lister.checkCanLoop(_myBzzIDs) == true){

      for (final String bzID in _myBzzIDs){

        _output.addAll([
          ...generateBzBids(bzID: bzID),
        ]);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateBzBids({
    required String bzID,
  }){
    final List<String> _output = [];

    _output.addAll([

      generateBzBid(bzID: bzID, bid: bid_MyBz_Info),
      generateBzBid(bzID: bzID, bid: bid_MyBz_Flyers),
      generateBzBid(bzID: bzID, bid: bid_MyBz_Team),
      generateBzBid(bzID: bzID, bid: bid_MyBz_Notes),
      generateBzBid(bzID: bzID, bid: bid_MyBz_Settings),

    ]);

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateBzBid({
    required String bzID,
    required String? bid,
  }){

    if (bid == null){
      return 'bidBz/$bzID';
    }

    else {
      return 'bidBz_$bid/$bzID';
    }

  }
  // -----------------------------------------------------------------------------

  /// BidBz break-down

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzIDFromBidBz({
    required String? bzBid,
  }){
    String? _output;

    if (checkBidIsBidBz(bid: bzBid) == true){

      _output = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: bzBid,
        specialCharacter: '/',
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBidFromBidBz({
    required String? bzBid,
  }){
    String? _output;

    if (checkBidIsBidBz(bid: bzBid) == true){

      _output = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: bzBid,
        specialCharacter: '_',
      );

      _output = TextMod.removeTextAfterLastSpecialCharacter(
        text: _output,
        specialCharacter: '/',
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBidIsBidBz({
    required String? bid,
  }){
    return TextCheck.stringStartsExactlyWith(text: bid, startsWith: 'bidBz');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBidIcon(String? bid){
    switch(bid){

      case bid_MyProfile             : return UsersProvider.proGetMyUserModel(
          context: getMainContext(),
          listen: false
      )?.picPath;

      case bid_My_Info                : return Iconz.normalUser ;
      case bid_My_Notes               : return Iconz.notification ;
      case bid_My_Saves               : return Iconz.love ;
      case bid_My_Follows             : return Iconz.follow       ;
      case bid_My_Settings            : return Iconz.gears        ;

      case bid_MyBz_Info              : return Iconz.info;
      case bid_MyBz_Flyers            : return Iconz.flyerGrid;
      case bid_MyBz_Team              : return Iconz.bz;
      case bid_MyBz_Notes             : return Iconz.notification;
      case bid_MyBz_Settings          : return Iconz.gears;
    // case BzTab.targets  : return Iconz.target     ;
    // case BzTab.powers   : return Iconz.power      ;
    // case BzTab.network  : return Iconz.follow     ;

      default : return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _getBidPhid(String? bid){

    String? _bid = bid;
    if (checkBidIsBidBz(bid: _bid) == true){
      _bid = getBidFromBidBz(bzBid: _bid);
    }

    switch(_bid){

      case bid_My_Info                : return  'phid_profile'       ;
      case bid_My_Notes               : return  'phid_notifications' ;
      case bid_My_Saves               : return  'phid_savedFlyers' ;
      case bid_My_Follows             : return  'phid_followed_bz'   ;
      case bid_My_Settings            : return  'phid_settings'      ;

      case bid_MyBz_Info              : return 'phid_info';
      case bid_MyBz_Flyers            : return 'phid_flyers';
      case bid_MyBz_Team              : return 'phid_team';
      case bid_MyBz_Notes             : return 'phid_notifications';
      case bid_MyBz_Settings          : return 'phid_settings';
    // case BzTab.targets  : return 'phid_targets'  ; break;
    // case BzTab.powers   : return 'phid_powers'  ; break;
    // case BzTab.network  : return 'phid_network'  ; break;

      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse translateBid(String? bid){
    final String? _phid = _getBidPhid(bid);
    return Verse(
      id: _phid,
      translate: true,
    );
  }
  // -----------------------------------------------------------------------------
}
