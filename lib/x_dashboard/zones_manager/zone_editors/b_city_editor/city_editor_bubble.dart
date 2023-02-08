import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:stringer/stringer.dart';

class CityEditorBubble extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const CityEditorBubble({
    @required this.cityModel,
    @required this.onSync,
    Key key
  }) : super(key: key);

  final CityModel cityModel;
  final ValueChanged<CityModel> onSync;
  // -----------------------------------------------------------------------------
  @override
  _CityEditorBubbleState createState() => _CityEditorBubbleState();
  // -----------------------------------------------------------------------------
}

class _CityEditorBubbleState extends State<CityEditorBubble> {
  // -----------------------------------------------------------------------------
  CityModel _draftCity;
  final TextEditingController _populationController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
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

    _draftCity = widget.cityModel;
    _populationController.text = _draftCity?.population?.toString();
    _initializePositionControllers();

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
    _populationController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// PHRASES

  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> _getNonUsedLangCodes(){
    final List<String> _existingLangCodes = Phrase.getLangCodes(_draftCity.phrases);
    final List<String> _langCodes = <String>[...BldrsThemeLangs.langCodes];
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
                  id: _draftCity.cityID,
                );

                setState(() {
                  _draftCity = CityModel.replacePhraseInCityPhrases(
                    phrase: _phrase,
                    city: _draftCity,
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

  /// POPULATION

  // --------------------
  /// TESTED : WORKS PERFECT
  void _onChangePopulation(String text){

    final String _text = text.trim();

    final int _num = Numeric.transformStringToInt(_text);

    setState(() {
      _draftCity = _draftCity.copyWith(
        population: _text == '' || _text == null ? 0 : _num,
      );
    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onClearPopulation(){
    _populationController.clear();
    setState(() {
      _draftCity = _draftCity.copyWith(
        population: 0,
      );
    });
  }
  // -----------------------------------------------------------------------------

  /// POSITION

  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializePositionControllers(){

    if (widget.cityModel?.position != null){
      _latController.text = _draftCity.position?.latitude?.toString();
      _lngController.text = _draftCity.position?.longitude?.toString();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onChangeLNG(String text){

    final double _newLng = Numeric.transformStringToDouble(text);

    if (Atlas.checkCoordinateIsGood(_newLng) == true){
      final GeoPoint _point = GeoPoint(_draftCity.position?.latitude ?? 0, _newLng ?? 0);
      _onChangePosition(_point);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onChangeLAT(String text){

    final double _newLat = Numeric.transformStringToDouble(text);

    if (Atlas.checkCoordinateIsGood(_newLat) == true){
      final GeoPoint _point = GeoPoint(_newLat ?? 0, _draftCity.position?.longitude ?? 0);
      _onChangePosition(_point);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onChangePosition(GeoPoint point){

    // _latController.text = point.latitude.toString();
    // _lngController.text = point.longitude.toString();

    setState(() {
      _draftCity = _draftCity.copyWith(
        position: point,
      );
    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onClearLAT(){
    _latController.clear();
    final GeoPoint _point = GeoPoint(0, _draftCity.position?.longitude ?? 0);
    _onChangePosition(_point);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onClearLNG(){
    _lngController.clear();
    final GeoPoint _point = GeoPoint(_draftCity.position?.latitude ?? 0, 0);
    _onChangePosition(_point);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = Bubble.clearWidth(context);
    final double _halfWidth = (_clearWidth - 10) / 2;

    final bool _identical = CityModel.checkCitiesAreIdentical(_draftCity, widget.cityModel);

    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        headlineVerse: Verse.plain('Edit ${_draftCity.cityID}'),
        leadingIcon: Iconz.reload,
        leadingIconSizeFactor: 0.7,
        leadingIconBoxColor: _identical == true ? Colorz.white10 : Colorz.yellow255,
      ),
      columnChildren: [

        /// PHRASES
        if (Mapper.checkCanLoopList(_draftCity.phrases) == true)
        ...List.generate(_draftCity.phrases.length, (index){

          final Phrase _phrase = _draftCity.phrases[index];

          return TextFieldBubble(
            bubbleWidth: _clearWidth,
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
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
                    _draftCity = CityModel.removePhraseFromCityPhrases(
                      langCode: _phrase.langCode,
                      city: _draftCity,
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
                _draftCity = CityModel.replacePhraseInCityPhrases(
                  phrase: _newPhrase,
                  city: _draftCity,
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

        /// POPULATION
        TextFieldBubble(
          bubbleWidth: _clearWidth,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              headlineVerse: Verse.plain('Population'),
              leadingIcon: Iconz.users,
              leadingIconIsBubble: true,
              leadingIconSizeFactor: 0.7,
            onLeadingIconTap: _onClearPopulation,
          ),
          appBarType: AppBarType.basic,
          textController: _populationController,
          keyboardTextInputType: TextInputType.number,
          pasteFunction: () async {

            final String _text = await TextClipBoard.paste();
            _populationController.text = _text;
            // _text = TextMod.fixSearchText(_text);
            // _text = TextMod.fixCountryName(_text);
            // _text = TextMod.fixArabicText(_text);
            _onChangePopulation(_text);

            // 46'80,4.4

          },
          validator: (String text) => Formers.numbersOnlyValidator(
            context: context,
            text: text,
          ),
          // autoValidate: true,
          onTextChanged: _onChangePopulation,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            /// LAT
            TextFieldBubble(
              bubbleWidth: _halfWidth,
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                headlineVerse: Verse.plain('LAT'),
                leadingIcon: Iconz.locationPin,
                leadingIconIsBubble: true,
                leadingIconSizeFactor: 0.7,
                onLeadingIconTap: _onClearLAT,
              ),
              appBarType: AppBarType.basic,
              textController: _latController,
              keyboardTextInputType: TextInputType.number,
              pasteFunction: () async {
                final String _text = await TextClipBoard.paste();
                _latController.text = _text;
                _onChangeLAT(_text);
                // 46'80,4.4
              },
              validator: (String text) => Formers.positionValidator(
                context: context,
                latOrLng: text,
              ),
              // autoValidate: true,
              onTextChanged: _onChangeLAT,
            ),

            /// LNG
            TextFieldBubble(
              bubbleWidth: _halfWidth,
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                headlineVerse: Verse.plain('LNG'),
                leadingIcon: Iconz.locationPin,
                leadingIconIsBubble: true,
                leadingIconSizeFactor: 0.7,
                onLeadingIconTap: _onClearLNG,
              ),
              appBarType: AppBarType.basic,
              textController: _lngController,
              keyboardTextInputType: TextInputType.number,
              pasteFunction: () async {

                final String _text = await TextClipBoard.paste();
                _lngController.text = _text;
                _onChangeLNG(_text);

                // 46'80,4.4

              },
              validator: (String text) => Formers.positionValidator(
                context: context,
                latOrLng: text,
              ),
              // autoValidate: true,
              onTextChanged: _onChangeLNG,
            ),

          ],
        ),

        /// SYNC
        DreamBox(
          isDisabled: _identical,
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
          onTap: () => widget.onSync(_draftCity),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
