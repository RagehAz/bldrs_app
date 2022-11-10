import 'dart:typed_data';

import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' as image_editor;

class SuperFilteredImage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperFilteredImage({
    @required this.filterModel,
    @required this.bytes,
    @required this.width,
    @required this.height,
    this.opacity,
    this.boxFit = BoxFit.cover,
    this.scale = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ImageFilterModel filterModel;
  final Uint8List bytes;
  final double width;
  final double height;
  final BoxFit boxFit;
  final ValueNotifier<double> opacity;
  final double scale;
  // -----------------------------------------------------------------------------
  ///
  static Future<Uint8List> processImage({
    @required Uint8List input,
    @required ImageFilterModel filterModel,
  }) async {

    Uint8List _output = input;

    if (filterModel != null && Mapper.checkCanLoopList(filterModel.matrixes) == true){

      final image_editor.ImageEditorOption option = image_editor.ImageEditorOption();

      blog('processImage : filterModel : ${filterModel.id} : matrixes : ${filterModel.matrixes}');

      final List<double> _combinedMatrix = ImageFilterModel.combineMatrixes(
        matrixes: filterModel.matrixes,
      );

      option.addOption(
          image_editor.ColorOption(
              matrix: _combinedMatrix
          ),
      );

      if (_output?.isNotEmpty == true){
        _output = await image_editor.ImageEditor.editImage(
          image: input,
          imageEditorOption: option,
        );

      }

      blog('processImage : uint8list is : ${input?.length} bytes');

      return _output;
    }

    else {
      return _output;
    }

  }
  // -----------------------------------------------------------------------------
  ///
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
  State<SuperFilteredImage> createState() => _SuperFilteredImageState();
  // -----------------------------------------------------------------------------
}

class _SuperFilteredImageState extends State<SuperFilteredImage> {
  // -----------------------------------------------------------------------------
  Uint8List _bytes;
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
    _bytes = widget.bytes;
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      if (widget.filterModel != null){

        _triggerLoading(setTo: true).then((_) async {

          _bytes = await SuperFilteredImage.processImage(
            input: widget.bytes,
            filterModel: widget.filterModel,
          );

          await _triggerLoading(setTo: false);
        });

      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant SuperFilteredImage oldWidget) {

    final bool _bytesAreIdentical = Mapper.checkListsAreIdentical(
        list1: widget.bytes,
        list2: oldWidget.bytes,
    );

    if (
    widget.width != oldWidget.width ||
    widget.height != oldWidget.height ||
    _bytesAreIdentical == false ||
    widget.opacity != oldWidget.opacity ||
    widget.scale != oldWidget.scale ||
    widget.boxFit != oldWidget.boxFit ||
    ImageFilterModel.checkFiltersAreIdentical(filter1: widget.filterModel, filter2: oldWidget.filterModel) == false
    ) {
      setState(() {
        _bytes = widget.bytes;
      });
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
  @override
  Widget build(BuildContext context) {

    if (widget.filterModel == null){
      return SuperImage(
        width: widget.width,
        height: widget.height,
        pic: widget.bytes,
        fit: widget.boxFit,
      );
    }

    else {
      return ValueListenableBuilder(
          valueListenable: _loading,
          builder: (_, bool _isLoading, Widget childA){

            if (_isLoading == true){
              return FlyerLoading(
                flyerBoxWidth: widget.width,
                animate: true,
              );
            }

            else if (widget.opacity == null){
              return SuperFilteredImage._createTree(
                matrixes: widget.filterModel.matrixes,
                child: SuperImage(
                  width: widget.width,
                  height: widget.height,
                  pic: _bytes,
                  fit: widget.boxFit,
                ),
              );

            }

            else {
              return ValueListenableBuilder(
                valueListenable: widget.opacity,
                builder: (_, double _opacity, Widget child){

                  return Stack(
                    children: <Widget>[

                      child,

                      Opacity(
                        opacity: _opacity,
                        child: SuperFilteredImage._createTree(
                          matrixes: widget.filterModel.matrixes,
                          child: child,
                        ),
                      ),

                    ],
                  );

                },
                child: SuperImage(
                  width: widget.width,
                  height: widget.height,
                  pic: _bytes,
                  fit: widget.boxFit,
                  scale: widget.scale,
                ),
              );
            }

          }
      );
    }

  }
  // -----------------------------------------------------------------------------
}
