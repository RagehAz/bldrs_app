import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/author_card.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/invite_authors_controller.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class BzAuthorsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAuthorsPage({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------

  /*

  OLD AUTHOR EDITING METHODS IN OLD BZ EDITOR FOR YOUR REFERENCE

    // ---------------------------------------------------------------


  /// IN ON CREATE

    //   /// create new master AuthorModel
    //   final AuthorModel _firstMasterAuthor = AuthorModel(
    //     userID: widget.userModel.id,
    //     name: _authorNameTextController.text,
    //     pic: _currentAuthorPicFile, // if null createBzOps uses user.pic URL instead
    //     title: _authorTitleTextController.text,
    //     isMaster: true,
    //     contacts: _currentAuthorContacts,
    //   );


    //   final List<AuthorModel> _firstTimeAuthorsList = <AuthorModel>[
    //     _firstMasterAuthor,
    //   ];

    // ---------------------------------------------------------------

  /// IN ON UPDATE

    //   /// create modified authorModel
    //   final AuthorModel _newAuthor = AuthorModel(
    //     userID: widget.userModel.id,
    //     name: _authorNameTextController.text,
    //     pic: _currentAuthorPicFile ?? _currentAuthorPicURL,
    //     title: _authorTitleTextController.text,
    //     isMaster: _currentAuthor.isMaster,
    //     contacts: _currentAuthorContacts,
    //   );
    //
    //   final AuthorModel _oldAuthor = AuthorModel.getAuthorFromBzByAuthorID(
    //       widget.bzModel, widget.userModel.id);
    //
    //   final List<AuthorModel> _modifiedAuthorsList = AuthorModel.replaceAuthorModelInAuthorsList(
    //     originalAuthors: _currentBzAuthors,
    //     oldAuthor: _oldAuthor,
    //     newAuthor: _newAuthor,
    //   );

    // ---------------------------------------------------------------

   */

  @override
  Widget build(BuildContext context) {

    final List<AuthorModel> _authors = bzModel.authors;
    final int _numberOfAuthors = _authors.length;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _numberOfAuthors + 1,
      itemBuilder: (_, index){

        /// ADD AUTHORS BUTTON
        if (index == _numberOfAuthors){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const BubblesSeparator(),

              DreamBox(
                width: Scale.superScreenWidth(context) - 20,
                height: 80,
                bubble: false,
                color: Colorz.white20,
                verseCentered: false,
                verse: 'Add Authors to the team',
                icon: Iconz.plus,
                iconSizeFactor: 0.5,
                verseScaleFactor: 1.4,
                margins: 10,
                corners: AuthorCard.bubbleCornerValue(),
                onTap: () => onGoToAddAuthorsScreen(context),
              ),

            ],
          );
        }

        /// AUTHOR CARDS
        else {
          final AuthorModel _author = _authors[index];
          return AuthorCard(
            author: _author,
            bzModel: bzModel,
          );
        }

        },
    );
  }
}
