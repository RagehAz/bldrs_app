part of super_fire;

/// => TAMAM
@immutable
class StorageMetaModel {
  // -----------------------------------------------------------------------------
  const StorageMetaModel({
    @required this.ownersIDs,
    this.width,
    this.height,
    this.name,
    this.sizeMB,
    this.data,
  });
  // -----------------------------------------------------------------------------
  final List<String> ownersIDs;
  final double width;
  final double height;
  final String name;
  final double sizeMB;
  final Map<String, String> data;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  StorageMetaModel copyWith({
    List<String> ownersIDs,
    double width,
    double height,
    String name,
    double sizeMB,
    Map<String, String> data,
  }){
    return StorageMetaModel(
      ownersIDs: ownersIDs ?? this.ownersIDs,
      width: width ?? this.width,
      height: height ?? this.height,
      name: name ?? this.name,
      sizeMB: sizeMB ?? this.sizeMB,
      data: data ?? this.data,
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
      'name': name,
      'sizeMB': sizeMB,
      'data': data,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StorageMetaModel decipherFromLDB(Map<String, dynamic> map){
    return StorageMetaModel(
      ownersIDs: Stringer.getStringsFromDynamics(dynamics: map['ownersIDs']),
      width: map['width'],
      height: map['height'],
      name: map['name'],
      sizeMB: map['sizeMB'],
      data: map['data'],
    );
  }
  // --------------------
  /// TASK : TEST ME
  static StorageMetaModel _decipherMetaMap({
    @required Map<String, String> customMetadata,
  }){
    StorageMetaModel _output;

    if (customMetadata != null){
      _output = StorageMetaModel(
        ownersIDs: Mapper.getKeysHavingThisValue(
          map: customMetadata,
          value: 'cool',
        ),
        width: Numeric.transformStringToDouble(customMetadata['width']),
        height: Numeric.transformStringToDouble(customMetadata['height']),
        name: customMetadata['name'],
        sizeMB: Numeric.transformStringToDouble(customMetadata['sizeMB']),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// OFFICIAL CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  f_s.SettableMetadata toOfficialSettableMetadata({
    Map<String, String> extraData,
  }){
    Map<String, String> _metaDataMap = <String, String>{
      'name': name,
      'sizeMB': '$sizeMB',
      'width': '$width',
      'height': '$height',
    };

    /// ADD OWNERS IDS
    if (Mapper.checkCanLoopList(ownersIDs) == true){
      for (final String ownerID in ownersIDs) {
        _metaDataMap[ownerID] = 'cool';
      }
    }

    _metaDataMap = Mapper.cleanNullPairs(
        map: _metaDataMap,
    );

    /// ADD EXTRA DATA MAP
    if (extraData != null) {
      _metaDataMap = Mapper.combineStringStringMap(
        baseMap: _metaDataMap,
        replaceDuplicateKeys: true,
        insert: extraData,
      );
    }

    return f_s.SettableMetadata(
      customMetadata: _metaDataMap,
      // cacheControl: ,
      // contentDisposition: ,
      // contentEncoding: ,
      // contentLanguage: ,
      // contentType: ,
    );

  }
  // --------------------
  /// NEVER USED
  /*
  /// TESTED : WORKS PERFECT
  static StorageMetaModel decipherOfficialSettableMetaData({
    @required f_s.SettableMetadata settableMetadata,
  }){
    StorageMetaModel _output;

    if (settableMetadata != null){

      _output = _decipherMetaMap(
          customMetadata: settableMetadata.customMetadata
      );

    }

    return _output;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static StorageMetaModel decipherOfficialFullMetaData({
    @required f_s.FullMetadata fullMetadata,
  }){
    StorageMetaModel _output;

    if (fullMetadata != null){

      _output = _decipherMetaMap(
          customMetadata: fullMetadata.customMetadata
      );

    }

    return _output;
  }
  // --------------------

  /// NATIVE CYPHERS

  // --------------------
  /// TASK : TEST ME
  f_d.SettableMetadata toNativeSettableMetadata({
    Map<String, String> extraData,
  }){

    Map<String, String> _metaDataMap = <String, String>{
      'name': name,
      'sizeMB': '$sizeMB',
      'width': '$width',
      'height': '$height',
    };

    /// ADD OWNERS IDS
    if (Mapper.checkCanLoopList(ownersIDs) == true){
      for (final String ownerID in ownersIDs) {

        _metaDataMap = Mapper.insertPairInMap(
            map: _metaDataMap,
            key: ownerID,
            value: 'cool'
        );

      }
    }

    _metaDataMap = Mapper.cleanNullPairs(
        map: _metaDataMap,
    );

    return f_d.SettableMetadata(
      customMetadata: _metaDataMap,
      // cacheControl: ,
      // contentDisposition: ,
      // contentEncoding: ,
      // contentLanguage: ,
      // contentType: ,
    );

  }
  // --------------------
  /// TASK : TEST ME
  static StorageMetaModel decipherNativeFullMetaData({
    @required f_d.FullMetadata fullMetadata,
  }){
    StorageMetaModel _output;

    if (fullMetadata != null){

      _output = _decipherMetaMap(
          customMetadata: fullMetadata.customMetadata
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogOfficialSettableMetaData(f_s.SettableMetadata metaData){
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
  static void blogOfficialFullMetaData(f_s.FullMetadata metaData){

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
  @required StorageMetaModel meta1,
  @required StorageMetaModel meta2,
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
              &&
          meta1.sizeMB == meta2.sizeMB
              &&
          meta1.name == meta2.name
              &&
          Mapper.checkMapsAreIdentical(map1: meta1.data, map2: meta2.data) == true
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
    if (other is StorageMetaModel){
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
      height.hashCode^
      sizeMB.hashCode^
      name.hashCode^
      data.hashCode;
  // -----------------------------------------------------------------------------
}
