import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/pending_sent_authorship_notes_streamer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/author_invitations_controller.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class BzAuthorsPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzAuthorsPage({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  State<BzAuthorsPage> createState() => _BzAuthorsPageState();
/// --------------------------------------------------------------------------

}

class _BzAuthorsPageState extends State<BzAuthorsPage> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzAuthorsPage',
    );
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
        await _notesProvider.recallPendingSentAuthorshipNotes(
          context: context,
          notify: true,
        );

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _loading.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<AuthorModel> _authors = widget.bzModel.authors;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        /// AUTHORS
        if (_authors.isNotEmpty == true)
        ...List.generate(_authors.length, (index){
          final AuthorModel _author = _authors[index];
          return AuthorCard(
            bubbleWidth: BldrsAppBar.width(context),
            author: _author,
            bzModel: widget.bzModel,
          );
        }
        ),

        /// PENDING SENT AUTHORSHIP REQUESTS
        const PendingSentAuthorshipNotesStreamer(),
        // Consumer<NotesProvider>(
        //   builder: (BuildContext ctx, NotesProvider notesProvider, Widget child) {
        //
        //     final List<UserModel> _notesUsers = notesProvider.pendingSentAuthorshipUsers;
        //     final List<NoteModel> _notes = notesProvider.pendingSentAuthorshipNotes;
        //
        //     if (Mapper.canLoopList(_notesUsers) == false){
        //       return const SizedBox();
        //     }
        //
        //     else {
        //
        //       return Bubble(
        //         title: 'Pending Invitation requests',
        //         width: BldrsAppBar.width(context),
        //         columnChildren: <Widget>[
        //
        //           ...List.generate(_notesUsers.length, (index){
        //
        //             final UserModel _userModel = _notesUsers[index];
        //             return UserTileButton(
        //               boxWidth: Bubble.clearWidth(context),
        //               userModel: _userModel,
        //               color: Colorz.white10,
        //               bubble: false,
        //               sideButton: 'Cancel',
        //               onSideButtonTap: () => cancelSentAuthorshipInvitation(
        //                 context: context,
        //                 receiverID: _userModel.id,
        //                 pendingNotes: _notes,
        //               ),
        //             );
        //
        //           }),
        //
        //         ],
        //       );
        //
        //     }
        //
        //   },
        // ),

        /// ADD BUTTON
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const BubblesSeparator(),

            DreamBox(
              width: BldrsAppBar.width(context),
              height: 80,
              bubble: false,
              color: Colorz.white10,
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
        ),

        ],
    );

  }
}
