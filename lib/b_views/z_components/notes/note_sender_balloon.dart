import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/bz_logo.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

class NoteSenderBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteSenderBalloon({
    @required this.noteModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel noteModel;
  /// --------------------------------------------------------------------------
  static const double balloonWidth = 70;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// IF NULL
    if (noteModel == null){

      return const Balloona(
        balloonWidth: balloonWidth,
        loading: false,
      );

    }

    else {

      /// BLDRS
      if (noteModel.noteSenderType == NoteSenderType.bldrs){
        return const BldrsName(
          size: balloonWidth,
        );
      }

      /// USER
      else if (noteModel.noteSenderType == NoteSenderType.user){
        return FutureBuilder(
          future: UserProtocols.fetchUser(
              context: context,
              userID: noteModel.senderID,
          ),
          builder: (_, AsyncSnapshot<Object> snap){

            final UserModel _userModel = snap.data;

            return Balloona(
              balloonWidth: balloonWidth,
              pic: _userModel?.pic,
              loading: false,
            );

          },
        );
      }

       /// AUTHOR
      // else if (noteModel.noteSenderType == NoteSenderType.author){
      //   return FutureBuilder(
      //       future: BzzProvider.proFetchBzModel(
      //         context: context,
      //         bzID: noteModel.senderID,
      //       ),
      //       builder: (_, AsyncSnapshot<Object> snap){
      //
      //         final BzModel _bzModel = snap.data;
      //
      //         final AuthorModel _authorModel = AuthorModel.getAuthorFromBzByAuthorID(
      //             bz: _bzModel,
      //             authorID: noteModel.senderID,
      //         );
      //
      //         return AuthorPic(
      //           authorPic: _authorModel?.pic,
      //           width: balloonWidth,
      //         );
      //
      //       }
      //   );
      // }

      /// BZ
      else if (noteModel.noteSenderType == NoteSenderType.bz){

        /// IN AUTHORSHIP NOTES : author pic is sender image url
        if (noteModel.noteType == NoteType.authorship){
          return BzLogo(
            width: balloonWidth,
            image: noteModel.senderImageURL,
            zeroCornerIsOn: false,
          );
        }

        /// otherwise : WE FETCH BZ LOGO
        else {
          return FutureBuilder<BzModel>(
              future: BzProtocols.fetchBz(
                context: context,
                bzID: noteModel.senderID,
              ),
              builder: (_, AsyncSnapshot<Object> snap){

                // final BzModel _bzModel = snap.data;

                return BzLogo(
                  width: balloonWidth,
                  image: noteModel.senderImageURL, //_bzModel?.logo,
                  zeroCornerIsOn: false,
                );

              }
          );
        }

      }

      /// COUNTRY
      else if (noteModel.noteSenderType == NoteSenderType.country){
        return DreamBox(
          width: balloonWidth,
          height: balloonWidth,
          icon: Flag.getFlagIcon(noteModel.senderID), // countryID
        );
      }

      /// OTHERWISE
      else {
        return const DreamBox(
          width: balloonWidth,
          height: balloonWidth,
        );
      }

    }

  }
// -----------------------------------------------------------------------------
}
