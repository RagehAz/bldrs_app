import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/cc_pickers_blocker.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/picker_group/cc_spec_picker_tile.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/spec_label.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/line_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_spec_pickers_editor/spec_pickers_editor_controller.dart';
import 'package:flutter/material.dart';

class PickerEditor extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerEditor({
    @required this.picker,
    @required this.tempPickers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel picker;
  final ValueNotifier<List<PickerModel>> tempPickers;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        /// PICKER TILE
        SpecPickerTile(
          specPicker: picker,
          selectedSpecs: const [],
          onDeleteSpec: null,
          onTap: () => onPickerTileTap(
            context: context,
            picker: picker,
          ),
        ),

        /// CHAIN ID
        LineBubble(
          child: BubbleHeader(
            viewModel: BubbleHeaderVM(
              headline: 'ChainID: ${picker.chainID}',
              headerWidth: BldrsAppBar.width(context),
            ),
          ),
          onTap: () => onPickerChainIDTap(
            context: context,
            picker: picker,
            tempPickers: tempPickers
          ),
        ),

        /// UNIT CHAIN ID
        if (picker?.unitChainID != null)
          LineBubble(
            child: BubbleHeader(
              viewModel: BubbleHeaderVM(
                headline: 'unitChainID: ${picker.unitChainID}',
                headerWidth: BldrsAppBar.width(context),
              ),
            ),
            onTap: () => onPickerUnitChainIDTap(
                context: context,
                picker: picker,
                tempPickers: tempPickers
            ),
          ),

        /// IS REQUIRED
        LineBubble(
          child: BubbleHeader(
            viewModel: BubbleHeaderVM(
              hasSwitch: true,
              headline: 'Is Required',
              switchIsOn: picker.isRequired,
              headerWidth: BldrsAppBar.width(context),
              onSwitchTap: (bool value) => onSwitchIsRequired(
                  newValue: value,
                  context: context,
                  picker: picker,
                  tempPickers: tempPickers
              ),
            ),
          ),
        ),

        /// CAN PICK MANY
        LineBubble(
          child: BubbleHeader(
            viewModel: BubbleHeaderVM(
              hasSwitch: true,
              headline: 'Can pick many',
              switchIsOn: picker.canPickMany,
              headerWidth: BldrsAppBar.width(context),
              onSwitchTap: (bool value) => onSwitchCanPickMany(
                  newValue: value,
                  context: context,
                  picker: picker,
                  tempPickers: tempPickers
              ),
            ),
          ),
        ),

        /// RANGE
        if (Mapper.checkCanLoopList(picker.range) == true)
          LineBubble(
            child: Column(
              children: <Widget>[

                /// HEADLINE
                BubbleHeader(
                  viewModel: BubbleHeaderVM(
                    headline: 'Visible Range',
                    headerWidth: BldrsAppBar.width(context),
                  ),
                ),

                /// RANGE ITEMS
                Wrap(
                  spacing: Ratioz.appBarPadding,
                  children: <Widget>[

                    ...List<Widget>.generate(picker.range.length,
                            (int index) {

                          final String item = picker.range[index];

                          return SpecLabel(
                            xIsOn: true,
                            value: item,
                            onTap: (){
                              blog('range item : $item');
                            },
                          );

                        }),

                  ],
                ),

              ],
            ),
          ),

        /// DEACTIVATORS
        if (Mapper.checkCanLoopList(picker.blockers) == true)
          LineBubble(
            child: Column(
              children: <Widget>[

                /// HEADLINE
                BubbleHeader(
                  viewModel: BubbleHeaderVM(
                    headline: 'Deactivators',
                    headerWidth: BldrsAppBar.width(context),
                  ),
                ),

                /// NOTICE
                SizedBox(
                  width: BldrsAppBar.width(context),
                  child: const SuperVerse(
                    verse: 'Values that deactivate specific specPickers',
                    size: 1,
                    centered: false,
                    margin: 10,
                    weight: VerseWeight.thin,
                    italic: true,
                    color: Colorz.white200,
                  ),
                ),

                /// DEACTIVATORS
                ...List<Widget>.generate(picker.blockers.length,
                        (int index) {

                      final PickersBlocker _blocker = picker.blockers[index];

                      return Column(
                        children: <Widget>[

                          /// DEACT VALUE
                          LineBubble(
                            width: BldrsAppBar.width(context) - 20,
                            alignment: Alignment.centerLeft,
                            child: BubbleHeader(
                              viewModel: BubbleHeaderVM(
                                headline: _blocker.value.toString(),
                                headerWidth: BldrsAppBar.width(context)- 20,
                              ),
                            ),

                          ),

                          /// DEACT PICKERS IDS
                          BubbleBulletPoints(
                            bubbleWidth: BldrsAppBar.width(context) - 20,
                            bulletPoints: _blocker.pickersIDsToBlock,
                          ),

                        ],
                      );


                    }),

              ],
            ),
          ),

        const SeparatorLine(),

      ],
    );
  }
}
