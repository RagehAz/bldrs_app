import 'dart:typed_data';
import 'package:bldrs/b_views/z_components/images/super_image/c_infinity_loading_box.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:flutter/material.dart';

class FutureImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FutureImage({
    @required this.snapshot,
    @required this.width,
    @required this.height,
    @required this.boxFit,
    @required this.errorBuilder,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AsyncSnapshot<Uint8List> snapshot;
  final double width;
  final double height;
  final BoxFit boxFit;
  final Function(BuildContext, Object, StackTrace) errorBuilder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// LOADING
    if (Streamer.connectionIsLoading(snapshot) == true){
      return InfiniteLoadingBox(
        width: width,
        height: height,
      );
    }

    /// UI.IMAGE
    else {

      return Image.memory(
        snapshot.data,
        fit: boxFit,
        width: width,
        height: height,
        errorBuilder: errorBuilder,
        // scale: 1,
      );
    }

  }
/// --------------------------------------------------------------------------
}
