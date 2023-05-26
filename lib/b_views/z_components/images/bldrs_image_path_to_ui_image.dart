import 'dart:ui' as ui;
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

class BldrsImagePathToUiImage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsImagePathToUiImage({
    @required this.imagePath,
    @required this.builder,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String imagePath;
  final Function(bool isLoading, ui.Image uiImage) builder;
  /// --------------------------------------------------------------------------
  @override
  _BldrsImagePathToUiImageState createState() => _BldrsImagePathToUiImageState();
  /// --------------------------------------------------------------------------
}

class _BldrsImagePathToUiImageState extends State<BldrsImagePathToUiImage> {
  // -----------------------------------------------------------------------------
  bool _isFetching = true;
  ui.Image _uiImage;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
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

      _triggerLoading(setTo: true).then((_) async {

        final ui.Image _image = await PicProtocols.fetchPicUiImage(
          path: widget.imagePath,
        );

        if (mounted == true){
          setState(() {
            _uiImage = _image;
            _isFetching = false;
          });
        }

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
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
    _loading.dispose();
    // _uiImage?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return widget.builder(_isFetching, _uiImage);
    // --------------------
  }
// -----------------------------------------------------------------------------
}
