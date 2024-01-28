import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabber.dart';
import 'package:bldrs/z_components/layouts/mirage/mirage.dart';

class MirageNav {
  // -----------------------------------------------------------------------------

  const MirageNav();

  // -----------------------------------------------------------------------------

  /// MAIN

  // --------------------
  static Future<void> _goHome() async {

    await _goToMainPages(
      bid: BldrsTabber.bidHome,
      tab: BldrsTab.home,
    );

    final MirageModel mirage1 = HomeProvider.proGetMirageByIndex(
        context: getMainContext(),
        listen: false,
        index: 1
    );

    /// SHOW MIRAGE 1
    mirage1.show(mounted: true);

  }
  // --------------------
  static Future<void> _goZone() => _goToMainPages(
    bid: BldrsTabber.bidZone,
    tab: BldrsTab.zone,
  );
  // --------------------
  static Future<void> _goAuth() => _goToMainPages(
    bid: BldrsTabber.bidAuth,
    tab: BldrsTab.auth,
  );
  // --------------------
  static Future<void> _goAppSettings() => _goToMainPages(
    bid: BldrsTabber.bidAppSettings,
    tab: BldrsTab.appSettings,
  );
  // --------------------
  static Future<void> _goToMainPages({
    required BldrsTab tab,
    required String bid,
  }) async {

    const bool mounted = true;

    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
      context: getMainContext(),
      listen: false,
    );

    final List<MirageModel> _miragesAbove = MirageModel.getMiragesAbove(
      allMirages: allMirages,
      aboveIndex: 0,
    );

    /// CLOSE ALL MIRAGES ABOVE 0
    MirageModel.hideMirages(
      models: _miragesAbove,
      mounted: mounted,
    );

    /// SELECT THE BUTTON IN MIRAGE 0
    HomeProvider.proSelectMirageButton(
      mirageIndex: 0,
      mounted: mounted,
      button: bid,
    );

    /// GO TO TAB
    await BldrsTabber.goToTab(tab: tab);

    /// SHOW MIRAGE 1
    allMirages[0].show(mounted: mounted);
    allMirages[0].hidePyramid(mounted: mounted);

    /// SCROLL TO
    await allMirages[0].scrollTo(
      buttonIndex: BldrsTabber.getButtonIndexInMainMirage(bid: bid),
      listLength: BldrsTabber.mainButtonsLength,
    );

  }
  // -----------------------------------------------------------------------------

  /// PROFILE

  // --------------------
  static Future<void> _goMyInfo() => _goToAUserTab(
    bid: BldrsTabber.bidMyInfo,
    tab: BldrsTab.myInfo,
  );
  // --------------------
  static Future<void> _goMySaves() => _goToAUserTab(
    bid: BldrsTabber.bidMySaves,
    tab: BldrsTab.mySaves,
  );
  // --------------------
  static Future<void> _goMyNotes() => _goToAUserTab(
    bid: BldrsTabber.bidMyNotes,
    tab: BldrsTab.myNotes,
  );
  // --------------------
  static Future<void> _goMyFollows() => _goToAUserTab(
    bid: BldrsTabber.bidMyFollows,
    tab: BldrsTab.myFollows,
  );
  // --------------------
  static Future<void> _goMySettings() => _goToAUserTab(
    bid: BldrsTabber.bidMySettings,
    tab: BldrsTab.mySettings,
  );
  // --------------------
  static Future<void> _goToAUserTab({
    required String bid,
    required BldrsTab tab,
  }) async {

    if (UsersProvider.proCheckIsSignedUp() == true){

      const bool mounted = true;

      final List<MirageModel> allMirages = HomeProvider.proGetMirages(
        context: getMainContext(),
        listen: false,
      );

      final List<MirageModel> _miragesAbove = MirageModel.getMiragesAbove(
        allMirages: allMirages,
        aboveIndex: 0,
      );

      /// CLOSE ALL MIRAGES ABOVE 0
      MirageModel.hideMirages(
        models: _miragesAbove,
        mounted: mounted,
      );

      /// SELECT THE BUTTON IN MIRAGE 0
      HomeProvider.proSelectMirageButton(
        mirageIndex: 0,
        mounted: mounted,
        button: BldrsTabber.bidMyProfile,
      );

      /// SELECT THE BUTTON IN MIRAGE 1
      HomeProvider.proSelectMirageButton(
        mirageIndex: 1,
        mounted: mounted,
        button: bid,
      );

      /// GO TO TAB
      await BldrsTabber.goToTab(tab: tab);

      /// SHOW MIRAGE 1
      // allMirages[1].show(mounted: mounted);
      await allMirages[1].reShow(mounted: mounted);

      /// SCROLL TO
      await Future.wait([
        allMirages[0].scrollTo(
            buttonIndex: BldrsTabber.getButtonIndexInMainMirage(bid: BldrsTabber.bidMyProfile,),
            listLength: BldrsTabber.mainButtonsLength,
        ),
        allMirages[1].scrollTo(
          buttonIndex: BldrsTabber.getButtonIndexInProfileMirage(bid: bid),
          listLength: BldrsTabber.profileButtonsLength,
        ),
      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// BZ

  // --------------------
  static Future<void> _goMyBzInfo({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: BldrsTabber.bidMyBzInfo,
    tab: BldrsTab.myBzInfo,
  );
  // --------------------
  static Future<void> _goMyBzFlyers({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: BldrsTabber.bidMyBzFlyers,
    tab: BldrsTab.myBzFlyers,
  );
  // --------------------
  static Future<void> _goMyBzTeam({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: BldrsTabber.bidMyBzTeam,
    tab: BldrsTab.myBzTeam,
  );
  // --------------------
  static Future<void> _goMyBzNotes({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: BldrsTabber.bidMyBzNotes,
    tab: BldrsTab.myBzNotes,
  );
  // --------------------
  static Future<void> _goMyBzSettings({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: BldrsTabber.bidMyBzSettings,
    tab: BldrsTab.myBzSettings,
  );
  // --------------------
  static Future<void> _goToABzTab({
    required String? bzID,
    required String bid,
    required BldrsTab tab,
  }) async {

    if (bzID != null){

      final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(
        context: getMainContext(),
        listen: false,
      );

      final bool _isMyBz = Stringer.checkStringsContainString(
        strings: _myBzzIDs,
        string: bzID,
      );

      if (_isMyBz == true){

        final bool _isSingleBz = _myBzzIDs.length == 1;

        await HomeProvider.proSetActiveBzByID(
          bzID: bzID,
          context: getMainContext(),
          notify: true,
        );

        final int tabsMirageIndex = _isSingleBz ? 1 : 2;

        const bool mounted = true;

        final List<MirageModel> allMirages = HomeProvider.proGetMirages(
          context: getMainContext(),
          listen: false,
        );

        final List<MirageModel> _miragesAbove = MirageModel.getMiragesAbove(
          allMirages: allMirages,
          aboveIndex: tabsMirageIndex,
        );

        /// CLOSE ALL MIRAGES ABOVE THE TABS MIRAGE
        MirageModel.hideMirages(
          models: _miragesAbove,
          mounted: mounted,
        );

        final String _bidBz = BldrsTabber.generateBzBid(
            bzID: bzID,
            bid: bid
        );

        /// SELECT THE BUTTON IN MIRAGE 0
        HomeProvider.proSelectMirageButton(
          mirageIndex: 0,
          mounted: mounted,
          button: _isSingleBz == true ? _bidBz : BldrsTabber.bidMyBzz,
        );

        /// SELECT THE BUTTON IN MIRAGE 1
        HomeProvider.proSelectMirageButton(
          mirageIndex: 1,
          mounted: mounted,
          button: _bidBz,
        );

        /// SELECT THE BUTTON IN MIRAGE 2
        if (_isSingleBz == false){
          HomeProvider.proSelectMirageButton(
            mirageIndex: 2,
            mounted: mounted,
            button: _bidBz,
          );
        }

        /// GO TO TAB
        await BldrsTabber.goToTab(tab: tab);

        /// SHOW MIRAGE 1
        allMirages[1].show(mounted: mounted);

        /// SHOW MIRAGE 2
        if (_isSingleBz == false){
          allMirages[2].show(mounted: mounted);
        }

        await Future.delayed(const Duration(milliseconds: 300));

        /// SCROLL TO
        await Future.wait([

          /// MIRAGE 0
          allMirages[0].scrollTo(
            buttonIndex: BldrsTabber.getButtonIndexInMainMirage(bid: BldrsTabber.bidMyBzz),
            listLength: BldrsTabber.mainButtonsLength,
          ),

          /// MIRAGE 1 [ WHEN HAS 1 BZ => BZ TABS ]
          if (_isSingleBz == true)
          allMirages[1].scrollTo(
            buttonIndex: BldrsTabber.getButtonIndexInBzProfileMirage(bid: bid),
            listLength: BldrsTabber.bzButtonsLength,
          ),

          /// MIRAGE 1 [ WHEN HAS MANY BZZ => BZ BUTTON ]
          if (_isSingleBz == false)
          allMirages[1].scrollTo(
            buttonIndex: BldrsTabber.getButtonIndexInMyBzzMirage(bzID: bzID),
            listLength: _myBzzIDs.length,
          ),

          /// MIRAGE 2 [ WHEN HAS MANY BZZ => BZ TABS ]
          if (_isSingleBz == false)
          allMirages[2].scrollTo(
            buttonIndex: BldrsTabber.getButtonIndexInBzProfileMirage(bid: bid),
            listLength: BldrsTabber.bzButtonsLength,
          ),

        ]);

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SWITCHER

  // --------------------
  static Future<void> goTo({
    required BldrsTab tab,
    String? bzID,
  }) async {

    switch (tab){

      /// MAIN
      case BldrsTab.home:           await _goHome();
      case BldrsTab.zone:           await _goZone();
      case BldrsTab.auth:           await _goAuth();
      case BldrsTab.appSettings:    await _goAppSettings();


      /// USER
      case BldrsTab.myInfo:         await _goMyInfo();
      case BldrsTab.mySaves:        await _goMySaves();
      case BldrsTab.myNotes:        await _goMyNotes();
      case BldrsTab.myFollows:      await _goMyFollows();
      case BldrsTab.mySettings:     await _goMySettings();

      /// BZ
      case BldrsTab.myBzInfo:       await _goMyBzInfo(bzID: bzID);
      case BldrsTab.myBzFlyers:     await _goMyBzFlyers(bzID: bzID);
      case BldrsTab.myBzTeam:       await _goMyBzTeam(bzID: bzID);
      case BldrsTab.myBzNotes:      await _goMyBzNotes(bzID: bzID);
      case BldrsTab.myBzSettings:   await _goMyBzSettings(bzID: bzID);

      default: await _goHome();

    }

  }
  // -----------------------------------------------------------------------------
}
