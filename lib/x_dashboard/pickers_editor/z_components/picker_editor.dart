import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/cc_pickers_blocker.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/spec_label.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/line_bubble/line_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/x_dashboard/pickers_editor/x_pickers_editor_controller.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:mapper/mapper.dart';

class PickerEditingTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerEditingTile({
    @required this.picker,
    @required this.tempPickers,
    @required this.flyerZone,
    @required this.mounted,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel picker;
  final ValueNotifier<List<PickerModel>> tempPickers;
  final ZoneModel flyerZone;
  final bool mounted;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = BldrsAppBar.width(context);
    final double _clearWidth = _bubbleWidth - 20;

    final bool _hasRange = Mapper.checkCanLoopList(picker.range) == true;
    final bool _hasBlockers = Mapper.checkCanLoopList(picker.blockers) == true;

    return Column(
      children: <Widget>[

        ExpandingTile(
          firstHeadline: Verse.trans(picker.chainID),
          secondHeadline: Verse.plain('i : ${picker.index} : ID : ${picker.chainID}'),
          width: BldrsAppBar.width(context),
          child: Column(
            children: <Widget>[

              /// CHAIN ID
              LineBubble(
                width: _clearWidth,
                child: BubbleHeader(
                  viewModel: BldrsBubbleHeaderVM(
                    hasMoreButton: true,
                    onMoreButtonTap: (){
                      blog('should open chain screen for this ChainID: ${picker.chainID}');
                    },
                    headerWidth: _clearWidth,
                    headlineVerse: Verse(
                      id: 'ChainID: ${picker.chainID}',
                      translate: false,
                    ),
                  ),
                ),
                onTap: () => onPickerChainIDTap(
                  context: context,
                  picker: picker,
                  tempPickers: tempPickers,
                  mounted: mounted,
                ),
              ),

              /// IS REQUIRED
              LineBubble(
                width: _clearWidth,
                child: BubbleHeader(
                  viewModel: BldrsBubbleHeaderVM(
                    headerWidth: _clearWidth,
                    hasSwitch: true,
                    headlineVerse: const Verse(
                      id: 'Is Required',
                      translate: false,
                    ),
                    switchValue: picker.isRequired,
                    onSwitchTap: (bool value) => onSwitchIsRequired(
                      newValue: value,
                      context: context,
                      picker: picker,
                      tempPickers: tempPickers,
                      mounted: mounted,
                    ),
                  ),
                ),
              ),

              /// CAN PICK MANY
              LineBubble(
                width: _clearWidth,
                child: BubbleHeader(
                  viewModel: BldrsBubbleHeaderVM(
                    headerWidth: _clearWidth,
                    hasSwitch: true,
                    headlineVerse: const Verse(
                      id: 'Can pick many',
                      translate: false,
                    ),
                    switchValue: picker.canPickMany,
                    onSwitchTap: (bool value) => onSwitchCanPickMany(
                      newValue: value,
                      context: context,
                      picker: picker,
                      tempPickers: tempPickers,
                      mounted: mounted,
                    ),
                  ),
                ),
              ),

              /// UNIT CHAIN ID
              LineBubble(
                width: _clearWidth,
                child: BubbleHeader(
                  viewModel: BldrsBubbleHeaderVM(
                    headlineColor: picker?.unitChainID == null ? Colorz.black200 : Colorz.white255,
                    headerWidth: _clearWidth,
                    headlineVerse: Verse(
                      id: picker?.unitChainID == null ? 'No Unit Chain' : 'unitChainID: ${picker.unitChainID}',
                      translate: false,
                    ),
                    hasMoreButton: true,
                    onMoreButtonTap: (){
                      blog('blha blhaaa hoho');
                    },
                  ),
                ),
                onTap: () => onPickerUnitChainIDTap(
                  context: context,
                  picker: picker,
                  tempPickers: tempPickers,
                  mounted: mounted,
                ),
              ),

              /// RANGE
              LineBubble(
                  width: _clearWidth,
                  child: Column(
                    children: <Widget>[

                      /// HEADLINE
                      BubbleHeader(
                        viewModel: BldrsBubbleHeaderVM(
                          headlineColor: _hasRange == false ? Colorz.black200 : Colorz.white255,
                          hasMoreButton: true,
                          onMoreButtonTap: (){
                            blog('bisho bisho biiiisho');
                          },
                          headlineVerse: Verse(
                            id: _hasRange == true ? 'Visible Range' : 'No range defined',
                            translate: false,
                          ),
                          headerWidth: _clearWidth,

                        ),
                      ),

                      /// RANGE ITEMS
                      if (_hasRange == true)
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
                                  onXTap: (){
                                    blog('should delete walla eh');
                                  },
                                );

                              }),

                        ],
                      ),

                    ],
                  ),
                ),

              /// DEACTIVATORS
              LineBubble(
                  width: _clearWidth,
                  child: Column(
                    children: <Widget>[

                      /// HEADLINE
                      BubbleHeader(
                        viewModel: BldrsBubbleHeaderVM(
                          headlineColor: _hasBlockers == false ? Colorz.black200 : Colorz.white255,
                          hasMoreButton: true,
                          onMoreButtonTap: (){
                            blog('bisho bisho biiiishodddddddddddd');
                          },
                          headlineVerse: Verse(
                            id: _hasBlockers == true ? 'Chain Blockers' : 'No Blockers defined',
                            translate: false,
                          ),
                          headerWidth: _clearWidth,
                        ),
                      ),

                      /// NOTICE
                      SizedBox(
                        width: _clearWidth,
                        child: const BldrsText(
                          verse:  Verse(
                            id: 'Values that deactivate specific pickers',
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
                      if (_hasBlockers == true)
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
                                    viewModel: BldrsBubbleHeaderVM(
                                      headlineVerse: Verse(
                                        id: _blocker.value.toString(),
                                        translate: false,
                                      ),
                                      headerWidth: _clearWidth,
                                      // translateHeadline: true,
                                    ),
                                  ),

                                ),

                                /// DEACT PICKERS IDS
                                BldrsBulletPoints(
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
                    BldrsBox(
                      height: 40,
                      verse: const Verse(
                        id: 'Switch\nHeadline',
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
                        mounted: mounted,
                      ),
                      margins: 5,
                    ),

                    /// DELETE
                    BldrsBox(
                      height: 40,
                      verse: const Verse(
                        id: 'Delete',
                        translate: false,
                        casing: Casing.upperCase,
                      ),
                      verseScaleFactor: 0.5,
                      verseItalic: true,
                      onTap: () => onDeletePicker(
                        context: context,
                        tempPickers: tempPickers,
                        picker: picker,
                        mounted: mounted,
                      ),
                      margins: 5,
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),

        SeparatorLine(
            width: Bubble.clearWidth(context: context) - 20,
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
