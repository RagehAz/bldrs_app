part of super_fire;

/// => TAMAM
@immutable
class PicMetaModel {
  // -----------------------------------------------------------------------------
  const PicMetaModel({
    @required this.ownersIDs,
    @required this.width,
    @required this.height,
  });
  // -----------------------------------------------------------------------------
  final List<String> ownersIDs;
  final double width;
  final double height;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PicMetaModel copyWith({
    List<String> ownersIDs,
    double width,
    double height,
  }){
    return PicMetaModel(
      ownersIDs: ownersIDs ?? this.ownersIDs,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> cipherToLDB(){
    return <String, dynamic>{
      'ownersIDs': ownersIDs,
      'width': width,
      'height': height,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicMetaModel decipherFromLDB(Map<String, dynamic> map){
    return PicMetaModel(
        ownersIDs: Stringer.getStringsFromDynamics(dynamics: map['ownersIDs']),
        width: map['width'],
        height: map['height'],
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  SettableMetadata toSettableMetadata({
    Map<String, String> extraData,
  }){
    Map<String, String> _metaDataMap = <String, String>{};

    /// ADD OWNERS IDS
    if (Mapper.checkCanLoopList(ownersIDs) == true){
      for (final String ownerID in ownersIDs) {
        _metaDataMap[ownerID] = 'cool';
      }
    }

    /// ADD DIMENSIONS
    if (width != null && height != null) {
      _metaDataMap = Mapper.combineStringStringMap(
        baseMap: _metaDataMap,
        replaceDuplicateKeys: true,
        insert: <String, String>{
          'width': '$width',
          'height': '$height',
        },
      );
    }

    /// ADD EXTRA DATA MAP
    if (extraData != null) {
      _metaDataMap = Mapper.combineStringStringMap(
        baseMap: _metaDataMap,
        replaceDuplicateKeys: true,
        insert: extraData,
      );
    }

    return SettableMetadata(
      customMetadata: _metaDataMap,
      // cacheControl: ,
      // contentDisposition: ,
      // contentEncoding: ,
      // contentLanguage: ,
      // contentType: ,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicMetaModel decipherSettableMetaData({
    @required SettableMetadata settableMetadata,
  }){
    PicMetaModel _output;

    if (settableMetadata != null){

      _output = _decipherMetaMap(
          customMetadata: settableMetadata.customMetadata
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicMetaModel decipherFullMetaData({
    @required FullMetadata fullMetadata,
  }){
    PicMetaModel _output;

    if (fullMetadata != null){

      _output = _decipherMetaMap(
          customMetadata: fullMetadata.customMetadata
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicMetaModel _decipherMetaMap({
    @required Map<String, String> customMetadata,
  }){
    PicMetaModel _output;

    if (customMetadata != null){
      _output = PicMetaModel(
        ownersIDs: Mapper.getKeysHavingThisValue(
          map: customMetadata,
          value: 'cool',
        ),
        width: Numeric.transformStringToDouble(customMetadata['width']),
        height: Numeric.transformStringToDouble(customMetadata['height']),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSettableMetaData(SettableMetadata metaData){
    blog('BLOGGING SETTABLE META DATA ------------------------------- START');
    if (metaData == null){
      blog('Meta data is null');
    }
    else {
      blog('cacheControl : ${metaData.cacheControl}');
      blog('contentDisposition : ${metaData.contentDisposition}');
      blog('contentEncoding : ${metaData.contentEncoding}');
      blog('contentLanguage : ${metaData.contentLanguage}');
      blog('contentType : ${metaData.contentType}');
      blog('customMetadata : ${metaData.customMetadata}');
    }
    blog('BLOGGING SETTABLE META DATA ------------------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFullMetaData(FullMetadata metaData){

    blog('BLOGGING FULL META DATA ------------------------------- START');
    if (metaData == null){
      blog('Meta data is null');
    }
    else {
      blog('name : ${metaData.name}');
      blog('bucket : ${metaData.bucket}');
      blog('cacheControl : ${metaData.cacheControl}');
      blog('contentDisposition : ${metaData.contentDisposition}');
      blog('contentEncoding : ${metaData.contentEncoding}');
      blog('contentLanguage : ${metaData.contentLanguage}');
      blog('contentType : ${metaData.contentType}');
      blog('customMetadata : ${metaData.customMetadata}'); // map
      blog('fullPath : ${metaData.fullPath}');
      blog('generation : ${metaData.generation}');
      blog('md5Hash : ${metaData.md5Hash}');
      blog('metadataGeneration : ${metaData.metadataGeneration}');
      blog('metageneration : ${metaData.metageneration}');
      blog('size : ${metaData.size}');
      blog('timeCreated : ${metaData.timeCreated}'); // date time
      blog('updated : ${metaData.updated}'); // date time
    }
    blog('BLOGGING FULL META DATA ------------------------------- END');

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMetaDatasAreIdentical({
  @required PicMetaModel meta1,
  @required PicMetaModel meta2,
  }){
    bool _output = false;

    if (meta1 == null && meta2 == null){
      _output = true;
    }

    else if (meta1 != null && meta2 != null){

      if (
          Mapper.checkListsAreIdentical(list1: meta1.ownersIDs, list2: meta2.ownersIDs) == true
              &&
          meta1.width == meta2.width
              &&
          meta1.height == meta2.height
      ){
        _output = true;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Size> getFileWidthAndHeight({
    @required File file,
  }) async {

    if (file != null){

      final Uint8List _uInt8List = await Floaters.getUint8ListFromFile(file);
        // blog('_uInt8List : $_uInt8List');
      final ui.Image _decodedImage = await Floaters.getUiImageFromUint8List(_uInt8List);

      return Size(
        _decodedImage.width.toDouble(),
        _decodedImage.height.toDouble(),
      );

    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------
  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is PicMetaModel){
      _areIdentical = checkMetaDatasAreIdentical(
        meta1: this,
        meta2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      ownersIDs.hashCode^
      width.hashCode^
      height.hashCode;
  // -----------------------------------------------------------------------------
}
