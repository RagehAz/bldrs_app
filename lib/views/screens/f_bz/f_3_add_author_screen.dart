import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/db/firestore/bz_ops.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/db/firestore/user_ops.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AddAuthorScreen extends StatelessWidget {
  final BzModel tinyBz;

  AddAuthorScreen({
    @required this.tinyBz,
});

  @override
  Widget build(BuildContext context) {


    return MainLayout(
      sky: Sky.Black,
      pageTitle: 'Add new Author',
      pyramids: Iconz.PyramidzYellow,
      // appBarBackButton: true,
      appBarType: AppBarType.Basic,
      layoutWidget: ListView(
        children: <Widget>[

          const Stratosphere(),

          Bubble(
              centered: false,
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
                    size: 2,
                    color: Colorz.White125,

                  ),
                ),

                SuperVerse(
                  verse: 'Invitation link . com',
                  maxLines: 2,
                  margin: 10,
                  weight: VerseWeight.thin,
                  italic: true,
                  color: Colorz.Cyan225,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    DreamBox(
                      height: 50,
                      color: Colorz.Yellow255,
                      icon: Iconz.Share,
                      iconSizeFactor: 0.5,
                      iconColor: Colorz.Black230,
                      verse: 'Share',
                      verseColor: Colorz.Black230,
                      verseScaleFactor: 1.2,
                    ),

                  ],
                ),

              ],
          ),


          DreamBox(
            verse: 'Add Rageh as Author',
            height: 50,
            icon: Iconz.DvRageh,
            margins: const EdgeInsets.only(top: 30),
            verseScaleFactor: 0.7,
            onTap: () async {

              await CenterDialog.showCenterDialog(
                context: context,
                title: 'Khally balak ba2a',
              );

              final String _ragehUserID = 'xxx';

              final BzModel _bzModel = await BzOps.readBzOps(
                context: context,
                bzID: tinyBz.bzID,
              );

              final UserModel _ragehUserModel = await UserOps.readUserOps(
                context: context,
                userID: _ragehUserID,
              );

              final AuthorModel _ragehAuthor = AuthorModel.getAuthorModelFromUserModel(
                userModel: _ragehUserModel,
              );

              final List<AuthorModel> _newAuthorsList = <AuthorModel>[..._bzModel.bzAuthors, _ragehAuthor];

              await Fire.updateDocField(
                context: context,
                collName: FireCollection.bzz,
                docName: _bzModel.bzID,
                field: 'bzAuthors',
                input: AuthorModel.cipherAuthorsModels(_newAuthorsList),
              );

              /// add bzID in user's myBzIDs
              final List<dynamic> _userBzzIDs = _ragehUserModel.myBzzIDs;
              _userBzzIDs.insert(0, _bzModel.bzID);
              await Fire.updateDocField(
                context: context,
                collName: FireCollection.users,
                docName: _ragehUserID,
                field: 'myBzzIDs',
                input: _userBzzIDs,
              );

              await CenterDialog.showCenterDialog(
                context: context,
                title: 'tamam',
                body: 'Done baby',
                boolDialog: false,
              );

              Nav.goBack(context);

            },
          ),

        ],
      ),
    );
  }
}


