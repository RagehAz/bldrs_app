import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:provider/provider.dart';

class AddFlyerButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddFlyerButton({
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  Future<void> _goToFlyerMaker({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    blog('going to create new flyer keda');

    await Future<void>.delayed(Ratioz.durationFading200, () async {

      final DraftFlyer _draft = await DraftFlyer.createDraft(
        context: context,
        oldFlyer: null,
      );

      final bool _result = await Nav.goToNewScreen(
        context: context,
        screen: NewFlyerEditorScreen(
          draftFlyer: _draft,
          onConfirm: (DraftFlyer draft) async {

            await onConfirmPublishFlyerButtonTap(
              context: context,
              oldFlyer: null,
              draft: draft,
            );

          },
        ),
      );

      if (_result == true) {
        await TopDialog.showTopDialog(
          context: context,
          firstVerse: const Verse(
            id: 'phid_flyer_has_been_published',
            translate: true,
          ),
          color: Colorz.green255,
          textColor: Colorz.white255,
        );
      }

    });
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _flyerSizeFactor = FlyerDim.flyerFactorByFlyerWidth(context, flyerBoxWidth);
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final BzModel _bzModel = _bzzProvider.myActiveBz;
    // --------------------
    return GestureDetector(
      key: const ValueKey<String>('AddFlyerButton'),
      onTap: () => _goToFlyerMaker(
        context: context,
        bzModel: _bzModel,
      ),
      child: FlyerBox(
        flyerBoxWidth: flyerBoxWidth,
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
                scaleFactor: _flyerSizeFactor * 4,
                color: Colorz.white200,
                italic: true,
                margin: _flyerSizeFactor * 40,
              ),
            ],
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
