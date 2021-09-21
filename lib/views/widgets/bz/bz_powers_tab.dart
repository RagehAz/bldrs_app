import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/targets_bubble.dart';
import 'package:bldrs/views/widgets/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/tab_layout.dart';
import 'package:flutter/material.dart';

class BzPowersTab extends StatelessWidget {
  final BzModel bzModel;

  const BzPowersTab({
    @required this.bzModel,
  });
// -----------------------------------------------------------------------------
  static TabModel powersTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required bool isSelected,
    int tabIndex = 3,
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
          title: 'Get More Ankhs',
          columnChildren: <Widget>[],
        ),

        BubblesSeparator(),

        Bubble(
          title: 'Get More Slides',
          columnChildren: <Widget>[],
        ),

        BubblesSeparator(),

        Bubble(
          title: 'Get Premium Account',
          columnChildren: <Widget>[],
        ),

        BubblesSeparator(),

        Bubble(
          title: 'Get Super Account',
          columnChildren: <Widget>[],
        ),

        BubblesSeparator(),

        Bubble(
          title: 'Boost a flyer',
          columnChildren: <Widget>[],
        ),

        BubblesSeparator(),

        Bubble(
          title: 'Create an Advertisement',
          columnChildren: <Widget>[],
        ),

        BubblesSeparator(),

        Bubble(
          title: 'Sponsor Bldrs.net in your city',
          columnChildren: <Widget>[],
        ),

        BubblesSeparator(),

        Bubble(
          title: 'Get Bldrs.net marketing materials',
          columnChildren: <Widget>[],
        ),


        PyramidsHorizon(),

      ],
    );
  }
}
