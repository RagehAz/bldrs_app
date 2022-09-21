import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' as image_editor;

class SuperFilteredImage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperFilteredImage({
    @required this.filterModel,
    @required this.imageFile,
    @required this.width,
    @required this.height,
    this.opacity,
    this.boxFit = BoxFit.cover,
    this.scale = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ImageFilterModel filterModel;
  final File imageFile;
  final double width;
  final double height;
  final BoxFit boxFit;
  final ValueNotifier<double> opacity;
  final double scale;
  // -----------------------------------------------------------------------------
  static Future<File> processImage({
    @required File input,
    @required ImageFilterModel filterModel,
  }) async {

    if (filterModel != null && Mapper.checkCanLoopList(filterModel.matrixes) == true){

      Uint8List _uint8List = await Floaters.getUint8ListFromFile(input);

      final image_editor.ImageEditorOption option = image_editor.ImageEditorOption();

      blog('processImage : filterModel : ${filterModel.id} : matrixes : ${filterModel.matrixes}');

      final List<double> _combinedMatrix = ImageFilterModel.combineMatrixes(
        matrixes: filterModel.matrixes,
      );

      option.addOption(
          image_editor.ColorOption(
              matrix: _combinedMatrix
          )
      );

      _uint8List = await image_editor.ImageEditor.editImage(
        image: _uint8List,
        imageEditorOption: option,
      );

      blog('processImage : uint7list is : $_uint8List');

      final File _output = await Filers.getFileFromUint8List(
        uInt8List: _uint8List,
        fileName: Filers.getFileNameFromFile(
          file: input,
          withExtension: true,
        ),
      );


      return _output;
    }

    else {
      return input;
    }
  }
  // -----------------------------------------------------------------------------
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
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SuperFilteredImage',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _file = widget.imageFile;
  }
  // --------------------
  @override
  void dispose(){
    _loading.dispose();
    super.dispose();
  }
  // --------------------
  File _file;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      if (widget.filterModel != null){

        _triggerLoading().then((_) async {

          _file = await SuperFilteredImage.processImage(
            input: widget.imageFile,
            filterModel: widget.filterModel,
          );

          await _triggerLoading();
        });

      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant SuperFilteredImage oldWidget) {

    final bool _filesAreIdentical = Filers.checkFilesAreIdentical(
      file1: widget.imageFile,
      file2: oldWidget.imageFile,
    );

    if (_filesAreIdentical == false) {
      setState(() {
        _file = widget.imageFile;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.filterModel == null){
      return SuperImage(
        width: widget.width,
        height: widget.height,
        pic: widget.imageFile,
        boxFit: widget.boxFit,
      );
    }

    else {
      return ValueListenableBuilder(
          valueListenable: _loading,
          builder: (_, bool _isLoading, Widget childA){

            if (_isLoading == true){
              return FlyerLoading(
                flyerBoxWidth: widget.width,
              );
            }

            else if (widget.opacity == null){
              return SuperFilteredImage._createTree(
                matrixes: widget.filterModel.matrixes,
                child: SuperImage(
                  width: widget.width,
                  height: widget.height,
                  pic: _file,
                  boxFit: widget.boxFit,
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
                  pic: _file,
                  boxFit: widget.boxFit,
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
