import 'dart:io';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/file_size_unit.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/foundation.dart';

/// => TAMAM
@immutable
class VideoModel {
  // -----------------------------------------------------------------------------
  const VideoModel({
    required this.bytes,
    required this.path,
    required this.meta,
  });
  // -----------------------------------------------------------------------------
  final Uint8List? bytes;
  /// storage/collectionName/subCollectionName/fileName.ext
  final String? path;
  final StorageMetaModel? meta;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  VideoModel copyWith({
    Uint8List? bytes,
    String? path,
    StorageMetaModel? meta,
  }){
    return VideoModel(
      bytes: bytes ?? this.bytes,
      path: path ?? this.path,
      meta: meta ?? this.meta,
    );
  }
  // --------------------
  ///
  VideoModel nullifyField({
    bool bytes = false,
    bool path = false,
    bool meta = false,
  }){
    return VideoModel(
      bytes: bytes   == true ? null : this.bytes,
      path: path     == true ? null : this.path,
      meta: meta     == true ? null : this.meta,
    );
  }
  // -----------------------------------------------------------------------------

  /// LDB CYPHERS

  // --------------------
  ///
  static Map<String, dynamic>? cipherToLDB(VideoModel? picModel){
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
  ///
  static VideoModel? decipherFromLDB(Map<String, dynamic>? map){
    VideoModel? _picModel;

    if (map != null){

      _picModel = VideoModel(
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
  ///
  static void assertIsUploadable(VideoModel? picModel){
    assert(picModel != null, 'picModel is null');
    assert(picModel?.bytes != null, 'bytes is null');
    assert(picModel?.path != null, 'path is null');
    assert(picModel?.meta != null, 'meta is null');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static Future<Dimensions?> getDimensions(Uint8List? bytes) async {
    final Dimensions? _dim = await Dimensions.superDimensions(bytes);
    return _dim;
  }
  // --------------------
  ///
  double? getSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }){
    return Filers.calculateSize(bytes?.length, fileSizeUnit);
  }
  // --------------------
  ///
  static Future<List<VideoModel>> createPicsFromLocalAssets({
    required List<String> assets,
    // required int width,
  }) async {
    final List<VideoModel> _output = [];

    if (Lister.checkCanLoop(assets) == true){

      for (final String asset in assets){

        final Uint8List? _bytes = await Floaters.getBytesFromLocalAsset(
          localAsset: asset,
          // width: width,
        );

        final VideoModel? _pic = await combineVideoModel(
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
  // --------------------
  ///
  static List<Uint8List> getBytezzFromPicModels({
    required List<VideoModel> pics,
  }){
    final List<Uint8List> _output = [];

    if (Lister.checkCanLoop(pics) == true){
      for (final VideoModel pic in pics){
        if (pic.bytes != null){
          _output.add(pic.bytes!);
        }
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// COMBINER

  // --------------------
  ///
  static Future<VideoModel?> combineVideoModel({
    required Uint8List? bytes,
    required PicMakerType picMakerType,
    required int? compressWithQuality,
    required String? assignPath,
    required List<String> ownersIDs,
    required String name,
  }) async {
    VideoModel? _output;

    // blog('  1.combinePicModel start : ${bytes?.length} bytes : picMakerType $picMakerType : '
    //     'assignPath : $assignPath : name : $name');

    if (bytes != null){

      // blog('  2.combinePicModel bytes exists bytes != null');

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
        _output = VideoModel(
          bytes: bytes,
          path: assignPath,
          meta: StorageMetaModel(
            sizeMB: _mega,
            width: _dims.width,
            height: _dims.height,
            name: name,
            ownersIDs: ownersIDs,
            data: MapperSS.cleanNullPairs(
              map: {
                'aspectRatio': _aspectRatio.toString(),
                'sizeB': bytes.length.toString(),
                'sizeKB': _kilo.toString(),
                'compressionQuality': compressWithQuality?.toString(),
                'source': PicMaker.cipherPicMakerType(picMakerType),
                'deviceID': _deviceID,
                'deviceName': _deviceName,
                'platform': _devicePlatform,
              },
            ),
          ),
        );
      }

    }

    // blog('  3.combinePicModel _output is null ${_output == null}');

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  ///
  void blogVideo({
    String invoker = '',
  }){

    final double? _mega = Filers.calculateSize(bytes?.length, FileSizeUnit.megaByte);
    final double? _kilo = Filers.calculateSize(bytes?.length, FileSizeUnit.kiloByte);

    blog('=> $invoker :: path : $path : ${bytes?.length} Bytes | '
        '[ (${meta?.width})w x (${meta?.height})h ] | '
        'owners : ${meta?.ownersIDs} | $_mega MB | $_kilo KB');

  }
  // --------------------
  ///
  static void blogVideos({
    required List<VideoModel>? pics,
    String invoker = '',
  }){

    if (pics == null){
      blog('blogPics : pics are null');
    }
    else if (pics.isEmpty == true){
      blog('blogPics : pics are empty');
    }
    else {

      for (final VideoModel pic in pics){

        pic.blogVideo(
          invoker: invoker,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DUMMY PIC

  // --------------------
  ///
  static VideoModel dummyVideo(){

    return VideoModel(
      path: 'storage/bldrs/bldrs_app_icon.png',
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
  ///
  static bool checkVideosAreIdentical({
    required VideoModel? model1,
    required VideoModel? model2,
  }){
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }
    else if (model1 != null && model2 != null){

      if (
      model1.path == model2.path &&
          model1.bytes?.length == model2.bytes?.length &&
          Lister.checkListsAreIdentical(list1: model1.bytes, list2: model2.bytes) == true &&
          StorageMetaModel.checkMetaDatasAreIdentical(meta1: model1.meta, meta2: model2.meta) == true
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // --------------------
  ///
  static bool checkVideosListsAreIdentical({
    required List<VideoModel>? list1,
    required List<VideoModel>? list2,
  }){

    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1 != null && list1.isEmpty == true && list2 != null && list2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (Lister.checkCanLoop(list1) == true && Lister.checkCanLoop(list2) == true){

      if (list1!.length != list2!.length) {
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < list1.length; i++) {

          final bool _pairAreIdentical = checkVideosAreIdentical(
              model1: list1[i],
              model2: list2[i]
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
    VideoModel(
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
    if (other is VideoModel){
      _areIdentical = checkVideosAreIdentical(
        model1: this,
        model2: other,
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
