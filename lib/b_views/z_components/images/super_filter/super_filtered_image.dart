import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' as image_editor;

class SuperFilteredImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperFilteredImage({
    @required this.filterModel,
    @required this.width,
    @required this.height,
    @required this.pic,
    // this.opacity,
    this.boxFit = BoxFit.cover,
    this.scale = 1,
    this.canUseFilter = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ImageFilterModel filterModel;
  final double width;
  final double height;
  final dynamic pic;
  // final ValueNotifier<double> opacity;
  final BoxFit boxFit;
  final double scale;
  final bool canUseFilter;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (canUseFilter == true && filterModel != null && pic != null) {
      return _FilteredImage(
        // opacity: opacity,
        height: height,
        pic: pic,
        width: width,
        scale: scale,
        boxFit: boxFit,
        filterModel: filterModel,
      );
    }

    else {

      return OldSuperImage(
        width: width,
        height: height,
        pic: pic,
        fit: boxFit,
        scale: scale,
      );

    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}


class _FilteredImage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _FilteredImage({
    // @required this.bytes,
    @required this.filterModel,
    @required this.width,
    @required this.height,
    // @required this.opacity,
    @required this.boxFit ,
    @required this.scale,
    @required this.pic,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  // final Uint8List bytes;
  final ImageFilterModel filterModel;
  final double width;
  final double height;
  final BoxFit boxFit;
  // final ValueNotifier<double> opacity;
  final double scale;
  final dynamic pic;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<ui.Image> processImage({
    @required dynamic input,
    @required ImageFilterModel filterModel,
  }) async {

    ui.Image _output = input is Uint8List ?
    await Floaters.getUiImageFromUint8List(input) : input;


    if (filterModel != null && Mapper.checkCanLoopList(filterModel.matrixes) == true){

      final image_editor.ImageEditorOption option = image_editor.ImageEditorOption();

      // blog('processImage : filterModel : ${filterModel.id} : matrixes : ${filterModel.matrixes}');

      final List<double> _combinedMatrix = ImageFilterModel.combineMatrixes(
        matrixes: filterModel.matrixes,
      );

      option.addOption(
          image_editor.ColorOption(
              matrix: _combinedMatrix
          ),
      );

      if (_output != null){
        final Uint8List _bytes = await image_editor.ImageEditor.editImage(
          image: await Floaters.getUint8ListFromUiImage(input),
          imageEditorOption: option,
        );

        if (_bytes != null){
          _output = await Floaters.getUiImageFromUint8List(_bytes);
        }

      }

      // blog('processImage : uint8list is : ${input?.length} bytes');

      return _output;
    }

    else {
      return _output;
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Widget _createTree({
    @required Widget child,
    @required List<List<double>> matrixes,
  }){
    Widget tree = child;

    if (Mapper.checkCanLoopList(matrixes) == true){
      for (int i = 0; i < matrixes.length; i++) {
        tree = ColorFiltered(
          colorFilter: ColorFilter.matrix(matrixes[i]),
          child: tree,
        );
      }
    }

    return tree;
  }
  // -----------------------------------------------------------------------------
  @override
  State<_FilteredImage> createState() => _FilteredImageState();
  // -----------------------------------------------------------------------------
}

class _FilteredImageState extends State<_FilteredImage> {
  // -----------------------------------------------------------------------------
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

    // _uiImage = widget.pic;
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      if (widget.filterModel != null){

        _triggerLoading(setTo: true).then((_) async {

          final ui.Image uiImage = await _FilteredImage.processImage(
            input: widget.pic,
            filterModel: widget.filterModel,
          );

          if (mounted){
            setState(() {
              _uiImage = uiImage;
            });
          }

          await _triggerLoading(setTo: false);
        });

      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant _FilteredImage oldWidget) {

     bool _bytesAreIdentical;

    if (widget.pic is Uint8List && oldWidget.pic is Uint8List){
      _bytesAreIdentical = Mapper.checkListsAreIdentical(
        list1: widget.pic,
        list2: oldWidget.pic,
      );
    }

    else if (widget.pic is ui.Image && oldWidget.pic is ui.Image){
      _bytesAreIdentical = Floaters.checkUiImagesAreIdentical(widget.pic, oldWidget.pic);
    }

    else {
      _bytesAreIdentical = false;
    }

    if (
    widget.width != oldWidget.width ||
    widget.height != oldWidget.height ||
    _bytesAreIdentical == false ||
    // widget.opacity != oldWidget.opacity ||
    widget.scale != oldWidget.scale ||
    widget.boxFit != oldWidget.boxFit ||
    ImageFilterModel.checkFiltersAreIdentical(filter1: widget.filterModel, filter2: oldWidget.filterModel) == false
    ) {

      unawaited(getUiImageFromDynamic(widget.pic).then((ui.Image uiImage){
        if (mounted == true){
          setState(() {
            _uiImage = uiImage;
          });
        }
      }));

    }

    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  @override
  void dispose(){
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<ui.Image> getUiImageFromDynamic(dynamic pic) async {

    assert(pic is Uint8List || pic is ui.Image || pic == null, 'Pic is neither Bytes nor UiImage nor null');

    if (pic is Uint8List){

      return Floaters.getUiImageFromUint8List(pic);
    }

    else {
      return pic;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (_uiImage == null){
      return OldSuperImage(
        width: widget.width,
        height: widget.height,
        pic: widget.pic,
        fit: widget.boxFit,
        scale: widget.scale,
      );
    }

    else {
      return _FilteredImage._createTree(
        matrixes: widget.filterModel?.matrixes,
        child: OldSuperImage(
          width: widget.width,
          height: widget.height,
          pic: _uiImage,
          fit: widget.boxFit,
          scale: widget.scale,
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------
}
