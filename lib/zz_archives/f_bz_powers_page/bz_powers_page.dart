import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/sizing/horizon.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BzPowersPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPowersPage({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    final double _clearWidth = Bubble.clearWidth(context: context);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_get_more_slides',
              translate: true,
            ),
          ),
          columnChildren: const <Widget>[

            // SuperVerse(
            //   verse: Verse(
            /// PLAN : TRANSLATE THIS LINE
            //     text: '${_bzModel.name} has got 500 slides left',
            //     translate: true,
            //     variables: [_bzModel.name, 500],
            //   )
            // ),

          ],
        ),

        const DotSeparator(),

        Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_get_more_ankhs',
              translate: true,
            ),
          ),
          columnChildren: const <Widget>[],
        ),

        const DotSeparator(),

        Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_get_pro_account',
              translate: true,
            ),
          ),
          columnChildren: const <Widget>[],
        ),

        const DotSeparator(),

        Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_get_master_account',
              translate: true,
            ),
          ),
          columnChildren: const <Widget>[],
        ),

        const DotSeparator(),

        Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_boost_flyer',
              translate: true,
            ),
          ),
          columnChildren: const <Widget>[],
        ),

        const DotSeparator(),

        Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_create_ad',
              translate: true,
            ),
          ),
          columnChildren: const <Widget>[],
        ),

        const DotSeparator(),

        Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_sponsor_bldrs_in_ur_city',
              translate: true,
            ),
          ),
          columnChildren: const <Widget>[],
        ),

        const DotSeparator(),

        Bubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_get_marketing_material',
              translate: true,
            ),
          ),
          columnChildren: <Widget>[

            // SuperVerse.dotVerse(
            //   verse: const Verse(
            //     text: '#!# Download Your custom Bldr online banner',
            //     translate: true,
            //   )
            // ),

            Container(
              width: Bubble.clearWidth(context: context),
              height: 100,
              margin:
              const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
              decoration: BoxDecoration(
                color: Colorz.bloodTest,
                borderRadius: Bubble.clearBorders(),
              ),
            ),

            BldrsText.verseDot(
              verse: const Verse(
                id: '#!# Download "Find us on Bldrs.net" printable banner',
                translate: true,
              ),
            ),

            Container(
              width: _clearWidth,
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
              alignment: Alignment.center,
              child: Container(
                width: _clearWidth - 150,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colorz.bloodTest,
                  // borderRadius: Bubble.clearBorders(context),
                ),
              ),
            ),

            BldrsText.verseDot(
              verse: const Verse(
                id: '#!# Use Bldrs.net graphics to customize your own materials',
                translate: true,
              ),
            ),

            Container(
              width: _clearWidth,
              height: 100,
              margin:
              const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
              decoration: BoxDecoration(
                color: Colorz.bloodTest,
                borderRadius: Bubble.clearBorders(),
              ),
            ),
          ],
        ),

        const Horizon(),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
