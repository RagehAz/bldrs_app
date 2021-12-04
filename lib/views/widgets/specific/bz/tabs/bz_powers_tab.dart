import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPowersTab extends StatelessWidget {
  final BzModel bzModel;

  const BzPowersTab({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  static TabModel powersTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required bool isSelected,
    @required int tabIndex,
  }) {
    return
      TabModel(
        tabButton: TabButton(
          verse: BzModel.bzPagesTabsTitles[tabIndex],
          icon: Iconz.Power,
          isSelected: isSelected,
          onTap: () => onChangeTab(tabIndex),
          iconSizeFactor: 0.7,
        ),
        page: BzPowersTab(bzModel: bzModel,),

      );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        Bubble(
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
          columnChildren: const <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Get Premium Account',
          columnChildren: const <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Get Super Account',
          columnChildren: const <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Boost a flyer',
          columnChildren: const <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Create an Advertisement',
          columnChildren: const <Widget>[],
        ),

        const BubblesSeparator(),

        const Bubble(
          title: 'Sponsor Bldrs.net in your city',
          columnChildren: const <Widget>[],
        ),

        const BubblesSeparator(),

        Bubble(
          title: 'Get Bldrs.net marketing materials',
          columnChildren: <Widget>[

            SuperVerse.dotVerse(
                verse : 'Download Your custom Bldr online banner',
            ),

            Container(
              width: Bubble.clearWidth(context),
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
              decoration: BoxDecoration(
                color: Colorz.bloodTest,
                borderRadius: Bubble.clearBorders(context),
              ),
            ),

            SuperVerse.dotVerse(
              verse : 'Download "Find us on Bldrs.net" printable banner',
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

            SuperVerse.dotVerse(
              verse : 'Use Bldrs.net graphics to customize your own materials',
            ),

            Container(
              width: Bubble.clearWidth(context),
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
              decoration: BoxDecoration(
                color: Colorz.bloodTest,
                borderRadius: Bubble.clearBorders(context),
              ),
            ),

          ],
        ),


        const PyramidsHorizon(),

      ],
    );
  }
}
