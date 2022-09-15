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
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/d_pickers_editors/x_pickers_editor_controller.dart';
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
          firstHeadline: Verse.trans(picker.chainID),
          secondHeadline: Verse.plain('i : ${picker.index} : ID : ${picker.chainID}'),
          width: BldrsAppBar.width(context),
          child: Column(
            children: <Widget>[

              // /// GROUP ID
              // LineBubble(
              //   width: _clearWidth,
              //   child: BubbleHeader(
              //     viewModel: BubbleHeaderVM(
              //       headerWidth: _clearWidth,
              //       headlineVerse: Verse(
              //         text: 'GroupID: ${picker.groupID}',
              //         translate: false
              //       ),
              //     ),
              //   ),
              //   onTap: () => onChangeGroupIDForAllItsPickers(
              //       context: context,
              //       oldGroupID: picker.groupID,
              //       tempPickers: tempPickers
              //   ),
              // ),

              /// CHAIN ID
              LineBubble(
                width: _clearWidth,
                child: BubbleHeader(
                  viewModel: BubbleHeaderVM(
                    headerWidth: _clearWidth,
                    headlineVerse: Verse(
                      text: 'ChainID: ${picker.chainID}',
                      translate: false,
                    ),
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
                      headlineVerse: Verse(
                        text: 'unitChainID: ${picker.unitChainID}',
                        translate: false,
                      ),
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
                    headlineVerse: const Verse(
                      text: 'Is Required',
                      translate: false,
                    ),
                    switchValue: picker.isRequired,
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
                width: _clearWidth,
                child: BubbleHeader(
                  viewModel: BubbleHeaderVM(
                    headerWidth: _clearWidth,
                    hasSwitch: true,
                    headlineVerse: const Verse(
                      text: 'Can pick many',
                      translate: false,
                    ),
                    switchValue: picker.canPickMany,
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
                  width: _clearWidth,
                  child: Column(
                    children: <Widget>[

                      /// HEADLINE
                      BubbleHeader(
                        viewModel: BubbleHeaderVM(
                          headlineVerse: const Verse(
                            text: 'Visible Range',
                            translate: false,
                          ),
                          headerWidth: _clearWidth,
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
                                  verse: Verse.trans(item),
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
                          headlineVerse: const Verse(
                            text: 'Deactivators',
                            translate: false,
                          ),
                          headerWidth: _clearWidth,
                        ),
                      ),

                      /// NOTICE
                      SizedBox(
                        width: _clearWidth,
                        child: const SuperVerse(
                          verse:  Verse(
                            text: 'Values that deactivate specific specPickers',
                            translate: false,
                          ),
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
                                      headlineVerse: Verse(
                                        text: _blocker.value.toString(),
                                        translate: false,
                                      ),
                                      headerWidth: _clearWidth,
                                      // translateHeadline: true,
                                    ),
                                  ),

                                ),

                                /// DEACT PICKERS IDS
                                BulletPoints(
                                  bubbleWidth: _clearWidth,
                                  bulletPoints: Verse.createVerses(
                                      strings: _blocker.pickersIDsToBlock,
                                      translate: false,
                                  ),
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
                      verse: const Verse(
                        text: 'Switch\nHeadline',
                        translate: false,
                        casing: Casing.upperCase,
                      ),
                      verseMaxLines: 2,
                      verseScaleFactor: 0.5,
                      verseItalic: true,
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
                      verse: const Verse(
                        text: 'Delete',
                        translate: false,
                        casing: Casing.upperCase,
                      ),
                      verseScaleFactor: 0.5,
                      verseItalic: true,
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
  /// --------------------------------------------------------------------------
}
