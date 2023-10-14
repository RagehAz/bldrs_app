import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/pending_authors_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzTeamPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzTeamPage({
    this.bubbleWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? bubbleWidth;
  /// --------------------------------------------------------------------------
  @override
  State<BzTeamPage> createState() => _BzTeamPageState();
  /// --------------------------------------------------------------------------
}

class _BzTeamPageState extends State<BzTeamPage> {
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
   */
  // --------------------
  /*
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
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
      _isInit = false; // good

      // _triggerLoading().then((_) async {
      //
      //   final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(),
      //   listen: false);
      //   await _notesProvider.recallPendingSentAuthorshipNotes(
      //     context: context,
      //     notify: true,
      //   );
      //
      //   await _triggerLoading();
      // });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    /*
    _loading.dispose();
     */
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('wtf');
    // --------------------
    return Selector<BzzProvider, BzModel?>(
      selector: (_, BzzProvider bzzProvider) => bzzProvider.myActiveBz,
      shouldRebuild: (oldModel, newModel){

        BzModel.blogBzzDifferences(
          bz1: oldModel,
          bz2: newModel,
        );
        return true;
        },

      builder: (BuildContext context, BzModel? bzModel, Widget? child){

        final List<AuthorModel> _authors = bzModel?.authors ?? [];
        final bool _canSendAuthorships = AuthorModel.checkAuthorAbility(
          ability: AuthorAbility.canSendAuthorships,
          theDoer: AuthorModel.getAuthorFromBzByAuthorID(
            bz: bzModel,
            authorID: Authing.getUserID(),
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

            if (_canSendAuthorships == true)
              child!,

          ],
        );

      },
      child: Column(
        children: <Widget>[

          /// PENDING SENT AUTHORSHIP REQUESTS
          const PendingAuthorsBubble(),

          /// ADD BUTTON
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// DOT
              const DotSeparator(),

              /// ADD AUTHORS BUTTON
              BldrsBox(
                width: Bubble.bubbleWidth(context: context, bubbleWidthOverride: widget.bubbleWidth),
                height: 80,
                bubble: false,
                color: Colorz.white10,
                verseCentered: false,
                verse: const Verse(
                  pseudo: 'Add Authors to the team',
                  id: 'phid_add_authors_to_the_team',
                  translate: true,
                ),
                icon: Iconz.plus,
                iconSizeFactor: 0.5,
                margins: 10,
                corners: AuthorCard.bubbleCornerValue(),
                onTap: () => onGoToAddAuthorsScreen(context),
              ),

            ],
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
