import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' as image_editor;


class ColorFilterBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ColorFilterBuilder({
    @required this.filterModel,
    @required this.child,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final ColorFilterModel filterModel;
// -----------------------------------------------------------------------------
  static Future<File> processImage({
    @required File input,
    @required ColorFilterModel filterModel,
}) async {

    Uint8List _uint8List = await Imagers.getUint8ListFromFile(input);

    final image_editor.ImageEditorOption option = image_editor.ImageEditorOption();

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

    final File _output = await Imagers.getFileFromUint8List(
        uInt8List: _uint8List,
        fileName: input.path,
    );

    return _output;
  }
// -----------------------------------------------------------------------------
  static Widget _createTree({
    @required Widget child,
    @required List<List<double>> matrixes,
  }){
    Widget tree = child;

    for (int i = 0; i < matrixes.length; i++) {
      tree = ColorFiltered(
        colorFilter: ColorFilter.matrix(matrixes[i]),
        child: tree,
      );
    }

    return tree;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return _createTree(
      child: child,
      matrixes: filterModel.matrixes,
    );
  }
// -----------------------------------------------------------------------------
}
