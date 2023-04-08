import 'package:authing/authing.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/aa_my_bz_screen_pages.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x0_my_bz_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:filers/filers.dart';
import 'package:fire/fire.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:provider/provider.dart';

class MyBzScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreen({
    this.initialTab = BzTab.flyers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzTab initialTab;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// NO NEED TO REBUILD WHEN BZ MODEL CHANGES
    final BzzProvider _bzzPro = Provider.of<BzzProvider>(context, listen: true);
    final String bzID = _bzzPro.myActiveBz?.id;
    blog('MyBzScreen : bzID : $bzID : initialTab : $initialTab');
    // --------------------
    return FireDocStreamer(
      collName: FireColl.bzz,
      docName: bzID,
      onDataChanged: (BuildContext ctx, Map<String, dynamic> oldMap, Map<String, dynamic> newMap) async {

        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(ctx, listen: false);

        await onMyActiveBzStreamChanged(
          context: ctx,
          oldMap: oldMap,
          newMap: newMap,
          bzzProvider: _bzzProvider,
        );

      },
      builder: (_, Map<String, dynamic> map){

        final BzModel _bzModel = BzModel.decipherBz(
          map: map,
          fromJSON: false,
        );

        final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
          authors: _bzModel?.authors,
          userID: Authing.getUserID(),
        );

        if (_bzModel == null || _authorsContainMyUserID == false){

          blog('my bz screen should go back now yabn el a7ba : $_bzModel : $_authorsContainMyUserID');

          /// TASK : FIX ME
          return const SizedBox();
          // return GoBackWidget(
          //   onGoBack: () async {
          //
          //     // /// REF: fuck_this_shit_will_come_back_to_you
          //     // if (_authorsContainMyUserID == false){
          //     //   await NewAuthorshipExit.onIGotRemoved(
          //     //       context: context,
          //     //       bzID: bzID,
          //     //       isBzDeleted: false, //map == null,
          //     //   );
          //     // }
          //
          //   },
          // );

        }

        else {

              return ObeliskLayout(
                initiallyExpanded: true,
                canGoBack: true,
                onBack: () async {

                  _bzzPro.clearMyActiveBz(notify: false);

                  await Nav.goBack(
                    context: context,
                    invoker: 'ObeliskLayout.onBack',
                  );

                },
                initialIndex: BzTabber.getBzTabIndex(initialTab),
                // appBarRowWidgets: <Widget>[
                //
                //   const Expander(),
                //
                //   BzCreditsCounter(
                //     width: Ratioz.appBarButtonSize * 1.4,
                //     slidesCredit: counterCaliber(context, 1234),
                //     ankhsCredit: counterCaliber(context, 123),
                //
                //   ),
                //
                //   BzLogo(
                //     width: 40,
                //     image: _bzModel.logoPath,
                //     isVerified: _bzModel.isVerified,
                //     margins: const EdgeInsets.symmetric(horizontal: 5),
                //     corners: BldrsAppBar.clearCorners,
                //   ),
                //
                // ],
                navModels: <NavModel>[

                  ...List.generate(BzTabber.bzTabsList.length, (index){

                    final BzTab _bzTab = BzTabber.bzTabsList[index];

                    return NavModel(
                      id: NavModel.getBzTabNavID(bzTab: _bzTab, bzID: _bzModel.id),
                      titleVerse: Verse(
                        id: BzTabber.getBzTabPhid(bzTab: _bzTab),
                        translate: true,
                      ),
                      icon: _bzTab == BzTab.about ? _bzModel.logoPath : BzTabber.getBzTabIcon(_bzTab),
                      iconSizeFactor: _bzTab == BzTab.about ? 1 : null,
                      screen: MyBzScreenPages.pages[index],
                    );

                  }),

                ],

              );

            }

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
