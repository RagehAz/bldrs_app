import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/bz_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/country_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/user_tile_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class NoteSenderOrRecieverDynamicButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteSenderOrRecieverDynamicButton({
    @required this.type,
    @required this.id,
    @required this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NotePartyType type;
  final String id;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// USER WIDE BUTTON
    if (type == NotePartyType.user){

      return FutureBuilder(
        future: UserProtocols.fetchUser(
          context: context,
          userID: id,
        ),
          builder: (_, AsyncSnapshot<Object> snap){

          return UserTileButton(
            width: width,
            userModel: snap.data,
          );

          },
      );

    }

    /// BZ WIDE BUTTON
    else if (type == NotePartyType.bz){

      return FutureBuilder(
          future: BzProtocols.fetchBz(
              context: context,
              bzID: id
          ),
          builder: (_, AsyncSnapshot<Object> snap){

            return BzTileButton(
              width: width,
              bzModel: snap.data,
            );

          }
      );

    }

    /// COUNTRY WIDE BUTTON
    else if (type == NotePartyType.country){

      return CountryTileButton(
        width: width,
        countryID: id,
        onTap: null,
      );

    }

    /// BLDRS IN MAP MODEL
    else if (type == NotePartyType.bldrs){

      return TileButton(
        width: width,
        verse: const Verse(text: 'phid_bldrsFullName', translate: true),
        icon: Iconz.bldrsNameSquare,
        iconSizeFactor: 0.7,
      );

    }

    /// NOTHINGNESS
    else {
      return TileButton(
        width: width,
      );
    }

  }
  /// --------------------------------------------------------------------------
}

class NoteSenderOrRecieverDynamicButtonsColumn extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteSenderOrRecieverDynamicButtonsColumn({
    @required this.ids,
    @required this.width,
    @required this.type,
    Key key
  }) : super(key: key);

  final List<String> ids;
  final double width;
  final NotePartyType type;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[

        ...List.generate(ids.length, (index){

          final String _id = ids[index];

          return NoteSenderOrRecieverDynamicButton(
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
