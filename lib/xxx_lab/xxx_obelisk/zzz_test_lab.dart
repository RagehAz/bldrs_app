import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/ops/zone_ops.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_generators.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/exotic_methods.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestLab extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const TestLab({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TestLabState createState() => _TestLabState();
}
/// --------------------------------------------------------------------------
class _TestLabState extends State<TestLab> with SingleTickerProviderStateMixin {

  ScrollController _scrollController;
  AnimationController _animationController;
  UiProvider _uiProvider;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _uiProvider = Provider.of<UiProvider>(context, listen: false);

    // works
    // Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz();

    // hack around
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<FlyersProvider>(context,listen: true).fetchAndSetBzz();
    // });

    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      // _triggerLoading().then((_) async {
      //   /// do Futures here
      //   unawaited(_triggerLoading(function: () {
      //     /// set new values here
      //   }));
      // });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


//   File _file;

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;

    // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      // loading: _loading,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        children: <Widget>[

          const Stratosphere(),

          /// DO SOMETHING
          WideButton(
              color: Colorz.red255,
              verse: 'DO THE DAMN THING',
              icon: Iconz.star,
              onTap: () async {

                _uiProvider.triggerLoading(setLoadingTo: true);

                // final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
                //
                // final List<CountryModel> _allCountries = <CountryModel>[];
                //
                // final CountryModel _egypt = await _zoneProvider.fetchCountryByID(
                //     context: context,
                //     countryID: 'egy',
                // );
                //
                // final CountryModel _sau = await _zoneProvider.fetchCountryByID(
                //     context: context,
                //     countryID: 'sau',
                // );
                //
                // _allCountries.add(_egypt);
                // _allCountries.add(_sau);
                //
                // int _count = 0;
                // for (final CountryModel country in _allCountries){
                //
                //   final List<String> citiesIDs = country.citiesIDs;
                //
                //   for (final String cityID in citiesIDs){
                //
                //     final CityModel _cityModel = await readCityOps(
                //         context: context,
                //         cityID: cityID
                //     );
                //
                //     final _enPhrase = Phrase.getPhraseByLangFromPhrases(
                //       phrases: _cityModel.phrases,
                //       langCode: 'en',
                //     );
                //
                //     final _arPhrase = Phrase.getPhraseByLangFromPhrases(
                //       phrases: _cityModel.phrases,
                //       langCode: 'ar',
                //     );
                //
                //     if (_enPhrase != null){
                //
                //       final Phrase _enPhraseAdjusted = Phrase(
                //         id: cityID,
                //         value: _enPhrase.value,
                //         trigram: createTrigram(input: _enPhrase.value),
                //       );
                //
                //       await createNamedSubDoc(
                //         context: context,
                //         collName: FireColl.translations,
                //         docName: 'en',
                //         subCollName: FireSubColl.translations_xx_cities,
                //         subDocName: cityID,
                //         input: _enPhraseAdjusted.toMap(addTrigram: true),
                //       );
                //
                //     }
                //
                //     if (_arPhrase != null){
                //
                //       final Phrase _arPhraseAdjusted = Phrase(
                //         id: cityID,
                //         value: _arPhrase.value,
                //         trigram: createTrigram(input: _arPhrase.value),
                //       );
                //
                //       await createNamedSubDoc(
                //         context: context,
                //         collName: FireColl.translations,
                //         docName: 'ar',
                //         subCollName: FireSubColl.translations_xx_cities,
                //         subDocName: cityID,
                //         input: _arPhraseAdjusted.toMap(addTrigram: true),
                //       );
                //
                //     }
                //
                //     blog('done with $_count cities');
                //     _count ++;
                //   }
                //
                // }

                _uiProvider.triggerLoading(setLoadingTo: false);

              }),


          /// MANIPULATE LOCAL ASSETS TESTING
          // GestureDetector(
          //   onTap: () async {
          //
          //     _triggerLoading();
          //
          //     File file = await Imagers.getFileFromLocalRasterAsset(
          //       context: context,
          //       width: 200,
          //       localAsset: Iconz.BldrsAppIcon,
          //     );
          //
          //     if (file != null){
          //       setState(() {
          //         _file = file;
          //       });
          //
          //     }
          //
          //     _triggerLoading();
          //   },
          //   child: Container(
          //     width: 100,
          //     height: 100,
          //     color: Colorz.facebook,
          //     alignment: Alignment.center,
          //     child: SuperImage(
          //       _file ?? Iconz.DumAuthorPic,
          //       width: 100,
          //       height: 100,
          //
          //     ),
          //   ),
          // ),

          /// PROMOTED FLYERS
          // Selector<FlyersProvider, List<FlyerModel>>(
          //   selector: (_, FlyersProvider flyersProvider) => flyersProvider.promotedFlyers,
          //   builder: (BuildContext ctx, List<FlyerModel> flyers, Widget child){
          //
          //     return
          //
          //         FlyersShelf(
          //           title: 'Promoted Flyers',
          //           titleIcon: Iconz.flyer,
          //           flyers: flyers,
          //           flyerOnTap: (FlyerModel flyer) => onFlyerTap(context: context, flyer: flyer),
          //           onScrollEnd: (){blog('REACHED SHELF END');},
          //         );
          //
          //   },
          // ),

          Container(
            width: _screenWidth,
            height: _screenHeight,
            color: Colorz.bloodTest,

          ),

        ],
      ),
    );
  }
}

// Future<void> createCountriesPhrases() async {
//
//   final Phrase _enPhrase = Phrase.getPhraseByLangFromPhrases(
//     phrases: country.phrases,
//     langCode: 'en',
//   );
//   final Phrase _arPhrase = Phrase.getPhraseByLangFromPhrases(
//     phrases: country.phrases,
//     langCode: 'ar',
//   );
//
//   final Phrase _enPhraseAdjusted = Phrase(
//     id: country.id,
//     value: _enPhrase.value,
//     trigram: createTrigram(input: _enPhrase.value),
//   );
//   final Phrase _arPhraseAdjusted = Phrase(
//     id: country.id,
//     value: _arPhrase.value,
//     trigram: createTrigram(input: _arPhrase.value),
//   );
//
//   await createNamedSubDoc(
//     context: context,
//     collName: FireColl.translations,
//     docName: 'en',
//     subCollName: FireSubColl.translations_xx_countries,
//     subDocName: country.id,
//     input: _enPhraseAdjusted.toMap(addTrigram: true),
//   );
//
//   await createNamedSubDoc(
//     context: context,
//     collName: FireColl.translations,
//     docName: 'ar',
//     subCollName: FireSubColl.translations_xx_countries,
//     subDocName: country.id,
//     input: _arPhraseAdjusted.toMap(addTrigram: true),
//   );
//
// }