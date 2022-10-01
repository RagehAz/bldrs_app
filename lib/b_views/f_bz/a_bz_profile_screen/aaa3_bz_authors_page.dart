import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/pending_sent_authorship_notes_streamer.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x3_bz_authors_page_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzAuthorsPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzAuthorsPage({
    this.bubbleWidth,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  /// --------------------------------------------------------------------------
  @override
  State<BzAuthorsPage> createState() => _BzAuthorsPageState();
  /// --------------------------------------------------------------------------
}

class _BzAuthorsPageState extends State<BzAuthorsPage> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'BzAuthorsPage',);
    }
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading().then((_) async {
      //
      //   final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
      //   await _notesProvider.recallPendingSentAuthorshipNotes(
      //     context: context,
      //     notify: true,
      //   );
      //
      //   await _triggerLoading();
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );
    _bzModel.blogBz(methodName: 'BzAuthorsPage');
    // --------------------
    return Selector<BzzProvider, BzModel>(
      selector: (_, BzzProvider bzzProvider) => bzzProvider.myActiveBz,
      shouldRebuild: (oldModel, newModel) => true, /// FUCKING WORKS PERFECT
      builder: (BuildContext context, BzModel bzModel, Widget child){

        final List<AuthorModel> _authors = _bzModel?.authors;

        final bool _canSendAuthorships = AuthorModel.checkAuthorAbility(
          ability: AuthorAbility.canSendAuthorships,
          theDoer: AuthorModel.getAuthorFromBzByAuthorID(
            bz: bzModel,
            authorID: AuthFireOps.superUserID(),
          ),
          theDoneWith: null,
        );

        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: Stratosphere.stratosphereSandwich,
          children: <Widget>[

            /// AUTHORS
            if (_authors.isNotEmpty == true)
              ...List.generate(_authors.length, (index){
                final AuthorModel _author = _authors[index];
                return AuthorCard(
                  bubbleWidth: widget.bubbleWidth,
                  author: _author,
                  bzModel: bzModel,
                );
              }
              ),

            /// PENDING SENT AUTHORSHIP REQUESTS
            if (_canSendAuthorships == true)
              const PendingSentAuthorshipNotesStreamer(),

            /// ADD BUTTON
            if (_canSendAuthorships == true)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  const DotSeparator(),

                  DreamBox(
                    width: (widget.bubbleWidth ?? BldrsAppBar.width(context)) - 20,
                    height: 80,
                    bubble: false,
                    color: Colorz.white10,
                    verseCentered: false,
                    verse: const Verse(
                      pseudo: 'Add Authors to the team',
                      text: 'phid_add_authors_to_the_team',
                      translate: true,
                    ),
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

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
