import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/a_models/d_zone/zz_old/country_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class CountryEditorPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountryEditorPage({
    @required this.country,
    @required this.screenHeight,
    @required this.onCityTap,
    @required this.appBarType,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final double screenHeight;
  final Function onCityTap;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  _CountryEditorPageState createState() => _CountryEditorPageState();
  /// --------------------------------------------------------------------------
}

class _CountryEditorPageState extends State<CountryEditorPage> {
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  TextEditingController _enNameController;
  TextEditingController _arNameController;
  ValueNotifier<CountryModel> _countryModel;
  Phrase _oldEnPhrase;
  Phrase _oldArPhrase;
  // --------------------
  void _initialize(){

    _oldEnPhrase = Flag.getCountryPhrase(
      countryID: widget.country.id,
      langCode: 'en',
    );
    _enNameController = TextEditingController(text: _oldEnPhrase?.value);

    _oldArPhrase = Flag.getCountryPhrase(
      countryID: widget.country.id,
      langCode: 'ar',
    );
    _arNameController = TextEditingController(text: _oldArPhrase?.value);

    _countryModel = ValueNotifier(widget.country);
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initialize();
  }
  // --------------------
  @override
  void dispose() {
    // _loading.dispose();
    _enNameController.dispose();
    _arNameController.dispose();
    _countryModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
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
  // -----------------------------------------------------------------------------
  List<Phrase> updatePhrases({
    @required String langCode,
    @required String text,
  }){

    blog('you can not change country names : case closed');

    //
    // final Phrase _phrase = Phrase.searchFirstPhraseByLang(
    //   phrases: _countryModel.value.phrases,
    //   langCode: langCode,
    // );
    //
    // final Phrase _updated = _phrase.copyWith(
    //   value: text,
    // );
    //
    // final List<Phrase> _phrases = <Phrase>[..._countryModel.value.phrases];
    // _phrases.removeWhere((ph) => ph.langCode == langCode);
    // _phrases.add(_updated);

    return [];
  }
  // -----------------------------------------------------------------------------
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
    final String _countryFlag = Flag.getCountryIcon(widget.country.id);
    final double _clearWidth = PageBubble.clearWidth(context);

    return PageBubble(
      screenHeightWithoutSafeArea: widget.screenHeight,
      appBarType: AppBarType.basic,
      color: Colorz.black80,
      child: ValueListenableBuilder(
        valueListenable: _countryModel,
        builder: (_, CountryModel country, Widget child){

          final CurrencyModel _currencyModel = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
            currencies: ZoneProvider.proGetAllCurrencies(
              context: context,
              listen: true,
            ),
            countryID: country.id,
          );

          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: <Widget>[

              /// ID
              DataStrip(
                width: _clearWidth,
                dataKey: 'ID',
                dataValue: country.id,
              ),

              // /// REGION - CONTINENT
              // DataStrip(
              //   width: _clearWidth,
              //   dataKey: 'Region\nCont.',
              //   dataValue: '${country.region} - ${country.continent}',
              // ),

              /// CURRENCY
              DataStrip(
                width: _clearWidth,
                dataKey: 'Currency',
                dataValue: '${_currencyModel.symbol} : ${xPhrase( context, _currencyModel.id)}',
              ),

              // /// LANGUAGE
              // DataStrip(
              //   width: _clearWidth,
              //   dataKey: 'Lang',
              //   dataValue: country.language,
              // ),

              /// CITIES
              WideButton(
                width: PageBubble.clearWidth(context),
                verse: Verse.plain('View ZEROOOOOO EDIT ME Cities'),
                onTap: widget.onCityTap,
              ),

              const DotSeparator(),

              /// ENGLISH NAME
              TextFieldBubble(
                headerViewModel: BubbleHeaderVM(
                  headlineVerse: Verse.plain('English Name'),
                ),
                appBarType: widget.appBarType,
                bubbleWidth: _clearWidth,
                textController: _enNameController,
                onTextChanged: (String text){

                  // _countryModel.value = _countryModel.value.copyWith(
                  //   phrases: updatePhrases(
                  //       langCode: 'en',
                  //       text: text
                  //   ),
                  // );

                },
              ),

              /// ARABIC NAME
              TextFieldBubble(
                headerViewModel: BubbleHeaderVM(
                  headlineVerse: Verse.plain('Arabic Name'),
                ),
                appBarType: widget.appBarType,
                bubbleWidth: _clearWidth,
                textController: _arNameController,
                onTextChanged: (String text){

                  // _countryModel.value = _countryModel.value.copyWith(
                  //   phrases: updatePhrases(
                  //       langCode: 'ar',
                  //       text: text
                  //   ),
                  // );

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
                  headlineVerse: Verse.plain('Country is Activated'),
                  hasSwitch: true,
                  onSwitchTap: (bool val) {
                    // _countryModel.value = _countryModel.value.copyWith(
                    //   isActivated: val,
                    // );

                    blog('should trigger country activation to : $val');

                  },
                  // switchValue: false,

                ),
                secondLineVerse: Verse.plain('The Main Country Switch.. When Activated, '
                    'Users can see it and use it accordingly'
                    '\n When Deactivated, Bldrs.net is not switched on for that country'),
              ),

              /// --- IS GLOBAL
              TileBubble(
                bubbleWidth: _clearWidth,
                bubbleHeaderVM: BubbleHeaderVM(
                  headlineVerse: Verse.plain('Country is Global ?'),
                  leadingIcon: _countryFlag,
                  leadingIconBoxColor: Colorz.grey50,
                  hasSwitch: true,
                  onSwitchTap: (bool val) {
                    // _countryModel.value = _countryModel.value.copyWith(
                    //   isGlobal: val,
                    // );

                    blog('should trigger country global to : $val');

                  },
                  // switchValue: false,
                ),
                secondLineVerse: Verse.plain('Country is only Local by Default, '
                    'where only Users in this country can see themselves '
                    '...When Global, Anybody in the world can view this country'
                    '\nBoth businesses and users of other countries may be '
                    "able to browse this country's Flyers, Businesses & Questions if Country went Global"),
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
  // -----------------------------------------------------------------------------
}
