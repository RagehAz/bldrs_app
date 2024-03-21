import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/colors/colorizer.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/price_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class GtaModel {
  // -----------------------------------------------------------------------------
  const GtaModel({
    required this.id,
    required this.url,
    required this.title,
    required this.images,
    required this.brand,
    required this.stars,
    required this.rating,
    required this.price,
    required this.oldPrice,
    required this.currency,
    required this.about,
    required this.affiliateLink,
    required this.countryID,
  });
  // -----------------------------------------------------------------------------
  final String? id;
  final String? url;
  final String? title;
  final List<String>? images;
  final String? brand;
  final double? stars;
  final int? rating;
  final double? price;
  final double? oldPrice;
  final String? currency;
  final String? about;
  final String? affiliateLink;
  final String? countryID;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  GtaModel copyWith({
    String? id,
    String? url,
    String? title,
    List<String>? images,
    String? brand,
    double? stars,
    int? rating,
    double? price,
    double? oldPrice,
    String? currency,
    String? about,
    String? description,
    String? info,
    String? affiliateLink,
    String? countryID,
  }){

    return GtaModel(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      images: images ?? this.images,
      brand: brand ?? this.brand,
      stars: stars ?? this.stars,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      currency: currency ?? this.currency,
      about: about ?? this.about,
      affiliateLink: affiliateLink ?? this.affiliateLink,
      countryID: countryID ?? this.countryID,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipherMap({
    required GtaModel? gtaModel,
  }){
    Map<String, dynamic>? _output;

    if (gtaModel != null){

      _output = {
        'id': gtaModel.id,
        'url': gtaModel.url,
        'title': gtaModel.title,
        'images': gtaModel.images,
        'brand': gtaModel.brand,
        'stars': gtaModel.stars,
        'rating': gtaModel.rating,
        'price': gtaModel.price,
        'oldPrice': gtaModel.oldPrice,
        'currency': gtaModel.currency,
        'about': gtaModel.about,
        'affiliateLink': gtaModel.affiliateLink,
        'countryID': gtaModel.countryID,
      };

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static GtaModel? decipherMap({
    required Map<String, dynamic>? map,
  }){
    GtaModel? _output;

    if (map != null){
      _output = GtaModel(
        id: map['id'],
        url: map['url'],
        title: map['title'],
        images: Stringer.getStringsFromDynamics(map['images']),
        brand: map['brand'],
        stars: map['stars'],
        rating: map['rating'],
        price: Numeric.transformStringToDouble('${map['price']}'),
        oldPrice: Numeric.transformStringToDouble('${map['oldPrice']}'),
        currency: map['currency'],
        about: map['about'],
        affiliateLink: map['affiliateLink'],
        countryID: map['countryID'],
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherMaps({
    required List<GtaModel>? gtaModels,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (Lister.checkCanLoop(gtaModels) == true){

      for (final GtaModel model in gtaModels!){

        final Map<String, dynamic>? _map = cipherMap(gtaModel: model);
        if (_map != null){
          _output.add(_map);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<GtaModel> decipherMaps({
    required List<Map<String, dynamic>>? maps,
  }){
    final List<GtaModel> _output = [];

    if (Lister.checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final GtaModel? _gtaModel = decipherMap(map: map);
        if (_gtaModel != null){
          _output.add(_gtaModel);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherToRealMap({
    required List<GtaModel> gtas,
  }){
    Map<String, dynamic> _output = {};

    if (Lister.checkCanLoop(gtas) == true){

      for (int i = 0; i < gtas.length; i++){

        final GtaModel _gta = gtas[i];

        _output = Mapper.insertPairInMap(
            map: _output,
            key: _gta.id,
            overrideExisting: true,
            value: cipherMap(gtaModel: _gta),
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<GtaModel> decipherFromRealMap({
    required Map<String, dynamic>? map,
  }){
    final List<GtaModel> _output = [];

    if (map != null){

      List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){

        _keys = Stringer.sortAlphabetically(_keys);
        _keys.remove('id');

        for (final String key in _keys){

          Map<String, dynamic>? _map = map[key];

          if (_map != null){

            _map = Mapper.insertPairInMap(
              map: _map,
              key: 'id',
              value: key,
              overrideExisting: true,
            );

            final GtaModel? _gta = decipherMap(
              map: _map,
            );

            if (_gta != null){
              _output.add(_gta);
            }

          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static GtaModel? createGtaModelByUrl({
    required String? url,
    required String countryID,
  }){
    GtaModel? _output;

    if (url != null){
      _output = GtaModel(
        id: Numeric.createUniqueID().toString(),
        url: url,
        title: null,
        images: null,
        brand: null,
        stars: null,
        rating: null,
        price: null,
        oldPrice: null,
        currency: null,
        about: null,
        affiliateLink: null,
        countryID: countryID,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<DraftFlyer?> createDraftFlyerByGtaProduct({
    required BuildContext context,
    required GtaModel? gtaModel,
    required BzModel? bzModel,
    required FlyerType flyerType,
    List<String> phids =  const [],
  }) async {
    DraftFlyer? _output;

    if (gtaModel != null) {

      // final List<SpecModel> _specs = _createPriceSpecs(
      //   gtaModel: gtaModel,
      // );

      final List<DraftSlide> _draftSlides = await createDraftSlidesByGtaProduct(
          product: gtaModel,
        );

      final ZoneModel? _zone = await _getGtaFlyerZone(
        bzModel: bzModel,
        gtaModel: gtaModel,
      );

      _output = DraftFlyer(
        bzModel: bzModel,
        id: DraftFlyer.newDraftID,
        headline: TextEditingController(text: gtaModel.title),
        trigram: Stringer.createTrigram(input: gtaModel.title),
        headlineNode: FocusNode(),
        description: TextEditingController(text: gtaModel.about),
        descriptionNode: FocusNode(),
        flyerType: flyerType,
        publishState: PublishState.draft,
        phids: phids,
        showsAuthor: false,
        zone: _zone,
        authorID: Authing.getUserID(),
        bzID: bzModel?.id,
        position: null,
        draftSlides: _draftSlides,
        // specs: _specs,
        times: <PublishTime>[
          PublishTime(
            state: PublishState.draft,
            time: DateTime.now(),
          ),
        ],
        hasPriceTag: gtaModel.price != null,
        hasPDF: false,
        isAmazonFlyer: isAmazonAffiliateLink(gtaModel.affiliateLink),
        score: 0,
        pdfModel: null,
        canPickImage: true,
        formKey: GlobalKey<FormState>(),
        firstTimer: false,
        poster: null,
        affiliateLink: gtaModel.affiliateLink,
        gtaLink: gtaModel.url,
        price: gtaModel.price == null ? null : PriceModel(
          current: gtaModel.price!,
          old: gtaModel.oldPrice,
          currencyID: gtaModel.currency ?? CurrencyModel.usaCurrencyID,
        ),
      );

      // final PicModel? _poster = await BldrsPicMaker.createFlyerPoster(
      //   context: context,
      //   draftFlyer: _output,
      //   controller: ScreenshotController() // this should reside in statuful widget,, takle care,
      // );

      // _output = _output.copyWith(
      //   poster: _poster,
      // );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> _getGtaFlyerZone({
    required BzModel? bzModel,
    required GtaModel gtaModel,
}) async {
    ZoneModel? _output = bzModel?.zone;

    if (bzModel?.zone?.countryID != gtaModel.countryID){

      // final String _langCode = Localizer.getCurrentLangCode();
      //
      // final String? _bzCountry = CountryModel.translateCountry(
      //   langCode: _langCode,
      //   countryID: bzModel?.zone?.countryID,
      // );
      //
      // final String? _gtaCountry = CountryModel.translateCountry(
      //   langCode: Localizer.getCurrentLangCode(),
      //   countryID: gtaModel.countryID,
      // );
      //
      // await Dialogs.topNotice(
      //   verse: Verse.plain('Bz account is ( $_bzCountry ) but product is ( $_gtaCountry )'),
      //   // take care
      //   body: Verse.plain('This will override the flyer zone, and will use the product country instead'),
      // );

      if (gtaModel.countryID != null){
        _output = ZoneModel(countryID: gtaModel.countryID!);
      }

    }

    return _output;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static List<SpecModel> _createPriceSpecs({
    required GtaModel? gtaModel,
  }){

    if (gtaModel == null){
      return [];
    }
    else {

      final List<SpecModel> _specs = <SpecModel>[
        if (gtaModel.price != null && gtaModel.currency != null)
          SpecModel(
            pickerChainID: 'phid_s_salePrice',
            value: gtaModel.price,
          ),
        if (gtaModel.price != null && gtaModel.currency != null)
          SpecModel(
            pickerChainID: 'phid_s_currency',
            value: gtaModel.currency,
          ),
      ];

      return _specs;
    }

  }
   */
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<DraftSlide>> createDraftSlidesByGtaProduct({
    required GtaModel? product,
  }) async {
    final List<DraftSlide> _output = [];

    if (product != null && Lister.checkCanLoop(product.images) == true){

      for (int i = 0; i < product.images!.length; i++){

        final String _url = product.images![i];

        if (ObjectCheck.isAbsoluteURL(_url) == true) {

          final MediaModel? _bigPic = await createPicModelByGtaUrl(
            url: _url,
            picName: '${i}_${product.affiliateLink}',
            type: SlidePicType.big,
          );
          final MediaModel? _medPic = await SlidePicMaker.compressSlideBigPicTo(
              slidePic: _bigPic,
              flyerID: DraftFlyer.newDraftID,
              slideIndex: i,
              type: SlidePicType.med,
          );
          final MediaModel? _smallPic = await SlidePicMaker.compressSlideBigPicTo(
              slidePic: _bigPic,
              flyerID: DraftFlyer.newDraftID,
              slideIndex: i,
              type: SlidePicType.small,
          );
          final MediaModel? _backPic = await SlidePicMaker.createSlideBackground(
            bigPic: _bigPic,
            flyerID: DraftFlyer.newDraftID,
            slideIndex: i,
            overrideSolidColor: null,
          );

          if (_bigPic != null && _medPic != null && _smallPic != null && _backPic != null) {

            final DraftSlide _draft = DraftSlide(
              flyerID: DraftFlyer.newDraftID,
              slideIndex: i,
              bigPic: _bigPic,
              medPic: _medPic,
              smallPic: _smallPic,
              backPic: _backPic,
              headline: i == 0 ? product.title : null,
              description: null,
              midColor: await Colorizer.getAverageColorFromXFile(_bigPic.file),
              backColor: null,
              opacity: 1,
              matrix: Matrix4.identity(),
              matrixFrom: Matrix4.identity(),
              animationCurve: null,
            );

            _output.add(_draft);

          }

        }

      }
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> createPicModelByGtaUrl({
    required String? picName,
    required String? url,
    required SlidePicType type,
  }) async {
    MediaModel? _output;

    final String? _userID = Authing.getUserID();

    if (_userID != null && ObjectCheck.isAbsoluteURL(url) == true) {

        _output = await MediaModelCreator.fromURL(
          url: url,
          // uploadPath: null,
          ownersIDs: [_userID],
          fileName: picName,
        );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SCRAPING

  // --------------------
  /// TESTED : WORKS PERFECT
  static GtaModel? createGtaModelScrappedMap({
    required String? url,
    required Map<String, dynamic>? map,
    required String countryID,
  }){
    GtaModel? _output;

    if (map != null){

      // Mapper.blogMap(map, invoker: 'createGtaModelScrappedMap');

      _output = GtaModel(
        id: Numeric.createUniqueID().toString(),
        url: url,
        title: map['title'],
        images: Stringer.getStringsFromDynamics(map['images']),
        brand: map['brand'],
        stars: _getStarsFromScrappedString(map['stars']),
        rating: _getRatingsFromScrappedString(map['rating']),
        price: getPriceFromScrappedString(map['price']),
        oldPrice: getPriceFromScrappedString(map['oldPrice']),
        currency: _getCurrencyFromScrappedString(map['price']),
        about: _fixAboutItemString(map['about']),
        affiliateLink: map['affiliateLink'],
        countryID: countryID,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? _getStarsFromScrappedString(String? starsString){
    double? _output;
    /// comes in this form  : 4.8 out of 5 stars

    if (TextCheck.isEmpty(starsString) == false){

      // (4.8 )
      String? _string = TextMod.removeTextAfterFirstSpecialCharacter(
          text: starsString!.trim(),
          specialCharacter: 'out',
      );
      _string = _string?.trim();
      // blog('_getStarsFromScrappedString : _string : $_string');
      _output = Numeric.transformStringToDouble(_string);
    }

    // blog('_getStarsFromScrappedString : output : $_output');
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int? _getRatingsFromScrappedString(String? ratingsCountString){
    int? _output;

    // comes in this form : '6,891 ratings'
    if (TextCheck.isEmpty(ratingsCountString) == false){
      String? _string = TextMod.removeTextAfterFirstSpecialCharacter(
          text: ratingsCountString!.trim(),
          specialCharacter: 'ratings',
      );
      _string = _string?.replaceAll(',', '');
      _output = Numeric.transformStringToInt(_string?.trim());
    }

    return _output;
  }
  // --------------------
  /// ( AMAZON_COUNTRY_DATA ) : TESTED : WORKS PERFECT
  static double? getPriceFromScrappedString(String? priceString){
    double? _output;

    // might come in this form : '$179.99'
    if (TextCheck.isEmpty(priceString) == false){

      /// USD
      if (TextCheck.stringContainsSubString(string: priceString, subString: r'$') == true){

        String? _value = TextMod.removeTextBeforeFirstSpecialCharacter(
           text: priceString?.trim(),
           specialCharacter: r'$',
       );

       _value = fixAmazonNumber(_value);

        _output = Numeric.transformStringToDouble(_value);
      }

      /// AED
      if (TextCheck.stringStartsExactlyWith(text: priceString, startsWith: 'AED') == true){

        /// AED1,785.00 -> 1,785.00
        String? _value = TextMod.removeNumberOfCharactersFromBeginningOfAString(
            string: priceString,
            numberOfCharacters: 3,
        );

        /// 1,785.00 -> 1785.00
        _value = fixAmazonNumber(_value);

        _output = Numeric.transformStringToDouble(_value);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? fixAmazonNumber(String? text){
    /// 1,785.00
    String? _output;

    if (TextCheck.isEmpty(text) == false){

      _output = text;

      _output = TextMod.replaceAllCharacters(
        input: _output,
        characterToReplace: ',',
        replacement: '',
      );
      _output = TextMod.replaceAllCharacters(
        input: _output,
        characterToReplace: ' ',
        replacement: '',
      );
      _output = TextMod.replaceAllCharacters(
        input: _output,
        characterToReplace: "'",
        replacement: '',
      );

    }

    return _output;
  }
  // --------------------
  /// ( AMAZON_COUNTRY_DATA ) : TESTED : WORKS PERFECT
  static String? _getCurrencyFromScrappedString(String? priceString){
    String? _output;

    if (TextCheck.isEmpty(priceString) == false){

      /// USD : $179.99
      if (TextCheck.stringContainsSubString(string: priceString, subString: r'$') == true){
        _output = 'currency_USD';
      }

      /// AED : AED620.00
      if (TextCheck.stringStartsExactlyWith(text: priceString, startsWith: 'AED') == true){
        _output = 'currency_AED';
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _fixAboutItemString(String? aboutItemString){
    String? _output;

    if (TextCheck.isEmpty(aboutItemString) == false){

      final pattern = RegExp(r'About this item\n'); // Define the pattern to match

      // Replace the pattern with an empty string
      _output = aboutItemString?.replaceAll(pattern, '');

      _output = TextMod.replaceAllCharacters(
          input: _output,
          characterToReplace: '\n',
          replacement: '\n\n',
      );

      _output = TextMod.replaceAllCharacters(
          input: _output,
          characterToReplace: '. ',
          replacement: '\n\n',
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getUrls({
    required List<GtaModel>? gtaModels,
  }){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(gtaModels) == true){
      for (final GtaModel model in gtaModels!){
        if (model.url != null){
          _output.add(model.url!);
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static GtaModel? getGtaByUrl({
    required List<GtaModel> gtas,
    required String? url,
  }){
    GtaModel? _output;

    if (url != null && Lister.checkCanLoop(gtas) == true){

      for (final GtaModel gta in gtas){

        if (gta.url == url){
          _output = gta;
          break;
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkGtaModelsIncludeURL({
    required List<GtaModel> products,
    required String url,
  }){
    bool _output = false;

    if (Lister.checkCanLoop(products) == true && TextCheck.isEmpty(url) == false){
      for (final GtaModel product in products){
        if (product.url == url){
          _output = true;
          break;
        }
      }
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static bool isAmazonAffiliateLink(String? affiliateLink){

    /// AFFILIATE LINK LOOKS LIKE THIS
    /// https://amzn.to/42LyU3E

    if (TextCheck.isEmpty(affiliateLink) == true){
      return false;
    }
    else {
      const String affiliateDomain = 'amzn.to';

      final Uri uri = Uri.parse(affiliateLink!);

      if (uri.host == affiliateDomain) {
        return true;
      }

      else {
        return false;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<GtaModel> insertModelInModels({
    required List<GtaModel>? products,
    required GtaModel? product,
  }){
    final List<GtaModel> _output = [...?products];

    if (product != null){

      final int _index = _output.indexWhere((element) => element.url == product.url);

      /// DOES NOT EXIST
      if (_index == -1){
        _output.add(product);
      }

      /// EXISTS
      else {
        _output.removeAt(_index);
        _output.insert(_index, product);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<GtaModel> removeModelFromModels({
    required List<GtaModel>? gtas,
    required String? url,
  }){
    final List<GtaModel> _output = [...?gtas];

    if (Lister.checkCanLoop(_output) == true){

      final int _index = _output.indexWhere((element) => element.url == url);

      if (_index != -1){
        _output.removeAt(_index);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<GtaModel> removePicFromModels({
    required List<GtaModel> models,
    required GtaModel? model,
    required String url,
  }){
    final List<GtaModel> _output = [...models];

    if (Lister.checkCanLoop(models) == true && model != null){

      final int _modelIndex = _output.indexWhere((element) => element.id == model.id);

      if (_modelIndex != -1){

        final List<String> _newImages = Stringer.removeStringsFromStrings(
          removeThis: [url],
          removeFrom: model.images,
        );

        final GtaModel _updatedModel = model.copyWith(
          images: _newImages,
        );

        _output.removeAt(_modelIndex);
        _output.insert(_modelIndex, _updatedModel);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogGta({
    required GtaModel gta,
    required String invoker,
  }){

    blog('GtaModel(');
    blog('  id: ${gta.id},');
    blog('  url: ${gta.url},');
    blog('  title: ${gta.title},');
    blog('  images: ${gta.images},');
    blog('  brand: ${gta.brand},');
    blog('  stars: ${gta.stars},');
    blog('  rating: ${gta.rating},');
    blog('  price: ${gta.price},');
    blog('  oldPrice: ${gta.oldPrice},');
    blog('  currency: ${gta.currency},');
    blog('  about: ${gta.about},');
    blog('  affiliateLink: ${gta.affiliateLink},');
    blog('  countryID: ${gta.countryID},');
    blog(')');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogGtas({
    required List<GtaModel>? gtas,
    required String invoker,
  }){

    if (Lister.checkCanLoop(gtas) == true){

      for (final GtaModel gta in gtas!){
        blogGta(gta: gta, invoker: invoker);
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkGtaModelsAreIdentical({
    required GtaModel? product1,
    required GtaModel? product2,
  }){
    bool _identical = false;

    if (product1 == null && product2 == null){
      _identical = true;
    }
    else if (product1 == null || product2 == null){
      _identical = false;
    }
    else {

      if (
      product1.id == product2.id &&
      product1.url == product2.url &&
      product1.title == product2.title &&
      Lister.checkListsAreIdentical(list1: product1.images, list2: product2.images) == true &&
      product1.brand == product2.brand &&
      product1.stars == product2.stars &&
      product1.rating == product2.rating &&
      product1.price == product2.price &&
      product1.oldPrice == product2.oldPrice &&
      product1.currency == product2.currency &&
      product1.about == product2.about &&
      product1.affiliateLink == product2.affiliateLink &&
      product1.countryID == product2.countryID
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() =>
       '''
       GtaModel(
          id: $id,
          url: $url,
          title: $title,
          images: $images,
          brand: $brand,
          stars: $stars,
          rating: $rating,
          price: $price,
          oldPrice: $oldPrice,
          currency: $currency,
          about: $about,
          affiliateLink: $affiliateLink,
          countryID: $countryID,
       )
      ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is GtaModel){
      _areIdentical = checkGtaModelsAreIdentical(
        product1: this,
        product2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      url.hashCode^
      title.hashCode^
      images.hashCode^
      brand.hashCode^
      stars.hashCode^
      rating.hashCode^
      price.hashCode^
      oldPrice.hashCode^
      currency.hashCode^
      about.hashCode^
      affiliateLink.hashCode^
      countryID.hashCode
      ;
  // -----------------------------------------------------------------------------
}
