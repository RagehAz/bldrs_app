import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/bldrs_notes/note_templates.dart';
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
    // _notifications.addAll(BldrsNotiModelz.allNotifications());
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {
        /// ---------------------------------------------------------0

        /// ---------------------------------------------------------0
        await _triggerLoading();
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
      // appBarRowWidgets: <Widget>[
        // const Expander(),
        // AppBarButton(
        //   icon: Iconz.clock,
        //   onTap: () {blog('to dismissed notifications');},
        // ),
      // ],
      skyType: SkyType.black,
      pyramidsAreOn: true,
      layoutWidget: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          /// STANDARD TEMPLATES
          PageBubble(
              screenHeightWithoutSafeArea: _screenHeight,
              appBarType: AppBarType.basic,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: ScrollController(),
                itemCount: noteTemplates.length,
                padding: const EdgeInsets.only(
                  top: Ratioz.stratosphere,
                  bottom: Ratioz.horizon,
                ),
                itemBuilder: (BuildContext ctx, int index) {

                  final NoteModel _noteModel = noteTemplates[index];

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

                      NoteCard(
                        noteModel: _noteModel,
                        isDraftNote: true,
                        onCardTap: () => onSelectNoteTemplateTap(
                          context: context,
                          noteModel: _noteModel,
                        ),
                      ),

                    ],
                  );

                },
              ),

    ),

          /// LDB RECENT NOTES
          PageBubble(
            screenHeightWithoutSafeArea: _screenHeight,
            appBarType: AppBarType.basic,
            child: ValueListenableBuilder(
              valueListenable: _ldbRecentNotes,
              builder: (_, List<NoteModel> notes, Widget child){

                if (Mapper.checkCanLoopList(notes) == true){
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: ScrollController(),
                    itemCount: notes.length,
                    padding: const EdgeInsets.only(
                      top: Ratioz.stratosphere,
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

                          NoteCard(
                            noteModel: _noteModel,
                            isDraftNote: true,
                            onCardTap: () => onSelectNoteTemplateTap(
                              context: context,
                              noteModel: _noteModel,
                            ),
                          ),

                        ],
                      );

                    },
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


              },
            ),

          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
