import 'dart:async';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/ldb/ops/phrase_ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/phrase_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/x_phrase_editor_controllers.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/b_phrase_editor_screen.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhraseManager extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PhraseManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _PhraseManagerState createState() => _PhraseManagerState();
  /// --------------------------------------------------------------------------
}

class _PhraseManagerState extends State<PhraseManager> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({
    bool setTo,
  }) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
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

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

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

    final double _screenWidth = Scale.superScreenWidth(context);

    return DashBoardLayout(
      // pageTitle: _flyerType?.toString(),
      appBarWidgets: <Widget>[

        /// GO TO NEW EDITOR
        AppBarButton(
          icon: Iconz.language,
          verse: Verse.plain('NEW Editor'),
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const PhraseEditorScreen(),
            );

          },
        ),

      ],
      listWidgets: <Widget>[

        // ---------------------------------------

        /// PHRASES CREATION
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse: Verse.plain('REAL'),
        ),

        /// MIGRATE main phrases from fire to real
        WideButton(
          isActive: false,
          verse: Verse.plain('MIGRATE main phrases from FIRE to REAL'),
          onTap: () async {

            final List<Phrase> _enPhrases = await readMainPhrasesFromFire(
              context: context,
              langCode: 'en',
            );
            await PhraseRealOps.createPhrasesForLang(
                context: context,
                langCode: 'en',
                phrases: _enPhrases
            );

            final List<Phrase> _arPhrases = await readMainPhrasesFromFire(
              context: context,
              langCode: 'ar',
            );
            await PhraseRealOps.createPhrasesForLang(
                context: context,
                langCode: 'ar',
                phrases: _arPhrases
            );


            Phrase.blogPhrases(_enPhrases);
            Phrase.blogPhrases(_arPhrases);

          },
        ),

        /// REAL EN READ
        WideButton(
          verse: Verse.plain('REAL READ EN PHRASESs'),
          onTap: () async {

            // final List<Phrase> _firePhrases = await readBasicPhrases(
            //   context: context,
            //   langCode: 'en',
            // );

            final List<Phrase> _realPhrases = await PhraseRealOps.readPhrasesByLang(
              context: context,
              langCode: 'en',
              createTrigram: true,
            );

            Phrase.blogPhrases(_realPhrases);
            // blog('_firePhrases length : ${_firePhrases.length}');

            // final bool _identical = Phrase.phrasesListsAreIdentical(
            //     phrases1: _firePhrases,
            //     phrases2: _realPhrases,
            // );
            //
            // blog('identical : $_identical');

          },
        ),

        /// REAL ar READ
        WideButton(
          verse: Verse.plain('REAL READ AR PHRASESs'),
          onTap: () async {

            final List<Phrase> _realPhrases = await PhraseRealOps.readPhrasesByLang(
              context: context,
              langCode: 'ar',
              createTrigram: true,
            );

            Phrase.blogPhrases(_realPhrases);

          },
        ),

        // ---------------------------------------

        /// PHRASES PRO
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse: Verse.plain('PRO'),
        ),

        /// READ MAIN PHRASES
        WideButton(
          verse: Verse.plain('READ PRO MAIN PHRASES'),
          onTap: () async {

            final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
            final List<Phrase> _phrases = _phraseProvider.mainPhrases;
            Phrase.blogPhrases(_phrases);

          },
        ),

        // ---------------------------------------

        /// LDD
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse: Verse.plain('LDB'),
        ),

        /// READ MAIN PHRASES
        WideButton(
          verse: Verse.plain('READ LDB MAIN PHRASES'),
          onTap: () async {

            final List<Phrase> _phrases = await PhraseLDBOps.readMainPhrases();
            Phrase.blogPhrases(_phrases);

          },
        ),

        // ---------------------------------------

        const SeparatorLine(),

        const Horizon(),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
