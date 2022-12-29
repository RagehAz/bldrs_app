import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_note_fun_protocols.dart';


import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class NoteTriggerCreator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteTriggerCreator({
    @required this.noteModel,
    @required this.onSelectTrigger,
    @required this.onRemoveTrigger,
    Key key
  }) : super(key: key);

  final ValueChanged<TriggerModel> onSelectTrigger;
  final Function onRemoveTrigger;
  final NoteModel noteModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context);
    // --------------------
    const double _buttonHeight = 40;
    final double _buttonWidth = _bubbleWidth - 40;
    // --------------------
    const List<String> _triggers = NoteFunProtocols.triggersList;
    // --------------------
    return ExpandingTile(
      width: _bubbleWidth,
      firstHeadline: Verse.plain(noteModel?.function?.name),
      secondHeadline: Verse.plain('Trigger'),
      icon: Iconz.power,
      iconSizeFactor: 0.4,
      margin: const EdgeInsets.only(bottom: 10),
      // initialColor: Colorz.white10,
      expansionColor: Colorz.white10,
      child: Column(
        children: <Widget>[

          /// ALL TRIGGERS
          ...List.generate(_triggers.length, (index){

            final String _triggerID = _triggers[index];
            final bool _isSelected = noteModel?.function?.name == _triggerID;

            return DreamBox(
              height: _buttonHeight,
              width: _buttonWidth,
              margins: const EdgeInsets.only(bottom: 3),
              verse: Verse.plain(_triggerID),
              bubble: false,
              icon: Iconz.power,
              iconSizeFactor: 0.6,
              color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
              verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
              secondLineColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
              verseCentered: false,
              onTap: (){

                final TriggerModel _trigger = TriggerModel(
                    name: _triggerID,
                    argument: null,
                    done: const [],
                );

                onSelectTrigger(_trigger);

              },
            );

          }),

          /// REMOVE TRIGGER BUTTON
          DreamBox(
            height: _buttonHeight,
            width: _buttonWidth,
            margins: const EdgeInsets.only(bottom: 3),
            verse: Verse.plain('Remove Trigger'),
            icon: Iconz.xSmall,
            iconSizeFactor: 0.6,
            bubble: false,
            color: Colorz.white20,
            verseCentered: false,
            onTap: onRemoveTrigger,
          ),
        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
