import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/f_new_authorship_exit.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:fire/super_fire.dart';
// -----------------------------------------------------------------------------

/// MY BZ SCREEN INITIALIZERS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onMyActiveBzStreamChanged({
  required Map<String, dynamic>? newMap,
  required Map<String, dynamic>? oldMap,
}) async {

  /// REF : BZ_STREAM_OPENS_ON_ACTIVE_BZ_AND_UPDATES_LOCALLY

  final BzModel? _newBz = BzModel.decipherBz(
    map: newMap,
    fromJSON: false,
  );

  if (_newBz == null){

    blog('onMyActiveBzStreamChanged : THE NEW BITCH MAP IS NULL NOW AND WE CAN DO SOME STUFF HEREEEEEEEEEEEEEEEEEE');
    //  await NewAuthorshipExit.onIGotRemoved(
    //    context: context,
    //    bzID: _oldBz?.id,
    //    isBzDeleted: true,
    //  );


  }

  else {

    final BzModel? _activeBz = HomeProvider.proGetActiveBzModel(
        context: getMainContext(),
        listen: false,
    );

    final bool _areIdentical = BzModel.checkBzzAreIdentical(
      bz1: _activeBz,
      bz2: _newBz,
    );

    blog('onMyActiveBzStreamChanged : streamBz == proMyActiveBz ? : $_areIdentical');

    if (_areIdentical == false){

      final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
        authors: _newBz.authors,
        userID: Authing.getUserID(),
      );

      if (_authorsContainMyUserID == false){

        await NewAuthorshipExit.onIGotRemoved(
          bzID: _newBz.id,
          isBzDeleted: false, //map == null,
        );

      }

      else {

        final BzModel? _oldBz = BzModel.decipherBz(
          map: oldMap,
          fromJSON: false,
        );

        await BzProtocols.updateBzLocally(
          newBz: _newBz,
          oldBz: _oldBz,
        );

      }

    }

  }

}
// -----------------------------------------------------------------------------

/// MY BZ SCREEN CLOSING

// --------------------
Future<void> onCloseMyBzScreen() async {

  blog('onCloseMyBzScreen : CLOSING');

  HomeProvider.proClearActiveBz(notify: true);

  await Nav.goBack(
    context: getMainContext(),
    invoker: 'onCloseMyBzScreen',
  );

}
// -----------------------------------------------------------------------------

/// BZ TABS

// --------------------
/*
// int getInitialMyBzScreenTabIndex(BuildContext context){
//   final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//   final BzTab _currentTab = _uiProvider.currentBzTab;
//   final int _index = BzModel.getBzTabIndex(_currentTab);
//   return _index;
// }
 */
// --------------------
// void onChangeMyBzScreenTabIndexWhileAnimation({
//   required TabController tabController,
// }){
//
//   if (tabController.indexIsChanging == false) {
//
//     final int? _indexFromAnimation = tabController.animation?.value.round();
//     onChangeMyBzScreenTabIndex(
//       index: _indexFromAnimation ?? 0,
//       tabController: tabController,
//     );
//
//   }
//
// }
// --------------------
// void onChangeMyBzScreenTabIndex({
//   required int index,
//   required TabController tabController,
// }) {
//
//   final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
//
//   final BzTab _newBzTab = BzTabber.bzTabsList[index];
//   final BzTab _previousBzTab = _uiProvider.currentBzTab;
//
//   /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
//   if (_newBzTab != _previousBzTab){
//     // blog('index is $index');
//     // _uiProvider.setCurrentBzTab(_newBzTab);
//     tabController.animateTo(index,
//         curve: Curves.easeIn,
//         duration: Ratioz.duration150ms
//     );
//   }
//
// }
// -----------------------------------------------------------------------------