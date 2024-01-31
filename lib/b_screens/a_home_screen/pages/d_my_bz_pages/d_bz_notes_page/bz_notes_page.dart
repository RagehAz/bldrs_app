import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/components/animators/widget_waiter.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/layouts/handlers/pull_to_refresh.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/c_my_notifications_page/user_notes_page_controllers.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_pages/d_bz_notes_page/bz_notes_page_controllers.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/buttons/general_buttons/main_button.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/mirage/mirage.dart';
import 'package:bldrs/z_components/notes/note_card.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class BzNotesPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzNotesPage({
    this.appBarType = AppBarType.basic,
    super.key
  });

  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  State<BzNotesPage> createState() => _BzNotesPageState();
  /// --------------------------------------------------------------------------
}

class _BzNotesPageState extends State<BzNotesPage>{
  // -----------------------------------------------------------------------------
  /*
  // with AutomaticKeepAliveClientMixin<BzNotesPage>
  // @override
  // bool get wantKeepAlive => true;
   */
  // -----------------------------------------------------------------------------
  PaginationController? _paginationController;
  // --------------------
  final List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
  // --------------------
  bool showNotes = true;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _paginationController = PaginationController.initialize(
      mounted: mounted,
      addExtraMapsAtEnd: true,
      onDataChanged: _collectUnseenNotesToMarkAtDispose,
    );
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        NotesProvider.proSetIsFlashing(
            setTo: false,
            notify: true
        );
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void deactivate() {
    blog('BzNotesPage deactivate START');
    _markAllBzUnseenNotesAsSeen();
    super.deactivate();
    blog('BzNotesPage deactivate END');
  }
  // --------------------
  @override
  void dispose() {
    blog('BzNotesPage dispose START');
    _loading.dispose();
    _paginationController?.dispose();
    super.dispose();
    blog('BzNotesPage dispose END');
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _markAllBzUnseenNotesAsSeen(){

    /// COLLECT NOTES TO MARK FIRST
    final List<NoteModel> _notesToMark = NoteModel.getOnlyUnseenNotes(
      notes: _localNotesToMarkUnseen,
    );

    /// MARK ON FIREBASE
    unawaited(NoteFireOps.markNotesAsSeen(
        notes: _notesToMark
    ));

    if (Lister.checkCanLoop(_notesToMark) == false){
      final BzModel? _bzModel = HomeProvider.proGetActiveBzModel(
        context: context,
        listen: false,
      );
      if (_bzModel?.id != null){
        NotesProvider.proSetBadge(
          bid: TabName.generateBzBid(bzID: _bzModel!.id!, bid: TabName.bid_MyBz_Notes),
          value: 0,
          notify: true,
        );
      }
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _collectUnseenNotesToMarkAtDispose(List<Map<String, dynamic>> paginatorMaps){

    if (Lister.checkCanLoop(paginatorMaps) == true){

      /// DECIPHER NEW MAPS TO NOTES
      final List<NoteModel> _newNotes = NoteModel.decipherNotes(
        maps: paginatorMaps,
        fromJSON: false,
      );

      /// ADD NEW NOTES TO LOCAL NOTES NEEDS TO MARK AS SEEN
      for (final NoteModel note in _newNotes){
        NoteModel.insertNoteIntoNotes(
          notesToGet: _localNotesToMarkUnseen,
          note: note,
          duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
        );
      }


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onRefresh() async {

    _markAllBzUnseenNotesAsSeen();

    NotesProvider.proSetIsFlashing(
        setTo: false,
        notify: true
    );

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(id: 'phid_reloading', translate: true,),
    );

    setState(() {
      showNotes = false;
    });

    await Future.delayed(const Duration(milliseconds: 200), (){

      setNotifier(
          notifier: _paginationController?.paginatorMaps,
          mounted: mounted,
          value: <Map<String, dynamic>>[],
      );
      setNotifier(
          notifier: _paginationController?.startAfter,
          mounted: mounted,
          value: null,
      );

      setState(() {
        showNotes = true;
      });

    });

    await WaitDialog.closeWaitDialog();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Function? _onNoteTap(NoteModel? _note) {

    if (canTapNoteBubble(_note) == true){
      return () => onBzNoteTap(
        mounted: mounted,
        noteModel: _note,
      );
    }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    final BzModel? _bzModel = HomeProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    return PullToRefresh(
      circleColor: Colorz.yellow255,
      onRefresh: _onRefresh,
      fadeOnBuild: true,
      child: showNotes == false ? const SizedBox() :

      FireCollPaginator(
          paginationQuery: bzNotesPaginationQueryModel(
            bzID: _bzModel?.id,
          ),
          paginationController: _paginationController,
          builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget? child){

            if (Lister.checkCanLoop(maps) == true){
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _paginationController?.scrollController,
                itemCount: maps.length,
                padding: EdgeInsets.only(
                  top: widget.appBarType == AppBarType.non ? Ratioz.appBarMargin : Ratioz.stratosphere,
                  bottom: MirageModel.getBzMirageBottomInsetsValue(context),
                ),
                itemBuilder: (BuildContext ctx, int index) {
                  final NoteModel? _note = NoteModel.decipherNote(
                    map: maps[index],
                    fromJSON: false,
                  );
                  return NoteCard(
                    key: PageStorageKey<String>('bz_note_card_${_note?.id}'),
                    noteModel: _note,
                    onCardTap: _onNoteTap(_note),
                  );
                  },
              );
            }

            else {

              return const NoNotificationsYet();

            }
          }
      ),

    );

  }
  // -----------------------------------------------------------------------------
}


class NoNotificationsYet extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NoNotificationsYet({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetWaiter(
      waitDuration: const Duration(milliseconds: 1500),
      child: WidgetFader(
        fadeType: FadeType.fadeIn,
        duration: Ratioz.duration1000ms,
        child: Center(
          child: BldrsText(
            width: MainButton.getButtonWidth(context: context),
            verse: const Verse(
              id: 'phid_no_notes_yet',
              translate: true,
              casing: Casing.upperCase,
            ),
            size: 4,
            color: Colorz.white80,
            weight: VerseWeight.black,
            italic: true,
            maxLines: 3,
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
