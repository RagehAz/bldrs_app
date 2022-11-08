import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/ldb/phrase_ldb_ops.dart';
import 'package:bldrs/c_protocols/phrase_protocols/real/phrase_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/x_dashboard/phrase_editor/x_phrase_editor_controllers.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhrasesLab extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PhrasesLab({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _PhrasesLabState createState() => _PhrasesLabState();
  /// --------------------------------------------------------------------------
}

class _PhrasesLabState extends State<PhrasesLab> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({@required bool setTo}) async {
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

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
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

    final double _screenWidth = Scale.screenWidth(context);

    return DashBoardLayout(
      // pageTitle: _flyerType?.toString(),
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
              langCode: 'en',
            );
            await PhraseRealOps.createPhrasesForLang(
                langCode: 'en',
                phrases: _enPhrases
            );

            final List<Phrase> _arPhrases = await readMainPhrasesFromFire(
              langCode: 'ar',
            );
            await PhraseRealOps.createPhrasesForLang(
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
