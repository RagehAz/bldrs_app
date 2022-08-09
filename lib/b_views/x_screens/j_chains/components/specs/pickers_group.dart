import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/spec_picker_tile.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecsPickersGroup extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsPickersGroup({
    @required this.title,
    @required this.selectedSpecs,
    @required this.groupPickers,
    @required this.onPickerTap,
    @required this.onDeleteSpec,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final List<SpecPicker> groupPickers;
  final ValueChanged<SpecPicker> onPickerTap;
  final ValueChanged<List<SpecModel>> onDeleteSpec;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    return Padding(
      key: const ValueKey<String>('SpecsPickersGroup'),
      padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
      child: Column(
        children: <Widget>[

          /// GROUP TITLE
          Container(
            key: const ValueKey<String>('SpecsPickersGroup_groupTitle'),
            width: _screenHeight,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // color: Colorz.bloodTest,
            child: SuperVerse(
              verse: title,
              weight: VerseWeight.black,
              centered: false,
              margin: 10,
              size: 3,
              scaleFactor: 0.85,
              italic: true,
              color: Colorz.yellow125,
            ),
          ),

          /// GROUP SPECS PICKERS
          SizedBox(
            key: const ValueKey<String>('SpecsPickersGroup_groupSpecsPickers'),
            width: _screenHeight,
            child: ValueListenableBuilder(
              valueListenable: selectedSpecs,
              builder: (_, List<SpecModel> _allSelectedSpecs, Widget childC){

                return Column(
                  children: <Widget>[

                    ...List<Widget>.generate(groupPickers.length,
                            (int index) {

                          final SpecPicker _picker = groupPickers[index];

                          final List<SpecModel> _pickerSelectedSpecs = SpecModel.getSpecsRelatedToPicker(
                            specs: _allSelectedSpecs,
                            picker: _picker,
                          );

                          return SpecPickerTile(
                            onTap: () => onPickerTap(_picker),
                            specPicker: _picker,
                            selectedSpecs: _pickerSelectedSpecs,
                            onDeleteSpec: onDeleteSpec,
                          );

                        }

                    ),

                  ],
                );

              },
            ),
          ),

        ],
      ),
    );
  }
}
