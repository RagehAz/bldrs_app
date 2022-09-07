import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/bldrs_notes/note_templates.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/notes_creator_controller.dart';
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
  final List<NoteModel> _notes = noteTemplates;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TemplateNotesScreen',);
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
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      appBarRowWidgets: <Widget>[
        const Expander(),
        AppBarButton(
          icon: Iconz.clock,
          onTap: () {blog('to dismissed notifications');},
        ),
      ],
      // loading: _loading,
      pageTitleVerse:  '##News & Notifications',
      skyType: SkyType.black,
      pyramidsAreOn: true,
      layoutWidget: _notes.isEmpty ?
      const Center(
        child: SuperVerse(
          verse:   '##No new Notifications',
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.white20,
        ),
      )
          :
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        itemCount: _notes.length,
        padding: const EdgeInsets.only(
          top: Ratioz.stratosphere,
          bottom: Ratioz.horizon,
        ),
        itemBuilder: (BuildContext ctx, int index) {

          final NoteModel _noteModel = _notes[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const SizedBox(height: 5),

              SuperVerse(
                verse: _noteModel.id,
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
    );

  }
  // -----------------------------------------------------------------------------
}
