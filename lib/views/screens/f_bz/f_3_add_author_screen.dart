import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AddAuthorScreen extends StatelessWidget {
  final TinyBz tinyBz;

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

          Stratosphere(),

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

              String _ragehUserID = 'rBjNU5WybKgJXaiBnlcBnfFaQSq1';

              BzModel _bzModel = await BzOps.readBzOps(
                context: context,
                bzID: tinyBz.bzID,
              );

              UserModel _ragehUserModel = await UserOps().readUserOps(
                context: context,
                userID: _ragehUserID,
              );

              AuthorModel _ragehAuthor = AuthorModel.getAuthorModelFromUserModel(
                userModel: _ragehUserModel,
              );

              List<AuthorModel> _newAuthorsList = <AuthorModel>[..._bzModel.bzAuthors, _ragehAuthor];

              await Fire.updateDocField(
                context: context,
                collName: FireCollection.bzz,
                docName: _bzModel.bzID,
                field: 'bzAuthors',
                input: AuthorModel.cipherAuthorsModels(_newAuthorsList),
              );

              /// add bzID in user's myBzIDs
              List<dynamic> _userBzzIDs = _ragehUserModel.myBzzIDs;
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


