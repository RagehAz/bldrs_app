import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/widgets/specific/bz/targets_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/tab_layout_model.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
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
        key: ValueKey<String>('bz_targets_tab_${bzModel.id}'),
        verse: BzModel.bzPagesTabsTitles[tabIndex],
        icon: Iconz.target,
        isSelected: isSelected,
        onTap: () => onChangeTab(tabIndex),
        iconSizeFactor: 0.7,
      ),
      page: BzTargetsTab(
        key: ValueKey<String>('bz_targets_page_${bzModel.id}'),
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
