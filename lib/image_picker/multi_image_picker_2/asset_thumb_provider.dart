import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui show instantiateImageCodec, Codec;
import 'package:bldrs/image_picker/multi_image_picker_2/multi_image_picker2.dart';

class AssetThumbImageProvider extends ImageProvider<AssetThumbImageProvider> {

  const AssetThumbImageProvider(
      this.asset, {
        @required this.width,
        @required this.height,
        this.quality = 100,
        this.scale = 1.0,
      });

  final Asset asset;

  final int width;

  final int height;

  final int quality;

  final double scale;

  @override
  ImageStreamCompleter load(
      AssetThumbImageProvider key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: key.scale,
      informationCollector: () sync* {
        yield DiagnosticsProperty<ImageProvider>(
          'AssetThumbImageProvider: $this \n Image key: $key',
          this,
          style: DiagnosticsTreeStyle.errorProperty,
        );
      },
    );
  }

  Future<ui.Codec> _loadAsync(AssetThumbImageProvider key) async {

    assert(key == this , 'asset thumb provider : _loadAsync : key != this ');

    final ByteData data = await key.asset
        .getThumbByteData(key.width, key.height, quality: key.quality);
    final bytes = data.buffer.asUint8List();

    return ui.instantiateImageCodec(bytes);
  }

  @override
  Future<AssetThumbImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<AssetThumbImageProvider>(this);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final AssetThumbImageProvider typedOther = other;
    return asset.identifier == typedOther.asset.identifier &&
        scale == typedOther.scale &&
        width == typedOther.width &&
        height == typedOther.height &&
        quality == typedOther.quality;
  }

  @override
  int get hashCode =>
      hashValues(asset.identifier, scale, width, height, quality);

  @override
  String toString() => '$runtimeType(${asset.identifier}, scale: $scale, '
      'width: $width, height: $height, quality: $quality)';
}
