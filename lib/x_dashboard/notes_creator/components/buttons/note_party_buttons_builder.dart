import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/buttons/note_party_button.dart';
import 'package:flutter/material.dart';

class NotePartyButtonsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotePartyButtonsBuilder({
    @required this.ids,
    @required this.width,
    @required this.type,
    Key key
  }) : super(key: key);

  final List<String> ids;
  final double width;
  final PartyType type;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[

        ...List.generate(ids.length, (index){

          final String _id = ids[index];

          return NotePartyButton(
            width: width,
            id: _id,
            type: type,
          );

        }),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
