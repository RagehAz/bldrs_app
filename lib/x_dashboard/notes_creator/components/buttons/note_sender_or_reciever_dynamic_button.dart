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

class NotePartyButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotePartyButton({
    @required this.type,
    @required this.id,
    @required this.width,
    this.height,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NotePartyType type;
  final String id;
  final double width;
  final double height;
  final Function onTap;
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
            height: height,
            userModel: snap.data,
            onTap: onTap,
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
              height: height,
              bzModel: snap.data,
              onTap: onTap,
            );

          }
      );

    }

    /// COUNTRY WIDE BUTTON
    else if (type == NotePartyType.country){

      return CountryTileButton(
        width: width,
        height: height,
        countryID: id,
        onTap: onTap,
      );

    }

    /// BLDRS IN MAP MODEL
    else if (type == NotePartyType.bldrs){

      return TileButton(
        width: width,
        height: height,
        verse: const Verse(text: 'phid_bldrsFullName', translate: true),
        icon: Iconz.bldrsNameSquare,
        iconSizeFactor: 0.7,
        onTap: onTap,
      );

    }

    /// NOTHINGNESS
    else {
      return TileButton(
        height: height,
        width: width,
        onTap: onTap,
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
