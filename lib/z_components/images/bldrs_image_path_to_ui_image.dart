import 'dart:ui' as ui;
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:flutter/material.dart';

class BldrsImagePathToUiImage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsImagePathToUiImage({
    required this.imagePath,
    required this.builder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? imagePath;
  final Function(bool isLoading, ui.Image? uiImage) builder;
  /// --------------------------------------------------------------------------
  @override
  _BldrsImagePathToUiImageState createState() => _BldrsImagePathToUiImageState();
  /// --------------------------------------------------------------------------
}

class _BldrsImagePathToUiImageState extends State<BldrsImagePathToUiImage> {
  // -----------------------------------------------------------------------------
  bool _isLoading = true;
  ui.Image? _uiImage;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        if (_isLoading == false && mounted == true){
          setState(() {
            _isLoading = true;
          });
        }

        final ui.Image? _image = await PicProtocols.fetchPicUiImage(
          path: widget.imagePath,
        );

        if (mounted == true){
          setState(() {
            _uiImage = _image;
            _isLoading = false;
          });
        }

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(BldrsImagePathToUiImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {

      _isInit = true;
      didChangeDependencies();

    }
  }
  // --------------------
  @override
  void dispose() {
    // _uiImage?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return widget.builder(_isLoading, _uiImage);
    // --------------------
  }
// -----------------------------------------------------------------------------
}
