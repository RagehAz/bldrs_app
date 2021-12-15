import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/components/horizon.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/tab_layout.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzPowersTab extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPowersTab({
    @required this.bzModel,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final BzModel bzModel;

  /// --------------------------------------------------------------------------
  static TabModel powersTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required bool isSelected,
    @required int tabIndex,
  }) {
    return TabModel(
      tabButton: TabButton(
        verse: BzModel.bzPagesTabsTitles[tabIndex],
        icon: Iconz.power,
        isSelected: isSelected,
        onTap: () => onChangeTab(tabIndex),
        iconSizeFactor: 0.7,
      ),
      page: BzPowersTab(
        bzModel: bzModel,
      ),
    );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        const Bubble(
          title: 'Get More Slides',
          columnChildren: <Widget>[

            SuperVerse(
              verse: 'You have got 500 slides left',
            ),
          ],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Get More Ankhs',
          columnChildren: <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Get Premium Account',
          columnChildren: <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Get Super Account',
          columnChildren: <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Boost a flyer',
          columnChildren: <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Create an Advertisement',
          columnChildren: <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Sponsor Bldrs.net in your city',
          columnChildren: <Widget>[],
        ),

        const BubblesSeparator(),

        Bubble(
          title: 'Get Bldrs.net marketing materials',
          columnChildren: <Widget>[

            SuperVerse.dotVerse(
              verse: 'Download Your custom Bldr online banner',
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
              verse: 'Download "Find us on Bldrs.net" printable banner',
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
              verse: 'Use Bldrs.net graphics to customize your own materials',
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
