import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
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
    this.boxFit = BoxFit.cover,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ColorFilterModel filterModel;
  final File imageFile;
  final double width;
  final double height;
  final BoxFit boxFit;
// -----------------------------------------------------------------------------
  static Future<File> processImage({
    @required File input,
    @required ColorFilterModel filterModel,
}) async {

    if (filterModel != null && canLoopList(filterModel.matrixes) == true){

      Uint8List _uint8List = await Imagers.getUint8ListFromFile(input);

      final image_editor.ImageEditorOption option = image_editor.ImageEditorOption();

      blog('processImage : filterModel : ${filterModel.name} : matrixes : ${filterModel.matrixes}');

      final List<double> _combinedMatrix = ColorFilterModel.combineMatrixes(
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

      final File _output = await Imagers.getFileFromUint8List(
        uInt8List: _uint8List,
        fileName: Imagers.getFileNameFromFile(input),
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

    if (canLoopList(matrixes) == true){
      for (int i = 0; i < matrixes.length; i++) {
        tree = ColorFiltered(
          colorFilter: ColorFilter.matrix(matrixes[i]),
          child: tree,
        );
      }
    }

    return tree;
  }

  @override
  State<SuperFilteredImage> createState() => _SuperFilteredImageState();
}

class _SuperFilteredImageState extends State<SuperFilteredImage> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
  }
// -----------------------------------------------------------------------------
  File _file;

  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {

        _file = await SuperFilteredImage.processImage(
            input: widget.imageFile,
            filterModel: widget.filterModel,
        );

        await _triggerLoading();
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool _isLoading, Widget childA){

          if (_isLoading == true){
            return const Loading(loading: true);
          }

          else {
            return SuperFilteredImage._createTree(
              matrixes: widget.filterModel.matrixes,
              child: SuperImage(
                width: widget.width,
                height: widget.height,
                pic: _file,
                fit: widget.boxFit,
              ),
            );
          }

        }
    );

  }
}
