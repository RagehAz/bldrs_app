import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';


import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class DistrictEditorBubble extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const DistrictEditorBubble({
    @required this.districtModel,
    @required this.onSync,
    Key key
  }) : super(key: key);

  final DistrictModel districtModel;
  final ValueChanged<DistrictModel> onSync;
  // -----------------------------------------------------------------------------
  @override
  _DistrictEditorBubbleState createState() => _DistrictEditorBubbleState();
// -----------------------------------------------------------------------------
}

class _DistrictEditorBubbleState extends State<DistrictEditorBubble> {
  // -----------------------------------------------------------------------------
  DistrictModel _draftDistrict;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _draftDistrict = widget.districtModel;

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {


        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// PHRASES

  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> _getNonUsedLangCodes(){
    final List<String> _existingLangCodes = Phrase.getLangCodes(_draftDistrict.phrases);
    final List<String> _langCodes = <String>[...Localizer.langCodes];
    for (final String _existing in _existingLangCodes) {
      _langCodes.remove(_existing);
    }
    return _langCodes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAddNewPhrase() async {

    final List<String> _possibleLangs = _getNonUsedLangCodes();

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: _possibleLangs.length,
        titleVerse: Verse.plain('Add new phrase'),
        builder: (_){

          return [

            ...List.generate(_possibleLangs.length, (index){

              return BottomDialog.wideButton(
                context: context,
                verse: Verse.plain(_possibleLangs[index]),
                verseCentered: true,
                onTap: () async {

                  final Phrase _phrase = Phrase(
                    langCode: _possibleLangs[index],
                    value: '',
                    id: _draftDistrict.id,
                  );

                  setState(() {
                    _draftDistrict = DistrictModel.replacePhraseInDistrictPhrases(
                      phrase: _phrase,
                      district: _draftDistrict,
                    );
                  });

                  await Nav.goBack(context: context);

                },
              );

            }),

          ];

        }
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = Bubble.clearWidth(context);

    final bool _identical = DistrictModel.checkDistrictsAreIdentical(_draftDistrict, widget.districtModel);

    return Bubble(
      bubbleHeaderVM: BubbleHeaderVM(
        headlineVerse: Verse.plain('Edit ${_draftDistrict?.id}'),
        leadingIcon: Iconz.reload,
        leadingIconSizeFactor: 0.7,
        leadingIconBoxColor: _identical == true ? Colorz.white10 : Colorz.yellow255,
      ),
      columnChildren: [

        /// PHRASES
        if (Mapper.checkCanLoopList(_draftDistrict?.phrases) == true)
          ...List.generate(_draftDistrict.phrases.length, (index){

            final Phrase _phrase = _draftDistrict.phrases[index];

            return TextFieldBubble(
              bubbleWidth: _clearWidth,
              bubbleHeaderVM: BubbleHeaderVM(
                  headlineVerse: Verse.plain('Name ( ${_phrase.langCode} )'),
                  leadingIcon: Iconz.xSmall,
                  leadingIconIsBubble: true,
                  leadingIconSizeFactor: 0.7,
                  onLeadingIconTap: () async {

                    final bool _go = await Dialogs.confirmProceed(
                      context: context,
                      titleVerse: Verse.plain('Delete name (${_phrase.langCode})'),
                    );

                    if (_go == true){
                      setState(() {
                        _draftDistrict = DistrictModel.removePhraseFromDistrictPhrases(
                          langCode: _phrase.langCode,
                          district: _draftDistrict,
                        );
                      });
                    }

                  }
              ),
              appBarType: AppBarType.basic,
              initialText: _phrase.value,
              onTextChanged: (String text){

                final Phrase _newPhrase = Phrase(
                  id: _phrase.id,
                  value: text,
                  langCode: _phrase.langCode,
                );

                setState(() {
                  _draftDistrict = DistrictModel.replacePhraseInDistrictPhrases(
                    phrase: _newPhrase,
                    district: _draftDistrict,
                  );
                });

              },
            );

          }),

        /// ADD NEW PHRASE
        DreamBox(
          height: 40,
          width: _clearWidth,
          margins: const EdgeInsets.only(bottom: 10),
          verse: Verse.plain('Add new Name with new Language'),
          verseCentered: false,
          verseItalic: true,
          verseWeight: VerseWeight.thin,
          icon: Iconz.plus,
          iconSizeFactor: 0.5,
          verseScaleFactor: 1.2,
          onTap: _onAddNewPhrase,
        ),

        /// SYNC
        DreamBox(
          isDeactivated: _identical,
          height: 40,
          width: _clearWidth,
          margins: const EdgeInsets.only(bottom: 10),
          verse: Verse.plain('Sync'),
          verseCentered: false,
          verseItalic: true,
          verseWeight: VerseWeight.thin,
          icon: Iconz.reload,
          iconSizeFactor: 0.5,
          verseScaleFactor: 1.2,
          onTap: () => widget.onSync(_draftDistrict),
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
