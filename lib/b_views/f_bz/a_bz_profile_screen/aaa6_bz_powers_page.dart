import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: <Widget>[

        Bubble(
          headerViewModel: const BubbleHeaderVM(
            headlineVerse: 'phid_get_more_slides',
          ),
          columnChildren: <Widget>[

            SuperVerse(
              verse: '##${_bzModel.name} has got 500 slides left',
            ),
          ],
        ),

        const DotSeparator(),

        const Bubble(
          headerViewModel: BubbleHeaderVM(
            headlineVerse: 'phid_get_more_ankhs',
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          headerViewModel: BubbleHeaderVM(
            headlineVerse: 'phid_get_premium_account',
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          headerViewModel: BubbleHeaderVM(
            headlineVerse: 'phid_get_super_account',
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          headerViewModel: BubbleHeaderVM(
            headlineVerse: 'phid_boost_flyer',
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          headerViewModel: BubbleHeaderVM(
            headlineVerse: 'phid_create_ad',
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        const Bubble(
          headerViewModel: BubbleHeaderVM(
            headlineVerse: 'phid_sponsor_bldrs_in_ur_city',
          ),
          columnChildren: <Widget>[],
        ),

        const DotSeparator(),

        Bubble(
          headerViewModel: const BubbleHeaderVM(
            headlineVerse: 'phid_get_marketing_material',
          ),
          columnChildren: <Widget>[

            SuperVerse.dotVerse(
              verse: '##Download Your custom Bldr online banner',
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

            SuperVerse.dotVerse(
              verse: '##Download "Find us on Bldrs.net" printable banner',
            ),

            Container(
              width: Bubble.clearWidth(context),
              height: 100,
              margin:
                  const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
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

            SuperVerse.dotVerse(
              verse: '##Use Bldrs.net graphics to customize your own materials',
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
}
