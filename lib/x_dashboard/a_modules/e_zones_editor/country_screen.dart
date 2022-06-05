import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/tile_bubble.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class CountryEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountryEditorScreen({
    @required this.country,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final CountryModel country;
  /// --------------------------------------------------------------------------
  @override
  _CountryEditorScreenState createState() => _CountryEditorScreenState();

  /// --------------------------------------------------------------------------
}

class _CountryEditorScreenState extends State<CountryEditorScreen> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  /*
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzAuthorsPage',
    );
  }
   */
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initialize();
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

    final String _countryName = CountryModel.getTranslatedCountryName(
      context: context,
      countryID: widget.country.id,
    );
    final String _countryFlag = Flag.getFlagIconByCountryID(widget.country.id);

    final double _appBarWidth = BldrsAppBar.width(context);

    return MainLayout(
      skyType: SkyType.black,
      pyramidsAreOn: true,
      // pageTitle: _countryName,
      loading: _loading,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarRowWidgets: [

        AppBarButton(
          verse: _countryName,
          icon: _countryFlag,
          bubble: false,
          buttonColor: Colorz.nothing,
        ),

        const Expander(),

        ValueListenableBuilder(
            valueListenable: _countryModel,
            builder: (_, CountryModel country, Widget child){

              final bool _areTheSame = CountryModel.countriesModelsAreTheSame(country, widget.country);

              return AppBarButton(
                verse: 'Update',
                buttonColor: _areTheSame == true ? Colorz.nothing : Colorz.yellow255,
                bubble: !_areTheSame,
                isDeactivated: _areTheSame,
                onTap: (){
                  blog('should update country');
                },
              );

            }
        ),

      ],
      layoutWidget: ValueListenableBuilder(
        valueListenable: _countryModel,
        builder: (_, CountryModel country, Widget child){

          final CurrencyModel _currencyModel = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
            currencies: ZoneProvider.proGetAllCurrencies(context),
            countryID: country.id,
          );

          return ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              const Stratosphere(),

              /// ID
              DataStrip(
                width: _appBarWidth,
                dataKey: 'ID',
                dataValue: country.id,
                color: Colorz.black255,
              ),

              /// REGION - CONTINENT
              DataStrip(
                width: _appBarWidth,
                dataKey: 'Region\nCont.',
                dataValue: '${country.region} - ${country.continent}',
                color: Colorz.black255,
              ),

              /// CURRENCY
              DataStrip(
                width: _appBarWidth,
                dataKey: 'Currency',
                dataValue: '${_currencyModel.symbol} : ${superPhrase(context, _currencyModel.id)}',
                color: Colorz.black255,
              ),

              /// LANGUAGE
              DataStrip(
                width: _appBarWidth,
                dataKey: 'Lang',
                dataValue: country.language,
                color: Colorz.black255,
              ),

              const BubblesSeparator(),

              /// ENGLISH NAME
              TextFieldBubble(
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

              const BubblesSeparator(),

              /// --- IS ACTIVATED
              TileBubble(
                verse: 'Country is Activated',
                secondLine: 'When Country is Deactivated, '
                    'only business authors may see it while creating business profile',
                icon: _countryFlag,
                iconBoxColor: Colorz.grey50,
                iconSizeFactor: 1,
                switchIsOn: country.isActivated,
                switching: (bool val) {
                  _countryModel.value = _countryModel.value.copyWith(
                    isActivated: val,
                  );
                },
              ),

              /// --- IS GLOBAL
              TileBubble(
                verse: 'Country is Global ?',
                secondLine:
                'When Country is not Global, only users of this country will see its businesses and flyers',
                icon: _countryFlag,
                iconBoxColor: Colorz.grey50,
                iconSizeFactor: 1,
                switchIsOn: country.isGlobal,
                switching: (bool val) {
                  _countryModel.value = _countryModel.value.copyWith(
                    isGlobal: val,
                  );
                  },
              ),

              const BubblesSeparator(),

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
