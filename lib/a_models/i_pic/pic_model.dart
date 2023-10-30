import 'dart:io';

import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/file_size_unit.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/foundation.dart';
/// => TAMAM
@immutable
class PicModel {
  // -----------------------------------------------------------------------------
  const PicModel({
    required this.bytes,
    required this.path,
    required this.meta,
  });
  // -----------------------------------------------------------------------------
  final Uint8List? bytes;
  /// collectionName/subCollectionName/fileName
  final String? path;
  final StorageMetaModel? meta;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PicModel copyWith({
    Uint8List? bytes,
    String? path,
    StorageMetaModel? meta,
  }){
    return PicModel(
      bytes: bytes ?? this.bytes,
      path: path ?? this.path,
      meta: meta ?? this.meta,
    );
  }
  // -----------------------------------------------------------------------------

  /// LDB CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipherToLDB(PicModel? picModel){
    Map<String, dynamic>? _map;

    if (picModel != null){
      _map = {
        'bytes': Floaters.getIntsFromBytes(picModel.bytes),
        'path': picModel.path,
        'meta': picModel.meta?.cipherToLDB()
      };
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicModel? decipherFromLDB(Map<String, dynamic>? map){
    PicModel? _picModel;

    if (map != null){

      _picModel = PicModel(
        bytes: Floaters.getBytesFromInts(map['bytes']),
        path: map['path'],
        meta: StorageMetaModel.decipherFromLDB(map['meta']),
      );

    }


    return _picModel;
  }
  // -----------------------------------------------------------------------------

  /// ASSERTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void assertIsUploadable(PicModel? picModel){
    assert(picModel != null, 'picModel is null');
    assert(picModel?.bytes != null, 'bytes is null');
    assert(picModel?.path != null, 'path is null');
    assert(picModel?.meta != null, 'meta is null');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> getDimensions(Uint8List? bytes) async {
    final Dimensions? _dim = await Dimensions.superDimensions(bytes);
    return _dim;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double? getSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }){
    return Filers.calculateSize(bytes?.length, fileSizeUnit);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PicModel>> createPicsFromLocalAssets({
    required List<String> assets,
    required int width,
  }) async {
    final List<PicModel> _output = [];

    if (Mapper.checkCanLoopList(assets) == true){

      for (final String asset in assets){
        
        final Uint8List? _bytes = await Floaters.getBytesFromLocalAsset(
            localAsset: asset,
            width: width,
        );

        final PicModel? _pic = await combinePicModel(
            bytes: _bytes,
            picMakerType: PicMakerType.generated,
            compressWithQuality: 80,
            assignPath: '',
            ownersIDs: [],
            name: ''
        );

        if (_pic != null){
          _output.add(_pic);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// COMBINERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PicModel?> combinePicModel({
    required Uint8List? bytes,
    required PicMakerType picMakerType,
    required int? compressWithQuality,
    required String? assignPath,
    required List<String> ownersIDs,
    required String name,
  }) async {
    PicModel? _output;

    blog('  1.combinePicModel start : ${bytes?.length} bytes : picMakerType $picMakerType : '
        'assignPath : $assignPath : name : $name');

    if (bytes != null){

      blog('  2.combinePicModel bytes exists bytes != null');

      final Dimensions? _dims =  await Dimensions.superDimensions(bytes);
      final double? _aspectRatio = Numeric.roundFractions(_dims?.getAspectRatio(), 2);
      final double? _mega = Filers.calculateSize(bytes.length, FileSizeUnit.megaByte);
      final double? _kilo = Filers.calculateSize(bytes.length, FileSizeUnit.kiloByte);
      final String? _deviceID = await DeviceChecker.getDeviceID();
      final String? _deviceName = await DeviceChecker.getDeviceName();
      final String _devicePlatform = kIsWeb == true ? 'web' : Platform.operatingSystem;

      /// SOMETHING IS MISSING
      if (
          _dims == null ||
          _aspectRatio == null ||
          _mega == null ||
          _kilo == null ||
          _deviceID == null ||
          _deviceName == null
      ){
        _output = null;
        // blog('  3.dims : $_dims');
        // blog('  3.aspectRatio : $_aspectRatio');
        // blog('  3.mega : $_mega');
        // blog('  3.kilo : $_kilo');
        // blog('  3.deviceID : $_deviceID');
        // blog('  3.deviceName : $_deviceName');
        // blog('  3.devicePlatform : $_devicePlatform');
      }

      /// ALL IS GOOD
      else {
        _output = PicModel(
          bytes: bytes,
          path: assignPath,
          meta: StorageMetaModel(
            sizeMB: _mega,
            width: _dims.width,
            height: _dims.height,
            name: name,
            ownersIDs: ownersIDs,
            data: {
              'aspectRatio': _aspectRatio.toString(),
              'sizeB': bytes.length.toString(),
              'sizeKB': _kilo.toString(),
              'compressionQuality': compressWithQuality.toString(),
              'source': PicMaker.cipherPicMakerType(picMakerType),
              'deviceID': _deviceID,
              'deviceName': _deviceName,
              'platform': _devicePlatform,
            },
          ),
        );
      }

    }

    blog('  3.combinePicModel _output is null ${_output == null}');

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPic({
    String invoker = '',
  }){

    final double? _mega = Filers.calculateSize(bytes?.length, FileSizeUnit.megaByte);
    final double? _kilo = Filers.calculateSize(bytes?.length, FileSizeUnit.kiloByte);

    blog('=> $invoker :: path : $path : ${bytes?.length} Bytes | '
        '[ (${meta?.width})w x (${meta?.height})h ] | '
        'owners : ${meta?.ownersIDs} | $_mega MB | $_kilo KB');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPics({
    required List<PicModel>? pics,
    String invoker = '',
  }){

    if (pics == null){
      blog('blogPics : pics are null');
    }
    else if (pics.isEmpty == true){
      blog('blogPics : pics are empty');
    }
    else {

      for (final PicModel pic in pics){

        pic.blogPic(
          invoker: invoker,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DUMMY PIC

  // --------------------
  /// TESTED : WORKS PERFECT
  static PicModel dummyPic(){

    return PicModel(
      path: 'storage:bldrs/bldrs_app_icon.png',
      bytes: Uint8List.fromList([1,2,3]),
      meta: StorageMetaModel(
        ownersIDs: const ['OwnerID'],
        name: 'Dummy Pic',
        width: 100,
        height: 100,
        sizeMB: 0.1,
        data: {
          'aspectRatio': '1.0',
          'sizeB': '100',
          'sizeKB': '0.1',
          'compressionQuality': '100',
          'source': PicMaker.cipherPicMakerType(PicMakerType.generated),
          'deviceID': 'Dummy Device ID',
          'deviceName': 'Dummy Device Name',
          'platform': 'Dummy Platform',
        },
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPicsAreIdentical({
    required PicModel? pic1,
    required PicModel? pic2,
  }){
    bool _identical = false;

    if (pic1 == null && pic2 == null){
      _identical = true;
    }
    else if (pic1 != null && pic2 != null){

      if (
          pic1.path == pic2.path &&
          pic1.bytes?.length == pic2.bytes?.length &&
          Mapper.checkListsAreIdentical(list1: pic1.bytes, list2: pic2.bytes) == true &&
          StorageMetaModel.checkMetaDatasAreIdentical(meta1: pic1.meta, meta2: pic2.meta) == true
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPicsListsAreIdentical({
    required List<PicModel>? list1,
    required List<PicModel>? list2,
  }){

    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1 != null && list1.isEmpty == true && list2 != null && list2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (Mapper.checkCanLoopList(list1) == true && Mapper.checkCanLoopList(list2) == true){

      if (list1!.length != list2!.length) {
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < list1.length; i++) {

          final bool _pairAreIdentical = checkPicsAreIdentical(
              pic1: list1[i],
              pic2: list2[i]
          );

          if (_pairAreIdentical == false) {
            _listsAreIdentical = false;
            break;
          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    // blog('checkPicsListsAreIdentical : _listsAreIdentical : $_listsAreIdentical');

    return _listsAreIdentical;

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString(){

    final String _text =
    '''
    PicModel(
      bytes: ${bytes?.length},
      path: $path,
      meta: $meta
    );
    ''';

    return _text;
   }
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is PicModel){
      _areIdentical = checkPicsAreIdentical(
        pic1: this,
        pic2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      meta.hashCode^
      bytes.hashCode^
      path.hashCode;
  // -----------------------------------------------------------------------------
}
