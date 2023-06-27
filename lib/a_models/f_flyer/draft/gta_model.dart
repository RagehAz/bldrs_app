import 'dart:typed_data';

import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:basics/helpers/classes/files/file_size_unit.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:fire/super_fire.dart';
import 'package:basics/helpers/classes/colors/colorizer.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:mediators/mediators.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:mediators/models/dimension_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/super_image/super_image.dart';
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
    required this.ratingsCount,
    required this.price,
    required this.currency,
    required this.about,
    required this.description,
    required this.importantInfo,
    required this.affiliateLink,
    /// required this.specifications,
    /// required this.productDetails,
    /// required this.badges,
});
  // -----------------------------------------------------------------------------
  final String id;
  final String url;
  final String title;
  final List<String> images;
  final String brand;
  final double stars;
  final int ratingsCount;
  final double price;
  final String currency;
  final String about;
  final String description;
  final String importantInfo;
  final String affiliateLink;
  /// final Map<String, dynamic> specifications;
  /// final Map<String, dynamic> productDetails;
  /// final Map<String, dynamic> badges;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  GtaModel copyWith({
    String id,
    String url,
    String title,
    List<String> images,
    String brand,
    double stars,
    int ratingsCount,
    double price,
    String currency,
    String about,
    String description,
    String importantInfo,
    String affiliateLink,
  }){

    return GtaModel(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      images: images ?? this.images,
      brand: brand ?? this.brand,
      stars: stars ?? this.stars,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      about: about ?? this.about,
      description: description ?? this.description,
      importantInfo: importantInfo ?? this.importantInfo,
      affiliateLink: affiliateLink ?? this.affiliateLink,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherMap({
    required GtaModel gtaModel,
  }){
    Map<String, dynamic> _output;

    if (gtaModel != null){

      _output = {
        'id': gtaModel.id,
        'url': gtaModel.url,
        'title': gtaModel.title,
        'images': gtaModel.images,
        'brand': gtaModel.brand,
        'stars': gtaModel.stars,
        'ratingsCount': gtaModel.ratingsCount,
        'price': gtaModel.price,
        'currency': gtaModel.currency,
        'about': gtaModel.about,
        'description': gtaModel.description,
        'importantInfo': gtaModel.importantInfo,
        'affiliateLink': gtaModel.affiliateLink,
      };

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static GtaModel decipherMap({
    required Map<String, dynamic> map,
  }){
    GtaModel _output;

    if (map != null){
      _output = GtaModel(
        id: map['id'],
        url: map['url'],
        title: map['title'],
        images: Stringer.getStringsFromDynamics(dynamics: map['images']),
        brand: map['brand'],
        stars: map['stars'],
        ratingsCount: map['ratingsCount'],
        price: map['price'],
        currency: map['currency'],
        about: map['about'],
        description: map['description'],
        importantInfo: map['importantInfo'],
        affiliateLink: map['affiliateLink'],
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherMaps({
    required List<GtaModel> gtaModels,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (Mapper.checkCanLoopList(gtaModels) == true){

      for (final GtaModel model in gtaModels){

        final Map<String, dynamic> _map = cipherMap(gtaModel: model);
        _output.add(_map);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<GtaModel> decipherMaps({
    required List<Map<String, dynamic>> maps,
  }){
    final List<GtaModel> _output = [];

    if (Mapper.checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){

        final GtaModel _gtaModel = decipherMap(map: map);
        _output.add(_gtaModel);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static GtaModel createGtaModelByUrl({
    required String url,
  }){
    GtaModel _output;

    if (url != null){
      _output = GtaModel(
        id: null,
        url: url,
        title: null,
        images: null,
        brand: null,
        stars: null,
        ratingsCount: null,
        price: null,
        currency: null,
        about: null,
        description: null,
        importantInfo: null,
        affiliateLink: null,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftFlyer> createDraftFlyerByGtaProduct({
    required GtaModel gtaModel,
    required BzModel bzModel,
    required FlyerType flyerType,
  }) async {
    DraftFlyer _output;

    if (gtaModel != null) {

      final List<SpecModel> _specs = _createPriceSpecs(
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
        auditState: AuditState.verified,
        phids: const <String>[],
        showsAuthor: false,
        zone: bzModel.zone,
        authorID: Authing.getUserID(),
        bzID: bzModel.id,
        position: null,
        draftSlides: await createDraftSlidesByGtaProduct(
          product: gtaModel,
        ),
        specs: _specs,
        times: <PublishTime>[
          PublishTime(
            state: PublishState.unpublished,
            time: DateTime.now(),
          ),
        ],
        hasPriceTag: Speccer.checkSpecsHavePrice(_specs),
        hasPDF: false,
        isAmazonFlyer: isAmazonAffiliateLink(gtaModel.affiliateLink),
        score: 0,
        pdfModel: null,
        canPickImage: true,
        formKey: GlobalKey<FormState>(),
        firstTimer: false,
        posterController: ScreenshotController(),
        affiliateLink: gtaModel.affiliateLink,
        gtaLink: gtaModel.url,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> _createPriceSpecs({
    required GtaModel gtaModel,
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DraftSlide>> createDraftSlidesByGtaProduct({
    required GtaModel product,
  }) async {
    final List<DraftSlide> _output = [];

    if (product != null && Mapper.checkCanLoopList(product.images) == true){

      for (int i = 0; i < product.images.length; i++){

        final String _url = product.images[i];

        if (ObjectCheck.isAbsoluteURL(_url) == true) {

          final PicModel _picModel = await createPicModelByGtaUrl(_url);

          if (_picModel != null) {

            final DraftSlide _draft = DraftSlide(
              flyerID: DraftFlyer.newDraftID,
              slideIndex: i,
              picModel: _picModel,
              picFit: BoxFit.fitWidth,
              headline: i == 0 ? product.title : null,
              description: null,
              midColor: await Colorizer.getAverageColor(_picModel.bytes),
              opacity: 1,
              matrix: Matrix4.identity(),
              animationCurve: null,
              filter: ImageFilterModel.noFilter(),
            );
            _output.add(_draft);

          }
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PicModel> createPicModelByGtaUrl(String url) async {
    PicModel _output;

    if (ObjectCheck.isAbsoluteURL(url) == true) {

      final Uint8List? _bytes = await Floaters.getUint8ListFromURL(url);

      if (_bytes != null && _bytes.isNotEmpty){

        final Dimensions? _dims = await Dimensions.superDimensions(_bytes);
        final double? _mega = Filers.calculateSize(_bytes.length, FileSizeUnit.megaByte);

        final StorageMetaModel _meta = StorageMetaModel(
          ownersIDs: <String>[Authing.getUserID()],
          name: url,
          height: _dims.height,
          width: _dims.width,
          sizeMB: _mega,
        );

        _output = PicModel(
        path: null,
        bytes: _bytes,
        meta: _meta,
      );

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SCRAPING

  // --------------------
  /// TESTED : WORKS PERFECT
  static GtaModel createGtaModelScrappedMap({
    required String url,
    required Map<String, dynamic> map,
  }){
    GtaModel _output;

    if (map != null){
      _output = GtaModel(
        id: null,
        url: url,
        title: map['title'],
        images: Stringer.getStringsFromDynamics(dynamics: map['imageList']),
        brand: map['brand'],
        stars: _getStarsFromScrappedString(map['stars']),
        ratingsCount: _getRatingsFromScrappedString(map['ratings']),
        price: _getPriceFromScrappedString(map['price']),
        currency: _getCurrencyFromScrappedString(map['price']),
        about: _fixAboutItemString(map['about']),
        description: map['description'],
        importantInfo: map['importantInfo'],
        affiliateLink: map['affiliateLink'],
        // productDetails: null,
        // specifications: null,
        // badges: null,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getStarsFromScrappedString(String starsString){
    double _output;
    /// comes in this form  : 4.8 out of 5 stars

    if (TextCheck.isEmpty(starsString) == false){

      // (4.8 )
      String _string = TextMod.removeTextAfterFirstSpecialCharacter(
          text: starsString.trim(),
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
  static int _getRatingsFromScrappedString(String ratingsCountString){
    int _output;

    // comes in this form : '6,891 ratings'
    if (TextCheck.isEmpty(ratingsCountString) == false){
      String _string = TextMod.removeTextAfterFirstSpecialCharacter(ratingsCountString.trim(), 'ratings');
      _string = _string.replaceAll(',', '');
      _output = Numeric.transformStringToInt(_string.trim());
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getPriceFromScrappedString(String priceString){
    double _output;

    // might come in this form : '$179.99'
    if (TextCheck.isEmpty(priceString) == false){

      /// USD
      if (TextCheck.stringContainsSubString(string: priceString, subString: r'$') == true){
       final String _string = TextMod.removeTextBeforeFirstSpecialCharacter(priceString.trim(), r'$');
        _output = Numeric.transformStringToDouble(_string.trim());
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getCurrencyFromScrappedString(String priceString){
    String _output;

    // might come in this form : '$179.99'
    if (TextCheck.isEmpty(priceString) == false){

      blog('_getCurrencyFromScrappedString : $priceString');

      /// USD
      if (TextCheck.stringContainsSubString(string: priceString, subString: r'$') == true){

        blog('TextCheck.stringContainsSubString(string: priceString, subString: \$) : ${TextCheck.stringContainsSubString(string: priceString, subString: r'$')}');

        // CurrencyModel.getCurrencyFromCurrenciesByCountryID(currencies: currencies, countryID: countryID)

        _output = 'currency_USD';
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _fixAboutItemString(String aboutItemString){
    String _output;

    if (TextCheck.isEmpty(aboutItemString) == false){

      final pattern = RegExp(r'About this item\n'); // Define the pattern to match
      _output = aboutItemString.replaceAll(pattern, ''); // Replace the pattern with an empty string

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getUrls({
    required List<GtaModel> gtaModels,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(gtaModels) == true){
      for (final GtaModel model in gtaModels){
        _output.add(model.url);
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

    if (Mapper.checkCanLoopList(products) == true && TextCheck.isEmpty(url) == false){
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
  static bool isAmazonAffiliateLink(String affiliateLink){

    /// AFFILIATE LINK LOOKS LIKE THIS
    /// https://amzn.to/42LyU3E

    if (TextCheck.isEmpty(affiliateLink) == true){
      return false;
    }
    else {
      const String affiliateDomain = 'amzn.to';

      final Uri uri = Uri.parse(affiliateLink);

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
    required List<GtaModel> products,
    required GtaModel product,
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
    required List<GtaModel> products,
    required String url,
  }){
    final List<GtaModel> _output = [...?products];

    if (Mapper.checkCanLoopList(_output) == true){

      final int _index = _output.indexWhere((element) => element.url == url);

      if (_index != -1){
        _output.removeAt(_index);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkGtaModelsAreIdentical({
    required GtaModel product1,
    required GtaModel product2,
  }){
    bool _identical = false;

    if (product1 == null && product2 == null){
      _identical = true;
    }
    else if (product1 == null || product2 == null){
      _identical = false;
    }
    else if (product1 != null && product2 != null){

      if (
      product1.id == product2.id &&
      product1.url == product2.url &&
      product1.title == product2.title &&
      Mapper.checkListsAreIdentical(list1: product1.images, list2: product2.images) == true &&
      product1.brand == product2.brand &&
      product1.stars == product2.stars &&
      product1.ratingsCount == product2.ratingsCount &&
      product1.price == product2.price &&
      product1.currency == product2.currency &&
      product1.about == product2.about &&
      product1.description == product2.description &&
      product1.importantInfo == product2.importantInfo
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
          ratingsCount: $ratingsCount,
          price: $price,
          currency: $currency,
          about: $about,
          description: $description,
          importantInfo: $importantInfo,
       )
      '''
       ;
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
      ratingsCount.hashCode^
      price.hashCode^
      currency.hashCode^
      about.hashCode^
      description.hashCode^
      importantInfo.hashCode;
  // -----------------------------------------------------------------------------
}
