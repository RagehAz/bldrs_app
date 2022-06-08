import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/pending_sent_authorship_notes_streamer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/f_bz_authors_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzAuthorsPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzAuthorsPage({
    Key key,
  }) : super(key: key);
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
    _loading.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    final List<AuthorModel> _authors = _bzModel.authors;
    final bool _authorIsMaster = AuthorModel.checkUserIsMasterAuthor(
        userID: superUserID(),
        bzModel: _bzModel,
    );

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        /// PENDING SENT AUTHORSHIP REQUESTS
        if (_authorIsMaster == true)
          const PendingSentAuthorshipNotesStreamer(),

        /// ADD BUTTON
        if (_authorIsMaster == true)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

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

              const BubblesSeparator(),

            ],
          ),

        /// AUTHORS
        if (_authors.isNotEmpty == true)
        ...List.generate(_authors.length, (index){
          final AuthorModel _author = _authors[index];
          return AuthorCard(
            author: _author,
            bzModel: _bzModel,
          );
        }
        ),


        ],
    );

  }
}
