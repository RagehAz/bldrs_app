import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/tile_bubble.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class CountryEditorPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountryEditorPage({
    @required this.country,
    @required this.screenHeight,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final CountryModel country;
  final double screenHeight;
  /// --------------------------------------------------------------------------
  @override
  _CountryEditorPageState createState() => _CountryEditorPageState();

  /// --------------------------------------------------------------------------
}

class _CountryEditorPageState extends State<CountryEditorPage> {
// -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'CountryEditorScreen',);
    }
  }
   */
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initialize();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _enNameController.dispose();
    _arNameController.dispose();
    _countryModel.dispose();
    super.dispose();
  }
// ---------------------------------------------------------------------------
  TextEditingController _enNameController;
  TextEditingController _arNameController;
  ValueNotifier<CountryModel> _countryModel;
  Phrase _oldEnPhrase;
  Phrase _oldArPhrase;
  void _initialize(){

    _oldEnPhrase = Phrase.getPhraseByLangFromPhrases(
      phrases: widget.country.phrases,
      langCode: 'en',
    );
    _enNameController = TextEditingController(text: _oldEnPhrase?.value);

    _oldArPhrase = Phrase.getPhraseByLangFromPhrases(
      phrases: widget.country.phrases,
      langCode: 'ar',
    );
    _arNameController = TextEditingController(text: _oldArPhrase?.value);

    _countryModel = ValueNotifier(widget.country);
  }
// ---------------------------------------------------------------------------
  /*
  Future<void> _updateCountryFieldOnFirestore(
      String _field, dynamic _input) async {
    unawaited(_triggerLoading());

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    /// TASK : update country field method
    // await Fire.updateDocField(
    //   context: context,
    //   collName: FireColl.zones,
    //   docName: widget.country.id,
    //   field: _field,
    //   input: _input,
    // );

    unawaited(_triggerLoading());
  }
*/
// ---------------------------------------------------------------------------
  List<Phrase> updatePhrases({
    @required String langCode,
    @required String text,
  }){

    final Phrase _phrase = Phrase.getPhraseByLangFromPhrases(
      phrases: _countryModel.value.phrases,
      langCode: langCode,
    );

    final Phrase _updated = _phrase.copyWith(
      value: text,
    );

    final List<Phrase> _phrases = <Phrase>[..._countryModel.value.phrases];
    _phrases.removeWhere((ph) => ph.langCode == langCode);
    _phrases.add(_updated);

    return _phrases;
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final List<String> _citiesNames = <String>[];
    // CityModel.getCitiesNamesFromCountryModelByCurrentLingo(
    //   context: context,
    //   country: widget.country,
    // );

    // final String _countryName = CountryModel.getTranslatedCountryName(
    //   context: context,
    //   countryID: widget.country.id,
    // );
    final String _countryFlag = Flag.getFlagIcon(widget.country.id);
    final double _clearWidth = PageBubble.clearWidth(context);

    return PageBubble(
      screenHeightWithoutSafeArea: widget.screenHeight,
      appBarType: AppBarType.basic,
      child: ValueListenableBuilder(
        valueListenable: _countryModel,
        builder: (_, CountryModel country, Widget child){

          final CurrencyModel _currencyModel = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
            currencies: ZoneProvider.proGetAllCurrencies(context),
            countryID: country.id,
          );

          return ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// ID
              DataStrip(
                width: _clearWidth,
                dataKey: 'ID',
                dataValue: country.id,
              ),

              /// REGION - CONTINENT
              DataStrip(
                width: _clearWidth,
                dataKey: 'Region\nCont.',
                dataValue: '${country.region} - ${country.continent}',
              ),

              /// CURRENCY
              DataStrip(
                width: _clearWidth,
                dataKey: 'Currency',
                dataValue: '${_currencyModel.symbol} : ${xPhrase(context, _currencyModel.id)}',
              ),

              /// LANGUAGE
              DataStrip(
                width: _clearWidth,
                dataKey: 'Lang',
                dataValue: country.language,
              ),

              const DotSeparator(),

              /// ENGLISH NAME
              TextFieldBubble(
                bubbleWidth: _clearWidth,
                title: 'English Name',
                textController: _enNameController,
                textOnChanged: (String text){

                  _countryModel.value = _countryModel.value.copyWith(
                    phrases: updatePhrases(
                        langCode: 'en',
                        text: text
                    ),
                  );

                  },
              ),

              /// ARABIC NAME
              TextFieldBubble(
                bubbleWidth: _clearWidth,
                title: 'Arabic Name',
                textController: _arNameController,
                textOnChanged: (String text){

                  _countryModel.value = _countryModel.value.copyWith(
                    phrases: updatePhrases(
                        langCode: 'ar',
                        text: text
                    ),
                  );

                  },
              ),

              const DotSeparator(),

              /// --- IS ACTIVATED
              TileBubble(
                bubbleWidth: _clearWidth,
                bubbleHeaderVM: BubbleHeaderVM(
                  leadingIcon: _countryFlag,
                  leadingIconIsBubble: true,
                  leadingIconBoxColor: Colorz.grey50,
                  headline: 'Country is Activated',
                  hasSwitch: true,
                  hasMoreButton: true,
                  onSwitchTap: (bool val) {
                    _countryModel.value = _countryModel.value.copyWith(
                      isActivated: val,
                    );
                  },
                  switchIsOn: country.isActivated,

                ),
                secondLine: 'When Country is Deactivated, '
                    'only business authors may see it while creating business profile',
              ),

              /// --- IS GLOBAL
              TileBubble(
                bubbleWidth: _clearWidth,
                bubbleHeaderVM: BubbleHeaderVM(
                  headline: 'Country is Global ?',
                  leadingIcon: _countryFlag,
                  leadingIconBoxColor: Colorz.grey50,
                  hasSwitch: true,
                  onSwitchTap: (bool val) {
                    _countryModel.value = _countryModel.value.copyWith(
                      isGlobal: val,
                    );
                  },
                  switchIsOn: country.isGlobal,
                ),
                secondLine: 'When Country is not Global, only users of this country will see its businesses and flyers',
              ),

              const DotSeparator(),

              // KeywordsBubble(
              //   title: '${_citiesNames.length} Provinces',
              //   keywordsIDs: CityModel.getCitiesIDsFromCities(cities: _cities),
              //   onTap: () {
              //     blog('bubble tapped');
              //   },
              //   onKeywordTap: (String keywordID) {
              //     blog('tapping on city ID is $keywordID');
              //   },
              //   selectedWords: const <dynamic>[],
              //   addButtonIsOn: false,
              // ),

              const Horizon(),
            ],
          );

          },
      ),
    );

  }

}
