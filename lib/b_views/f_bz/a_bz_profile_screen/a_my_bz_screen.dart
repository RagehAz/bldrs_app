import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/aa_my_bz_screen_pages.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x0_my_bz_screen_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/zoomable_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/router/x_go_back_widget.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBzScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreen({
    this.initialTab = BzTab.flyers,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzTab initialTab;

  @override
  State<MyBzScreen> createState() => _MyBzScreenState();
}

class _MyBzScreenState extends State<MyBzScreen> with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  late ZGridController _zGridController;
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _zGridController = ZGridController.initialize(
      vsync: this,
      scrollController: _scrollController,
    );

  }
  // --------------------
  @override
  void dispose() {
    /// SCROLL_CONTROLLER_IS_DISPOSED_IN_ZOOMABLE_GRID_CONTROLLER
    // _scrollController.dispose(); // so do not dispose here, kept for reference
    _zGridController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// NO NEED TO REBUILD WHEN BZ MODEL CHANGES
    final BzzProvider _bzzPro = Provider.of<BzzProvider>(context);
    final String? bzID = _bzzPro.myActiveBz?.id;
    blog('MyBzScreen : bzID : $bzID : initialTab : ${widget.initialTab}');
    // --------------------
    return FireDocStreamer(
      collName: FireColl.bzz,
      docName: bzID ?? '',
      onDataChanged: (BuildContext ctx,
          Map<String, dynamic>? oldMap,
          Map<String, dynamic>? newMap) async {

        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(ctx, listen: false);

        await onMyActiveBzStreamChanged(
          oldMap: oldMap,
          newMap: newMap,
          bzzProvider: _bzzProvider,
        );

      },
      builder: (_, Map<String, dynamic>? map){

        final BzModel? _bzModel = BzModel.decipherBz(
          map: map,
          fromJSON: false,
        );

        final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
          authors: _bzModel?.authors,
          userID: Authing.getUserID(),
        );

        if (_bzModel != null && _authorsContainMyUserID == false){

          blog('my bz screen should go back now yabn el a7ba : $_bzModel : $_authorsContainMyUserID');

          return GoBackWidget(
            onGoBack: () async {
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
            },
          );

        }

        // else if (_bzModel == null){
        //   return const SizedBox();
        // }

        else {

          final List<Widget> _pages = MyBzScreenPages.pages(
            scrollController: _scrollController,
            zGridController: _zGridController,
          );

          return ObeliskLayout(
            zGridController: _zGridController,
            canGoBack: true,
            appBarIcon: _bzModel?.logoPath,
            onBack: () async {

              final bool _flyerIsOpen = ! UiProvider.proGetLayoutIsVisible(
                context: context,
                listen: false,
              );

              final bool _pyramidsExpanded = UiProvider.proGetPyramidsAreExpanded(
                context: context,
                listen: false,
              );

              /// CLOSE FLYER
              if (_flyerIsOpen == true || _pyramidsExpanded == true) {

                  UiProvider.proSetPyramidsAreExpanded(
                    notify: true,
                    setTo: false,
                  );

                  await zoomOutFlyer(
                    context: context,
                    mounted: true,
                    controller: _zGridController,
                  );

              }

              else {
                _bzzPro.clearMyActiveBz(notify: false);

                await Nav.goBack(
                  context: context,
                  invoker: 'ObeliskLayout.onBack',
                );
              }

            },
            initialIndex: BzTabber.getBzTabIndex(widget.initialTab),
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
              ...List.generate(BzTabber.bzTabsList.length, (index) {
                final BzTab _bzTab = BzTabber.bzTabsList[index];

                return NavModel(
                  id: NavModel.getBzTabNavID(bzTab: _bzTab, bzID: _bzModel?.id),
                  titleVerse: Verse(
                    id: BzTabber.getBzTabPhid(bzTab: _bzTab),
                    translate: true,
                  ),
                  icon: _bzTab == BzTab.about ? _bzModel?.logoPath : BzTabber.getBzTabIcon(_bzTab),
                  iconSizeFactor: _bzTab == BzTab.about ? 1 : null,
                  screen: _pages[index],
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
