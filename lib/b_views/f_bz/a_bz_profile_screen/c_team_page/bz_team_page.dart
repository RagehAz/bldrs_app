import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page_controllers.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/pending_authors_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:provider/provider.dart';

class BzTeamPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzTeamPage({
    this.bubbleWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
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

      _isInit = false;
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
    // --------------------
    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );
    // --------------------
    return Selector<BzzProvider, BzModel>(
      selector: (_, BzzProvider bzzProvider) => bzzProvider.myActiveBz,
      shouldRebuild: (oldModel, newModel) => true,
      builder: (BuildContext context, BzModel bzModel, Widget? child){

        final List<AuthorModel> _authors = _bzModel?.authors;

        final bool _canSendAuthorships = AuthorModel.checkAuthorAbility(
          ability: AuthorAbility.canSendAuthorships,
          theDoer: AuthorModel.getAuthorFromBzByAuthorID(
            bz: bzModel,
            authorID: Authing.getUserID(),
          ),
          theDoneWith: null,
        );

        blog('_canSendAuthorships : $_canSendAuthorships');

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
              const PendingAuthorsBubble(),

            /// ADD BUTTON
            if (_canSendAuthorships == true)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  const DotSeparator(),

                  BldrsBox(
                    width: (widget.bubbleWidth ?? BldrsAppBar.width()) - 20,
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
        );

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
