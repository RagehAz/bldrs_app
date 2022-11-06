import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/flag_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
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
        balloonWidth: balloonWidth,
        loading: false,
        onTap: onTap,
      );

    }

    else {

      /// BLDRS
      if (noteModel.parties.senderType == PartyType.bldrs){

        return GestureDetector(
          onTap: onTap,
          child: const SizedBox(
            width: balloonWidth,
            height: balloonWidth,
            child: BldrsName(
              size: balloonWidth,
            ),
          ),
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
              balloonWidth: balloonWidth,
              pic: _userModel?.picPath,
              loading: false,
              onTap: onTap,
            );

          },
        );
      }

      /// BZ
      else if (noteModel.parties.senderType == PartyType.bz){

          // return BzLogo(
          //   width: balloonWidth,
          //   image: noteModel.parties.senderImageURL,
          //   zeroCornerIsOn: false,
          //   onTap: onTap,
          // );
          return FutureBuilder<BzModel>(
              future: BzProtocols.fetch(
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
                );

              }
          );

      }

      /// COUNTRY
      else if (noteModel.parties.senderType == PartyType.country){
        return DreamBox(
          width: balloonWidth,
          height: balloonWidth,
          icon: Flag.getFlagIcon(noteModel.parties.senderID), // countryID
          onTap: onTap,
        );
      }

      /// OTHERWISE
      else {
        return DreamBox(
          width: balloonWidth,
          height: balloonWidth,
          onTap: onTap,
        );
      }

    }

  }
// -----------------------------------------------------------------------------
}
