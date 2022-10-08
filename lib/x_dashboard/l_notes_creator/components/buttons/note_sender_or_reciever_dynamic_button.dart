import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/d_user/z_components/user_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_country_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/f_bzz_manager/bz_long_button.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
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
  final NoteSenderOrRecieverType type;
  final String id;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// USER WIDE BUTTON
    if (type == NoteSenderOrRecieverType.user){

      return FutureBuilder(
        future: UserProtocols.fetchUser(
          context: context,
          userID: id,
        ),
          builder: (_, AsyncSnapshot<Object> snap){

          return UserTileButton(
            boxWidth: width,
            userModel: snap.data,
          );

          },
      );

    }

    /// BZ WIDE BUTTON
    else if (type == NoteSenderOrRecieverType.bz){

      return FutureBuilder(
          future: BzProtocols.fetchBz(
              context: context,
              bzID: id
          ),
          builder: (_, AsyncSnapshot<Object> snap){

            return BzLongButton(
              boxWidth: width,
              bzModel: snap.data,
              showAuthorsPics: true,
            );

          }
      );

    }

    /// COUNTRY WIDE BUTTON
    else if (type == NoteSenderOrRecieverType.country){

      return WideCountryButton(
        width: width,
        countryID: id,
        onTap: null,
      );

    }

    /// BLDRS IN MAP MODEL
    else if (type == NoteSenderOrRecieverType.bldrs){

      // NoteModel.bldrsSenderModel

      return WideButton(
        width: width,
        verse: const Verse(text: 'phid_bldrsFullName', translate: true),
        icon: Iconz.bldrsNameSquare,
        iconSizeFactor: 0.7,
      );
    }

    /// NOTHINGNESS
    else {
      return WideButton(
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
  final NoteSenderOrRecieverType type;
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
