import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzPowersPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPowersPage({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        const Bubble(
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: Verse(
              text: 'phid_get_more_slides',
              translate: true,
            ),
          ),
          columnChildren: <Widget>[

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

        const Bubble(
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: Verse(
              text: 'phid_get_more_ankhs',
              translate: true,
            ),
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: Verse(
              text: 'phid_get_pro_account',
              translate: true,
            ),
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: Verse(
              text: 'phid_get_master_account',
              translate: true,
            ),
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: Verse(
              text: 'phid_boost_flyer',
              translate: true,
            ),
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: Verse(
              text: 'phid_create_ad',
              translate: true,
            ),
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: Verse(
              text: 'phid_sponsor_bldrs_in_ur_city',
              translate: true,
            ),
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        Bubble(
          bubbleHeaderVM: const BubbleHeaderVM(
            headlineVerse: Verse(
              text: 'phid_get_marketing_material',
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
              width: Bubble.clearWidth(context),
              height: 100,
              margin:
              const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
              decoration: BoxDecoration(
                color: Colorz.bloodTest,
                borderRadius: Bubble.clearBorders(context),
              ),
            ),

            SuperVerse.verseDot(
              verse: const Verse(
                text: '#!# Download "Find us on Bldrs.net" printable banner',
                translate: true,
              ),
            ),

            Container(
              width: Bubble.clearWidth(context),
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
              alignment: Alignment.center,
              child: Container(
                width: Bubble.clearWidth(context) - 150,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colorz.bloodTest,
                  // borderRadius: Bubble.clearBorders(context),
                ),
              ),
            ),

            SuperVerse.verseDot(
              verse: const Verse(
                text: '#!# Use Bldrs.net graphics to customize your own materials',
                translate: true,
              ),
            ),

            Container(
              width: Bubble.clearWidth(context),
              height: 100,
              margin:
              const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
              decoration: BoxDecoration(
                color: Colorz.bloodTest,
                borderRadius: Bubble.clearBorders(context),
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
