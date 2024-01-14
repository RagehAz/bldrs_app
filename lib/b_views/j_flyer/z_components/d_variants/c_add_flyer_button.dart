import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFlyerButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AddFlyerButton({
    required this.flyerBoxWidth,
    this.onTap,
    super.key
  });
  // --------------------
  final double flyerBoxWidth;
  final Function? onTap;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onHomeWallAddFlyer() async {

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
    );

    WaitDialog.showUnawaitedWaitDialog();

    final List<BzModel> _bzz = await BzProtocols.fetchBzz(
      bzzIDs: _userModel?.myBzzIDs,
    );

    await WaitDialog.closeWaitDialog();

    if (Lister.checkCanLoop(_bzz) == true){
      BzModel? _bzModel;

      if (_bzz.length == 1){
        _bzModel = _bzz.first;
      }
      else {
        _bzModel = await Dialogs.selectBzBottomDialog(
          bzzModels: _bzz,
        );
      }

      if (_bzModel != null){
        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
        _bzzProvider.setActiveBz(bzModel: _bzModel, notify: true);
        await AddFlyerButton.goToFlyerMaker(
          bzModel: _bzModel,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToFlyerMaker({
    required BzModel? bzModel,
  }) async {

    if (kIsWeb == true){

      await Dialogs.centerNotice(
        verse: const Verse(
          id: 'phid_flyer_editor_not_available_on_web',
          translate: true,
        ),
        body: const Verse(
          id: 'phid_flyer_editor_on_ios_and_android_only',
          translate: true,
        ),
      );

    }

    else {

      await Future<void>.delayed(Ratioz.durationFading200, () async {

        final DraftFlyer? _draft = await DraftFlyer.createDraft(
          oldFlyer: null,
        );

        final bool? _result = await BldrsNav.goToNewScreen(
          screen: NewFlyerEditorScreen(
            draftFlyer: _draft,
            onConfirm: (DraftFlyer? draft) async {

              await onConfirmPublishFlyerButtonTap(
                oldFlyer: null,
                draft: draft,
              );

              },
          ),
        );

        if (Mapper.boolIsTrue(_result) == true) {
          await TopDialog.showTopDialog(
            firstVerse: const Verse(
              id: 'phid_flyer_has_been_published',
              translate: true,
            ),
            color: Colorz.green255,
            textColor: Colorz.white255,
          );
        }
      }

    );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BzModel? _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: false);
    // --------------------
    return FlyerBox(
      flyerBoxWidth: flyerBoxWidth,
      onTap: onTap == null ?  () => goToFlyerMaker(bzModel: _bzModel)
                              :
                              () => onTap!(),
      stackWidgets: <Widget>[

        StaticHeader(
          flyerBoxWidth: flyerBoxWidth,
          bzModel: _bzModel,
          authorID: null,
          flyerShowsAuthor: false,
        ),

        /// ADD FLYER BUTTON
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// --- FAKE HEADER FOOTPRINT
            SizedBox(
              height: FlyerDim.headerSlateHeight(flyerBoxWidth),
            ),

            /// PLUS ICON
            BldrsBox(
              height: flyerBoxWidth * 0.4,
              width: flyerBoxWidth * 0.4,
              icon: Iconz.plus,
              iconColor: Colorz.white200,
              iconSizeFactor: 0.6,
              bubble: false,
              // onTap: () async {
              //   await _goToFlyerEditor(context);
              // },
            ),

            /// ADD NEW FLYER TEXT
            BldrsText(
              verse: const Verse(
                id: 'phid_add_new_flyer',
                casing: Casing.upperCase,
                translate: true,
              ),
              maxLines: 5,
              scaleFactor: flyerBoxWidth * 0.008,
              color: Colorz.white200,
              italic: true,
              margin: flyerBoxWidth * 0.05,
            ),

          ],
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
