import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/specific/bz/targets_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
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
    @required int tabIndex,
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
      children: const <Widget>[

        const TargetsBubble(),

        const PyramidsHorizon(),

      ],
    );
  }
}
