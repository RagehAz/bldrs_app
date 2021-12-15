import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/components/horizon.dart';
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/tab_layout.dart';
import 'package:bldrs/b_views/widgets/specific/bz/targets_bubble.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class BzTargetsTab extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTargetsTab({
    @required this.bzModel,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final BzModel bzModel;

  /// --------------------------------------------------------------------------
  static TabModel targetsTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required bool isSelected,
    @required int tabIndex,
  }) {
    return TabModel(
      tabButton: TabButton(
        verse: BzModel.bzPagesTabsTitles[tabIndex],
        icon: Iconz.target,
        isSelected: isSelected,
        onTap: () => onChangeTab(tabIndex),
        iconSizeFactor: 0.7,
      ),
      page: BzTargetsTab(
        bzModel: bzModel,
      ),
    );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const <Widget>[

        TargetsBubble(),

        Horizon(),

      ],
    );
  }
}
