import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class NoteSenderBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteSenderBalloon({
    @required this.noteModel,
    this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel noteModel;
  final Function onTap;
  /// --------------------------------------------------------------------------
  static const double balloonWidth = 70;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// IF NULL
    if (noteModel == null){

      return Balloona(
        size: balloonWidth,
        loading: false,
        onTap: onTap,
      );

    }

    else {

      /// BLDRS
      if (noteModel.parties.senderType == PartyType.bldrs){

        return BldrsBox(
          width: balloonWidth,
          height: balloonWidth,
          icon: Iconz.bldrsNameSquare,
          iconSizeFactor: 0.8,
          onTap: onTap,
          onDoubleTap: (){
            noteModel?.blogNoteModel(invoker: 'NoteSenderBalloon bldrs doubleTap');},
        );

      }

      /// USER
      else if (noteModel.parties.senderType == PartyType.user){
        return FutureBuilder(
          future: UserProtocols.fetch(
              context: context,
              userID: noteModel.parties.senderID,
          ),
          builder: (_, AsyncSnapshot<Object> snap){

            final UserModel _userModel = snap.data;

            return Balloona(
              size: balloonWidth,
              pic: _userModel?.picPath,
              loading: false,
              onTap: onTap,
            );

          },
        );
      }

      /// BZ
      else if (noteModel.parties.senderType == PartyType.bz){

          return FutureBuilder<BzModel>(
              future: BzProtocols.fetchBz(
                context: context,
                bzID: noteModel.parties.senderID,
              ),
              builder: (_, AsyncSnapshot<Object> snap){

                final BzModel _bzModel = snap.data;

                return BzLogo(
                  width: balloonWidth,
                  image: noteModel.parties.senderImageURL ?? _bzModel?.logoPath,
                  isVerified: _bzModel?.isVerified,
                  zeroCornerIsOn: false,
                  onTap: onTap,

                );

              }
          );

      }

      /// COUNTRY
      else if (noteModel.parties.senderType == PartyType.country){
        return BldrsBox(
          width: balloonWidth,
          height: balloonWidth,
          icon: Flag.getCountryIcon(noteModel.parties.senderID), // countryID
          onTap: onTap,
        );
      }

      /// OTHERWISE
      else {
        return BldrsBox(
          width: balloonWidth,
          height: balloonWidth,
          onTap: onTap,
        );
      }

    }

  }
// -----------------------------------------------------------------------------
}
