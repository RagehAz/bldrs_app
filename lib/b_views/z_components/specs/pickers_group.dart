import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/z_components/specs/spec_picker_tile.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecsPickersGroup extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsPickersGroup({
    @required this.title,
    @required this.allSelectedSpecs,
    @required this.groupPickers,
    @required this.onPickerTap,
    @required this.onDeleteSpec,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final ValueNotifier<List<SpecModel>> allSelectedSpecs;
  final List<SpecPicker> groupPickers;
  final ValueChanged<SpecPicker> onPickerTap;
  final ValueChanged<SpecModel> onDeleteSpec;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    return SizedBox(
      key: const ValueKey<String>('SpecsPickersGroup'),
      width: _screenHeight,
      child: Column(
        children: <Widget>[

          /// GROUP TITLE
          Container(
            width: _screenHeight,
            height: 50,
            margin: const EdgeInsets.only(top: Ratioz.appBarMargin),
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
            width: _screenHeight,
            // height: (_listsOfThisGroup.length * (SpecListTile.height() + 5)),

            child: ValueListenableBuilder(
              valueListenable: allSelectedSpecs,
              builder: (_, List<SpecModel> _allSelectedSpecs, Widget childC){

                return Column(
                  children: <Widget>[

                    ...List<Widget>.generate(groupPickers.length,
                            (int index) {

                          final SpecPicker _picker = groupPickers[index];

                          final List<SpecModel> _pickerSelectedSpecs = SpecModel.getSpecsByPickerChainID(
                            specs: _allSelectedSpecs,
                            pickerChainID: _picker.chainID,
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
