import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/a_chains_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/specs/pickers_group.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainsScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreenBrowseView({
    @required this.specsPickers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecPicker> specsPickers;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<String> _theGroupsIDs = SpecPicker.getGroupsFromSpecsPickers(
      specsPickers: specsPickers,
    );

    return ListView.builder(
        itemCount: _theGroupsIDs.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: Stratosphere.bigAppBarStratosphere,
          bottom: Ratioz.horizon,
        ),
        itemBuilder: (BuildContext ctx, int index) {

          final String _groupID = _theGroupsIDs[index];

          final List<SpecPicker> _pickersOfThisGroup = SpecPicker.getSpecsPickersByGroupID(
            specsPickers: specsPickers,
            groupID: _groupID,
          );

          return SpecsPickersGroup(
            title: _groupID.toUpperCase(),
            allSelectedSpecs: ValueNotifier(null),
            groupPickers: _pickersOfThisGroup,
            onPickerTap: (SpecPicker picker) => goToKeywordsScreen(
              context: context,
              specPicker: picker,
            ),
            onDeleteSpec: (List<SpecModel> specs){
              SpecModel.blogSpecs(specs);
            },
          );

        }
    );
  }
}
