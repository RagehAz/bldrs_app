import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/db/fire/ops/bz_ops.dart' as FireBzOps;
import 'package:bldrs/db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AddAuthorScreen extends StatelessWidget {
  final BzModel tinyBz;

  const AddAuthorScreen({
    @required this.tinyBz,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MainLayout(
      skyType: SkyType.black,
      pageTitle: 'Add new Author',
      pyramids: Iconz.pyramidzYellow,
      // appBarBackButton: true,
      appBarType: AppBarType.basic,
      layoutWidget: ListView(
        children: <Widget>[

          const Stratosphere(),

          Bubble(
              title: 'Share invitation Link',
              width: Bubble.defaultWidth(context),
              columnChildren: <Widget>[

                Container(
                  width: Bubble.clearWidth(context),
                  child: SuperVerse(
                    verse: 'This Link is available for one time use only, '
                        'to allow its reciever to be redirected to '
                        'creating new author account for your Business page',
                    weight: VerseWeight.thin,
                    maxLines: 5,
                    centered: false,
                    color: Colorz.white125,

                  ),
                ),

                SuperVerse(
                  verse: 'Invitation link . com',
                  maxLines: 2,
                  margin: 10,
                  weight: VerseWeight.thin,
                  italic: true,
                  color: Colorz.cyan255,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[

                    const DreamBox(
                      height: 50,
                      color: Colorz.yellow255,
                      icon: Iconz.share,
                      iconSizeFactor: 0.5,
                      iconColor: Colorz.black230,
                      verse: 'Share',
                      verseColor: Colorz.black230,
                      verseScaleFactor: 1.2,
                    ),

                  ],
                ),

              ],
          ),


          DreamBox(
            verse: 'Add Rageh as Author',
            height: 50,
            icon: Iconz.dvRageh,
            margins: const EdgeInsets.only(top: 30),
            verseScaleFactor: 0.7,
            onTap: () async {

              await CenterDialog.showCenterDialog(
                context: context,
                title: 'Khally balak ba2a',
              );

              const String _ragehUserID = 'xxx';

              final BzModel _bzModel = await FireBzOps.readBz(
                context: context,
                bzID: tinyBz.id,
              );

              final UserModel _ragehUserModel = await UserFireOps.readUser(
                context: context,
                userID: _ragehUserID,
              );

              final AuthorModel _ragehAuthor = AuthorModel.getAuthorModelFromUserModel(
                userModel: _ragehUserModel,
              );

              final List<AuthorModel> _newAuthorsList = <AuthorModel>[..._bzModel.authors, _ragehAuthor];

              await Fire.updateDocField(
                context: context,
                collName: FireColl.bzz,
                docName: _bzModel.id,
                field: 'bzAuthors',
                input: AuthorModel.cipherAuthors(_newAuthorsList),
              );

              /// add bzID in user's myBzIDs
              final List<dynamic> _userBzzIDs = _ragehUserModel.myBzzIDs;
              _userBzzIDs.insert(0, _bzModel.id);
              await Fire.updateDocField(
                context: context,
                collName: FireColl.users,
                docName: _ragehUserID,
                field: 'myBzzIDs',
                input: _userBzzIDs,
              );

              await CenterDialog.showCenterDialog(
                context: context,
                title: 'tamam',
                body: 'Done baby',
              );

              Nav.goBack(context);

            },
          ),

        ],
      ),
    );
  }
}


