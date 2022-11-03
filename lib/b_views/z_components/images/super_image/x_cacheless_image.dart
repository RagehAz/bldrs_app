import 'dart:typed_data';

import 'package:bldrs/b_views/z_components/images/super_image/x_infinity_loading_box.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// DOES NOT CACHE IMAGE
class CachelessImage extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const CachelessImage({
    @required this.bytes,
    @required this.width,
    @required this.height,
    this.boxFit = BoxFit.cover,
    this.scale = 1,
    this.opacity,
    this.color,
    this.blendMode,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Uint8List bytes;
  final double width;
  final double height;
  final double scale;
  final Animation<double> opacity;
  final Color color;
  final BlendMode blendMode;
  final BoxFit boxFit;
  // -----------------------------------------------------------------------------
  @override
  _CachelessImageState createState() => _CachelessImageState();
  // -----------------------------------------------------------------------------
}

class _CachelessImageState extends State<CachelessImage> {
  // -----------------------------------------------------------------------------
  ui.Image _image;
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

      if (Mapper.checkCanLoopList(widget.bytes) == true){
        _triggerLoading(setTo: true).then((_) async {

          await loadImage();

          await _triggerLoading(setTo: false);
        });
      }

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant CachelessImage oldWidget) {

    final bool _areIdentical = Mapper.checkListsAreIdentical(
        list1: oldWidget.bytes,
        list2: widget.bytes,
    );

    if (
        _areIdentical == false ||
        widget.width != oldWidget.width ||
        widget.height != oldWidget.height ||
        widget.scale != oldWidget.scale ||
        widget.opacity != oldWidget.opacity ||
        widget.color != oldWidget.color ||
        widget.blendMode != oldWidget.blendMode ||
        widget.boxFit != oldWidget.boxFit
    ){

      _triggerLoading(setTo: true).then((_) async {

        await loadImage();

        await _triggerLoading(setTo: false);
      });

    }

    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  @override
  void dispose() {
    if (_image != null){
      _image.dispose();
    }
    _loading.dispose();
    super.dispose();
  }
  // --------------------
  Future<void> loadImage() async {

    final ui.Image _theImage = await Floaters.getUiImageFromUint8List(widget.bytes);

    if (mounted == true){
      setState(() {
        _image = _theImage;
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// IMAGE IS EMPTY
    if (Mapper.checkCanLoopList(widget.bytes) == false){
      return Container(
        width: widget.width,
        height: widget.height,
        color: widget.color,
      );
    }

    /// IMAGE CAN BE BUILT
    else {
      return ValueListenableBuilder(
        key: const ValueKey('CachelessImage'),
        valueListenable: _loading,
        builder: (_, bool loading, Widget child){

          if (loading == true){
            return InfiniteLoadingBox(
              width: widget.width,
              height: widget.height,
              color: widget.color,
            );
          }

          else {
            return child;
          }

        },
        child: RawImage(
          /// MAIN
          // key: ,
          // debugImageLabel: ,

          /// IMAGE
          image: _image,
          // repeat: ImageRepeat.noRepeat, // DEFAULT

          /// SIZES
          width: widget.width,
          height: widget.height,
          scale: widget.scale,

          /// COLORS
          // color: widget.color,
          opacity: widget.opacity,
          colorBlendMode: widget.blendMode,
          // filterQuality: FilterQuality.low, // DEFAULT
          // invertColors: false, // DEFAULT

          /// POSITIONING
          // alignment: Alignment.center, // DEFAULT
          fit: widget.boxFit,

          /// DUNNO
          // centerSlice: ,
          // isAntiAlias: ,
          // matchTextDirection: false, // DEFAULT : flips image horizontally
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------
}
