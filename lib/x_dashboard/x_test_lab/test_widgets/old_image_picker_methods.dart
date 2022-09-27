// import 'package:image_picker/image_picker.dart';

// -----------------------------------------------------------------

/// OLD - IMAGE PICKER

// ---------------------------------------
/*
Future<File> takeGalleryPicture({
  @required PicType picType,
}) async {

  final ImagePicker _picker = ImagePicker();
  File _result;

  final XFile _imageFile = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: concludeImageQuality(picType),
    maxWidth: concludeImageMaxWidth(picType),
    // maxHeight: concludeImageMaxHeight(picType)
  );

  if (_imageFile != null) {
    _result = createFileFromXFile(_imageFile);
  }

  return _result;
}
 */
// ---------------------------------------
/*
Future<File> takeCameraPicture({
  @required PicType picType,
}) async {

  final ImagePicker _picker = ImagePicker();

  final XFile _imageFile = await _picker.pickImage(
    source: ImageSource.camera,
    imageQuality: concludeImageQuality(picType),
    maxWidth: concludeImageMaxWidth(picType),
    // maxHeight: concludeImageMaxHeight(picType)
  );

  return _imageFile != null ?
  createFileFromXFile(_imageFile)
      :
  null;

}
 */
// ---------------------------------------
/*
Future<List<Asset>> takeGalleryMultiPictures({
  @required BuildContext context,
  @required List<Asset> images,
  @required bool mounted,
  @required BzAccountType accountType,
}) async {

  List<Asset> _resultList = <Asset>[];
  String _error = 'No Error Detected';

  try {
    _resultList = await MultiImagePicker.pickImages(
      maxImages: Standards.getMaxSlidesCount(bzAccountType: accountType),
      enableCamera: true,
      selectedAssets: images ?? <Asset>[],
      cupertinoOptions: const CupertinoOptions(
        takePhotoIcon: 'Take photo',
        doneButtonTitle: 'Done',
      ),
      materialOptions: const MaterialOptions(
        actionBarColor: '#13244b',
        actionBarTitle: 'Select Images',//superPhrase(context, 'phid_choose'),
        allViewTitle: 'All Photos',
        useDetailsView: false,
        selectCircleStrokeColor: '#ffc000',
        startInAllView: true,
        textOnNothingSelected: 'Nothing is Fucking Selected',
        statusBarColor: '#000000', // the app status bar
        lightStatusBar: false,
        // actionBarTitleColor: "#13244b", // page title color, White is Default
        autoCloseOnSelectionLimit: false,
        selectionLimitReachedText: "Can't add more Images !",
        // unknown impact
        // backButtonDrawable: 'wtf is this backButtonDrawable',
        // okButtonDrawable: 'dunno okButtonDrawable',
      ),
    );
  }

  on Exception catch (e) {
    _error = e.toString();

    if (_error != 'The user has cancelled the selection') {
      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Error',
        body: _error,
      );
    }
  }

  /// If the widget was removed from the tree while the asynchronous platform
  /// message was in flight, we want to discard the reply rather than calling
  /// setState to update our non-existent appearance.
  if (!mounted) {
    return null;
  }

  else {
    return _resultList;
  }

}
 */
// -----------------------------------------------------------------

/// ASSET MODEL

// ---------------------------------------
/*
Future<File> getFileFromPickerAsset(Asset asset) async {
  final ByteData _byteData = await asset.getThumbByteData(
      asset.originalWidth, asset.originalHeight
  );

  final String _name = TextMod.removeTextAfterLastSpecialCharacter(asset.name, '.');

  blog('== asset name is : ${asset.runtimeType}');

  final File _tempFile = File('${(await getTemporaryDirectory()).path}/$_name');
  await _tempFile.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));
  await _tempFile.create(recursive: true);

  final File _file = _tempFile;

  return _file;
}
 */
// ---------------------------------------
/*
Future<List<File>> getFilesFromPickerAssets(List<Asset> assets) async {
  final List<File> _files = <File>[];

  if (Mapper.checkCanLoopList(assets)) {
    for (final Asset asset in assets) {
      final File _file = await getFileFromPickerAsset(asset);
      _files.add(_file);
    }
  }

  return _files;
}
 */
// ---------------------------------------
/*
Future<Asset> getPickerAssetFromURL(String url) async {
  final File _file = await getFileFromURL(url);

  final ImageSize imageSize = await ImageSize.superImageSize(_file);
  //
  //
  final Asset _asset = Asset(
    // identifier
    _file.fileNameWithExtension,
    // _name
    _file.fileNameWithExtension,
    // _originalWidth
    imageSize.width.toInt(),
    // _originalHeight
    imageSize.height.toInt(),
  );
  //
  //   // ByteData _byteData = await _file.get(asset.originalWidth, asset.originalHeight, quality: 100);
  //   //
  //   // String _name = TextMod.trimTextAfterLastSpecialCharacter(asset.name, '.');
  //   //
  //   // blog('====================================================================================== asset name is : ${asset.runtimeType}');
  //   //
  //   // final _tempFile = File('${(await getTemporaryDirectory()).path}/${_name}');
  //   // await _tempFile.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));
  //   // await _tempFile.create(recursive: true);
  //
  //   // File _file = _tempFile;
  //
  return _asset;
  //
}
 */
// ---------------------------------------
/*
Asset getOnlyAssetFromDynamic(dynamic input) {
  Asset _asset;
  if (ObjectChecker.objectIsAsset(input) == true) {
    _asset = input;
  }

  return _asset;
}
 */
// ---------------------------------------
/*
List<Asset> getOnlyAssetsFromDynamics(List<dynamic> inputs) {
  final List<Asset> _assets = <Asset>[];

  if (Mapper.checkCanLoopList(inputs)) {
    for (final dynamic x in inputs) {
      _assets.add(getOnlyAssetFromDynamic(x));
    }
  }

  return _assets;
}
 */
// ---------------------------------------
/*
Future<void> blogAsset({
  @required Asset asset,
  bool blogDeviceData = true,
  bool blogGPSData = true,
  bool blogExifData = true,
}) async {

  final Metadata _metadata = await asset.metadata;

  final DeviceMetadata _deviceMetadata = _metadata.device;
  final GpsMetadata _gpsMetadata = _metadata.gps;
  final ExifMetadata _exifMetaData = _metadata.exif;

  blog('BLOGGING ASSET ------------------------------------------------------- START');
  blog('asset ID : ${asset.identifier}');
  blog('asset name : ${asset.name}');
  blog('asset is Landscape : ${asset.isLandscape}');
  blog('asset width : ${asset.originalWidth}');
  blog('asset height : ${asset.originalHeight}');

  if (blogDeviceData == true){
    blog('DEVICE META DATA ------------------------------------------------');
    blog('body serial number : ${_deviceMetadata.bodySerialNumber}');
    blog('camera owner name : ${_deviceMetadata.cameraOwnerName}');
    blog('lens make : ${_deviceMetadata.lensMake}');
    blog('lens model : ${_deviceMetadata.lensModel}');
    blog('lens serial number : ${_deviceMetadata.lensSerialNumber}');
    blog('lens specifications : ${_deviceMetadata.lensSpecification}');
    blog('make : ${_deviceMetadata.make}');
    blog('maker note : ${_deviceMetadata.makerNote}');
    blog('model : ${_deviceMetadata.model}');
    blog('software : ${_deviceMetadata.software}');
  }

  if (blogGPSData == true){
    blog('GPS META DATA ------------------------------------------------');
    blog('gpsVersionID : ${_gpsMetadata.gpsVersionID}');
    blog('gpsLatitudeRef : ${_gpsMetadata.gpsLatitudeRef}');
    blog('gpsLatitude : ${_gpsMetadata.gpsLatitude}');
    blog('gpsLongitudeRef : ${_gpsMetadata.gpsLongitudeRef}');
    blog('gpsLongitude : ${_gpsMetadata.gpsLongitude}');
    blog('gpsAltitudeRef : ${_gpsMetadata.gpsAltitudeRef}');
    blog('gpsAltitude : ${_gpsMetadata.gpsAltitude}');
    blog('gpsTimeStamp : ${_gpsMetadata.gpsTimeStamp}');
    blog('gpsSatellites : ${_gpsMetadata.gpsSatellites}');
    blog('gpsStatus : ${_gpsMetadata.gpsStatus}');
    blog('gpsMeasureMode : ${_gpsMetadata.gpsMeasureMode}');
    blog('gpsDOP : ${_gpsMetadata.gpsDOP}');
    blog('gpsSpeedRef : ${_gpsMetadata.gpsSpeedRef}');
    blog('gpsSpeed : ${_gpsMetadata.gpsSpeed}');
    blog('gpsTrackRef : ${_gpsMetadata.gpsTrackRef}');
    blog('gpsTrack : ${_gpsMetadata.gpsTrack}');
    blog('gpsImgDirectionRef : ${_gpsMetadata.gpsImgDirectionRef}');
    blog('gpsImgDirection : ${_gpsMetadata.gpsImgDirection}');
    blog('gpsMapDatum : ${_gpsMetadata.gpsMapDatum}');
    blog('gpsDestLatitudeRef : ${_gpsMetadata.gpsDestLatitudeRef}');
    blog('gpsDestLatitude : ${_gpsMetadata.gpsDestLatitude}');
    blog('gpsDestLongitudeRef : ${_gpsMetadata.gpsDestLongitudeRef}');
    blog('gpsDestLongitude : ${_gpsMetadata.gpsDestLongitude}');
    blog('gpsDestBearingRef : ${_gpsMetadata.gpsDestBearingRef}');
    blog('gpsDestBearing : ${_gpsMetadata.gpsDestBearing}');
    blog('gpsDestDistanceRef : ${_gpsMetadata.gpsDestDistanceRef}');
    blog('gpsDestDistance : ${_gpsMetadata.gpsDestDistance}');
    blog('gpsProcessingMethod : ${_gpsMetadata.gpsProcessingMethod}');
    blog('gpsAreaInformation : ${_gpsMetadata.gpsAreaInformation}');
    blog('gpsDateStamp : ${_gpsMetadata.gpsDateStamp}');
    blog('gpsDifferential : ${_gpsMetadata.gpsDifferential}');
    blog('gpsHPositioningError : ${_gpsMetadata.gpsHPositioningError}');
    blog('interoperabilityIndex : ${_gpsMetadata.interoperabilityIndex}');
  }

  if (blogExifData == true){
    blog('GPS META DATA ------------------------------------------------');
    blog('imageWidth : ${_exifMetaData.imageWidth}');
    blog('imageLength : ${_exifMetaData.imageLength}');
    blog('bitsPerSample : ${_exifMetaData.bitsPerSample}');
    blog('compression : ${_exifMetaData.compression}');
    blog('photometricInterpretation : ${_exifMetaData.photometricInterpretation}');
    blog('orientation : ${_exifMetaData.orientation}');
    blog('samplesPerPixel : ${_exifMetaData.samplesPerPixel}');
    blog('planarConfiguration : ${_exifMetaData.planarConfiguration}');
    blog('ycbCrSubSampling : ${_exifMetaData.ycbCrSubSampling}');
    blog('ycbCrPositioning : ${_exifMetaData.ycbCrPositioning}');
    blog('xResolution : ${_exifMetaData.xResolution}');
    blog('yResolution : ${_exifMetaData.yResolution}');
    blog('resolutionUnit : ${_exifMetaData.resolutionUnit}');
    blog('stripOffsets : ${_exifMetaData.stripOffsets}');
    blog('rowsPerStrip : ${_exifMetaData.rowsPerStrip}');
    blog('stripByteCounts : ${_exifMetaData.stripByteCounts}');
    blog('jpegInterchangeFormat : ${_exifMetaData.jpegInterchangeFormat}');
    blog('jpegInterchangeFormatLength : ${_exifMetaData.jpegInterchangeFormatLength}');
    blog('transferFunction : ${_exifMetaData.transferFunction}');
    blog('whitePoint : ${_exifMetaData.whitePoint}');
    blog('primaryChromaticities : ${_exifMetaData.primaryChromaticities}');
    blog('ycbCrCoefficients : ${_exifMetaData.ycbCrCoefficients}');
    blog('referenceBlackWhite : ${_exifMetaData.referenceBlackWhite}');
    blog('dateTime : ${_exifMetaData.dateTime}');
    blog('imageDescription : ${_exifMetaData.imageDescription}');
    blog('artist : ${_exifMetaData.artist}');
    blog('copyright : ${_exifMetaData.copyright}');
    blog('exifVersion : ${_exifMetaData.exifVersion}');
    blog('flashpixVersion : ${_exifMetaData.flashpixVersion}');
    blog('colorSpace : ${_exifMetaData.colorSpace}');
    blog('gamma : ${_exifMetaData.gamma}');
    blog('pixelXDimension : ${_exifMetaData.pixelXDimension}');
    blog('pixelYDimension : ${_exifMetaData.pixelYDimension}');
    blog('componentsConfiguration : ${_exifMetaData.componentsConfiguration}');
    blog('compressedBitsPerPixel : ${_exifMetaData.compressedBitsPerPixel}');
    blog('userComment : ${_exifMetaData.userComment}');
    blog('relatedSoundFile : ${_exifMetaData.relatedSoundFile}');
    blog('dateTimeOriginal : ${_exifMetaData.dateTimeOriginal}');
    blog('dateTimeDigitized : ${_exifMetaData.dateTimeDigitized}');
    blog('subSecTime : ${_exifMetaData.subSecTime}');
    blog('subSecTimeOriginal : ${_exifMetaData.subSecTimeOriginal}');
    blog('subSecTimeDigitized : ${_exifMetaData.subSecTimeDigitized}');
    blog('exposureTime : ${_exifMetaData.exposureTime}');
    blog('fNumber : ${_exifMetaData.fNumber}');
    blog('exposureProgram : ${_exifMetaData.exposureProgram}');
    blog('spectralSensitivity : ${_exifMetaData.spectralSensitivity}');
    blog('photographicSensitivity : ${_exifMetaData.photographicSensitivity}');
    blog('oecf : ${_exifMetaData.oecf}');
    blog('sensitivityType : ${_exifMetaData.sensitivityType}');
    blog('standardOutputSensitivity : ${_exifMetaData.standardOutputSensitivity}');
    blog('recommendedExposureIndex : ${_exifMetaData.recommendedExposureIndex}');
    blog('isoSpeed : ${_exifMetaData.isoSpeed}');
    blog('isoSpeedLatitudeyyy : ${_exifMetaData.isoSpeedLatitudeyyy}');
    blog('isoSpeedLatitudezzz : ${_exifMetaData.isoSpeedLatitudezzz}');
    blog('shutterSpeedValue : ${_exifMetaData.shutterSpeedValue}');
    blog('apertureValue : ${_exifMetaData.apertureValue}');
    blog('brightnessValue : ${_exifMetaData.brightnessValue}');
    blog('exposureBiasValue : ${_exifMetaData.exposureBiasValue}');
    blog('maxApertureValue : ${_exifMetaData.maxApertureValue}');
    blog('subjectDistance : ${_exifMetaData.subjectDistance}');
    blog('meteringMode : ${_exifMetaData.meteringMode}');
    blog('lightSource : ${_exifMetaData.lightSource}');
    blog('flash : ${_exifMetaData.flash}');
    blog('subjectArea : ${_exifMetaData.subjectArea}');
    blog('focalLength : ${_exifMetaData.focalLength}');
    blog('flashEnergy : ${_exifMetaData.flashEnergy}');
    blog('spatialFrequencyResponse : ${_exifMetaData.spatialFrequencyResponse}');
    blog('focalPlaneXResolution : ${_exifMetaData.focalPlaneXResolution}');
    blog('focalPlaneYResolution : ${_exifMetaData.focalPlaneYResolution}');
    blog('focalPlaneResolutionUnit : ${_exifMetaData.focalPlaneResolutionUnit}');
    blog('subjectLocation : ${_exifMetaData.subjectLocation}');
    blog('exposureIndex : ${_exifMetaData.exposureIndex}');
    blog('sensingMethod : ${_exifMetaData.sensingMethod}');
    blog('fileSource : ${_exifMetaData.fileSource}');
    blog('sceneType : ${_exifMetaData.sceneType}');
    blog('cfaPattern : ${_exifMetaData.cfaPattern}');
    blog('customRendered : ${_exifMetaData.customRendered}');
    blog('exposureMode : ${_exifMetaData.exposureMode}');
    blog('whiteBalance : ${_exifMetaData.whiteBalance}');
    blog('digitalZoomRatio : ${_exifMetaData.digitalZoomRatio}');
    blog('focalLengthIn35mmFilm : ${_exifMetaData.focalLengthIn35mmFilm}');
    blog('sceneCaptureType : ${_exifMetaData.sceneCaptureType}');
    blog('gainControl : ${_exifMetaData.gainControl}');
    blog('contrast : ${_exifMetaData.contrast}');
    blog('saturation : ${_exifMetaData.saturation}');
    blog('sharpness : ${_exifMetaData.sharpness}');
    blog('deviceSettingDescription : ${_exifMetaData.deviceSettingDescription}');
    blog('subjectDistanceRange : ${_exifMetaData.subjectDistanceRange}');
    blog('imageUniqueID : ${_exifMetaData.imageUniqueID}');
  }

  blog('BLOGGING ASSET ------------------------------------------------------- END');
}
 */
// ---------------------------------------
