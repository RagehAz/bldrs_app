import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/bubbles/targets_bubble.dart';
import 'package:bldrs/views/widgets/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/tab_layout.dart';
import 'package:flutter/material.dart';

class BzTargetsTab extends StatelessWidget {
  final BzModel bzModel;

  const BzTargetsTab({
    @required this.bzModel,
  });
// -----------------------------------------------------------------------------
  static TabModel targetsTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required bool isSelected,
    int tabIndex = 2,
  }) {
    return
      TabModel(
        tabButton: TabButton(
          verse: BzModel.bzPagesTabsTitles[tabIndex],
          icon: Iconz.Target,
          isSelected: isSelected,
          onTap: () => onChangeTab(tabIndex),
          iconSizeFactor: 0.7,
        ),
        page: BzTargetsTab(bzModel: bzModel,),

      );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        TargetsBubble(),

        PyramidsHorizon(),

      ],
    );
  }
}
