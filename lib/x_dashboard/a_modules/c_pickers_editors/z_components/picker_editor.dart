import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/cc_pickers_blocker.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/spec_label.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/line_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_pickers_editors/x_pickers_editor_controller.dart';
import 'package:flutter/material.dart';

class PickerEditingTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerEditingTile({
    @required this.picker,
    @required this.tempPickers,
    @required this.flyerZone,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel picker;
  final ValueNotifier<List<PickerModel>> tempPickers;
  final ZoneModel flyerZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = BldrsAppBar.width(context);
    final double _clearWidth = _bubbleWidth - 20;

    return Column(
      children: <Widget>[

        ExpandingTile(
            firstHeadline: picker.chainID,
            secondHeadline: 'i : ${picker.index} : ID : ${picker.chainID}',
            width: BldrsAppBar.width(context),
            child: Column(
              children: <Widget>[

                /// GROUP ID
                LineBubble(
                  width: _clearWidth,
                  child: BubbleHeader(
                    viewModel: BubbleHeaderVM(
                      headerWidth: _clearWidth,
                      headlineVerse:  'GroupID: ${picker.groupID}',
                      translateHeadline: false,
                    ),
                  ),
                  onTap: () => onChangeGroupIDForAllItsPickers(
                      context: context,
                      oldGroupID: picker.groupID,
                      tempPickers: tempPickers
                  ),
                ),

                /// CHAIN ID
                LineBubble(
                  width: _clearWidth,
                  child: BubbleHeader(
                    viewModel: BubbleHeaderVM(
                      headerWidth: _clearWidth,
                      headlineVerse:  'ChainID: ${picker.chainID}',
                      translateHeadline: false,
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
                    width: _clearWidth,
                    child: BubbleHeader(
                      viewModel: BubbleHeaderVM(
                        headerWidth: _clearWidth,
                        headlineVerse:  'unitChainID: ${picker.unitChainID}',
                        translateHeadline: false,
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
                  width: _clearWidth,
                  child: BubbleHeader(
                    viewModel: BubbleHeaderVM(
                      headerWidth: _clearWidth,
                      hasSwitch: true,
                      headlineVerse:  'Is Required',
                      switchIsOn: picker.isRequired,
                      onSwitchTap: (bool value) => onSwitchIsRequired(
                          newValue: value,
                          context: context,
                          picker: picker,
                          tempPickers: tempPickers
                      ),
                      translateHeadline: false,
                    ),
                  ),
                ),

                /// CAN PICK MANY
                LineBubble(
                  width: _clearWidth,
                  child: BubbleHeader(
                    viewModel: BubbleHeaderVM(
                      headerWidth: _clearWidth,
                      hasSwitch: true,
                      headlineVerse:  'Can pick many',
                      switchIsOn: picker.canPickMany,
                      onSwitchTap: (bool value) => onSwitchCanPickMany(
                          newValue: value,
                          context: context,
                          picker: picker,
                          tempPickers: tempPickers
                      ),
                      translateHeadline: false,
                    ),
                  ),
                ),

                /// RANGE
                if (Mapper.checkCanLoopList(picker.range) == true)
                  LineBubble(
                    width: _clearWidth,
                    child: Column(
                      children: <Widget>[

                        /// HEADLINE
                        BubbleHeader(
                          viewModel: BubbleHeaderVM(
                            headlineVerse:  'Visible Range',
                            headerWidth: _clearWidth,
                            translateHeadline: false,
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
                                    translate: true,
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
                    width: _clearWidth,
                    child: Column(
                      children: <Widget>[

                        /// HEADLINE
                        BubbleHeader(
                          viewModel: BubbleHeaderVM(
                            headlineVerse:  'Deactivators',
                            headerWidth: _clearWidth,
                            translateHeadline: false,
                          ),
                        ),

                        /// NOTICE
                        SizedBox(
                          width: _clearWidth,
                          child: const SuperVerse(
                            verse:  'Values that deactivate specific specPickers',
                            translate: false,
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
                                    width: _clearWidth,
                                    alignment: Alignment.centerLeft,
                                    child: BubbleHeader(
                                      viewModel: BubbleHeaderVM(
                                        headlineVerse: _blocker.value.toString(),
                                        headerWidth: _clearWidth,
                                        // translateHeadline: true,
                                      ),
                                    ),

                                  ),

                                  /// DEACT PICKERS IDS
                                  BubbleBulletPoints(
                                    bubbleWidth: _clearWidth,
                                    bulletPoints: _blocker.pickersIDsToBlock,
                                    translateBullets: false,
                                  ),

                                ],
                              );


                            }),

                      ],
                    ),
                  ),

                /// DELETE - SWITCH HEADLINE
                SizedBox(
                  width: _clearWidth,
                  height: 50,
                  // color: Colorz.bloodTest,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      /// DELETE
                      DreamBox(
                        height: 40,
                        verse: '##switch\nHeadline',
                        verseMaxLines: 2,
                        verseScaleFactor: 0.5,
                        translateVerse: true,
                        verseItalic: true,
                        verseCasing: VerseCasing.upperCase,
                        onTap: () => switchHeadline(
                          context: context,
                          tempPickers: tempPickers,
                          picker: picker,
                        ),
                        margins: 5,
                      ),

                      /// DELETE
                      DreamBox(
                        height: 40,
                        verse: 'phid_delete',
                        verseScaleFactor: 0.5,
                        translateVerse: true,
                        verseItalic: true,
                        verseCasing: VerseCasing.upperCase,
                        onTap: () => onDeletePicker(
                          context: context,
                          tempPickers: tempPickers,
                          picker: picker,
                        ),
                        margins: 5,
                      ),

                    ],
                  ),
                ),

              ],
            ),
        ),

        SeparatorLine(width: Bubble.clearWidth(context) - 20),

      ],
    );
  }
}
