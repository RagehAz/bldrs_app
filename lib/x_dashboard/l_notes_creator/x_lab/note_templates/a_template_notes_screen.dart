import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/note_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/buttons/note_sender_or_reciever_dynamic_button.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/note_templates/x_note_templates.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class TemplateNotesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const TemplateNotesScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TemplateNotesScreenState createState() => _TemplateNotesScreenState();
  /// --------------------------------------------------------------------------
}

class _TemplateNotesScreenState extends State<TemplateNotesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<NoteModel>> _ldbRecentNotes = ValueNotifier(<NoteModel>[]);
  final PageController _pageController = PageController();
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _progressBarModel.value = const ProgressBarModel(
        swipeDirection: SwipeDirection.freeze,
        index: 0,
        numberOfStrips: 2,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading(setTo: true).then((_) async {
        /// ---------------------------------------------------------0

        final List<NoteModel> _ldbNotes = await NoteLDBOps.readAllNotes(context);

        if (Mapper.checkCanLoopList(_ldbNotes) == true){
          _ldbRecentNotes.value = _ldbNotes;
        }

        /// ---------------------------------------------------------0
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _ldbRecentNotes.dispose();
    _pageController.dispose();
    _progressBarModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      appBarType: AppBarType.basic,
      pageTitleVerse: Verse.plain('Template notes'),
      sectionButtonIsOn: false,
      loading: _loading,
      appBarRowWidgets: <Widget>[
        const Expander(),
        AppBarButton(
          icon: Iconz.clock,
          onTap: () async {

            final List<NoteModel> _ldbNotes = await NoteLDBOps.readAllNotes(context);
            if (Mapper.checkCanLoopList(_ldbNotes) == true){
              _ldbRecentNotes.value = _ldbNotes;
            }

            },
        ),
      ],
      skyType: SkyType.black,
      progressBarModel: _progressBarModel,
      layoutWidget: PageView(
        controller: _pageController,
        onPageChanged: (int index) => ProgressBarModel.onSwipe(
            context: context,
            newIndex: index,
            progressBarModel: _progressBarModel,
        ),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          /// STANDARD TEMPLATES
          PageBubble(
            screenHeightWithoutSafeArea: _screenHeight,
            appBarType: AppBarType.basic,
            color: Colorz.white10,
            child: const _NotesBuilderPage(
              notes: noteTemplates,
            ),
          ),

          /// LDB RECENT NOTES
          PageBubble(
            screenHeightWithoutSafeArea: _screenHeight,
            appBarType: AppBarType.basic,
            color: Colorz.white10,
            child: ValueListenableBuilder(
              valueListenable: _ldbRecentNotes,
              builder: (_, List<NoteModel> notes, Widget child){

                return _NotesBuilderPage(
                  notes: notes,
                );

              },
            ),

          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class _NotesBuilderPage extends StatelessWidget {

  const _NotesBuilderPage({
    @required this.notes,
    Key key
  }) : super(key: key);

  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(notes) == true){
      return Scroller(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: ScrollController(),
          itemCount: notes.length,
          padding: const EdgeInsets.only(
            top: Ratioz.appBarMargin,
            bottom: Ratioz.horizon,
          ),
          itemBuilder: (BuildContext ctx, int index) {

            final NoteModel _noteModel = notes[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                const SizedBox(height: 5),

                SuperVerse(
                  verse: Verse(
                    text: _noteModel.id,
                    translate: false,
                  ),
                  centered: false,
                  size: 1,
                  italic: true,
                  weight: VerseWeight.thin,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                ),


                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[

                    NoteCard(
                      bubbleWidth: PageBubble.clearWidth(context),
                      noteModel: _noteModel,
                      isDraftNote: true,
                      onCardTap: () => onSelectNoteTemplateTap(
                        context: context,
                        noteModel: _noteModel,
                      ),
                    ),

                    if (_noteModel.receiverID != null)
                    Transform.scale(
                      scale: 0.7,
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: NoteSenderOrRecieverDynamicButton(
                          width: PageBubble.clearWidth(context) * 0.5,
                          type: _noteModel.receiverType,
                          id: _noteModel.receiverID,
                        ),
                      ),
                    ),

                  ],
                ),


              ],
            );

          },
        ),
      );
    }

    else {
      return const SuperVerse(
        verse: Verse(
          text: 'No Notes in LDB found',
          translate: false,
        ),
        color: Colorz.yellow200,
      );
    }

  }
}