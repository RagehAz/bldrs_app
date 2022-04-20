import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as imageLib;

class SlideEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorScreen({
    @required this.slide,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final MutableSlide slide;
  /// --------------------------------------------------------------------------
  @override
  State<SlideEditorScreen> createState() => _SlideEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _SlideEditorScreenState extends State<SlideEditorScreen> {

// -----------------------------------------------------------------------------
  ValueNotifier<MutableSlide> _slide;
  TransformationController _transformationController;
  final ValueNotifier<Matrix4> _matrix = ValueNotifier(Matrix4.identity());
  final ValueNotifier<bool> _isFlipped = ValueNotifier(false);
// ------------------------------------
  @override
  void initState() {
    _transformationController = TransformationController();

    _transformationController.addListener(() {

      blog('transformation Controller : ${_transformationController.value}');

    });

    _slide = ValueNotifier<MutableSlide>(widget.slide);
    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _onResetTap() async {

    // if (_slide.value.picFit == BoxFit.fitWidth){
    //   _slide.value = _slide.value.updatePicFit(BoxFit.fitHeight);
    // }
    // else {
    //   _slide.value = _slide.value.updatePicFit(BoxFit.fitWidth);
    // }

    _matrix.value = Matrix4.identity();

  }

  Future<void> _onFlip() async {
    _isFlipped.value = !_isFlipped.value;

    final double _angle = _isFlipped.value == true ?
    degreeToRadian(180)
        :
    degreeToRadian(0)
    ;

    blog('flipping to angle $_angle :\n${_matrix.value}');
    final Matrix4 _newMatrix = Matrix4.copy(_matrix.value);//;

    _newMatrix.rotateY(_angle);
    // _newMatrix.
    blog('flipping to angle $_angle :\n${_matrix.value}\nnew matrix \n$_newMatrix');


    _matrix.value = _newMatrix;
  }
// ------------------------------------
  Future<void> _onEditorTap() async {
    // blog('start cropping');

    // imageLib.Image image = imageLib.decodeImage(await _slide.value.picFile.readAsBytes());
    // image = imageLib.copyResize(image, width: 600);

    await goToNewScreen(context, ImageEditor(
      image: await Imagers.getUint8ListFromFile(_slide.value.picFile),
      allowCamera: false,
      allowGallery: false,
      allowMultiple: false,
      maxLength: 20,
      appBar: Colorz.skyDarkBlue,
    )
    );

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<int> _filterIndex = ValueNotifier(0);
  void _onSwipe(int index){
    _filterIndex.value = index;
  }

  void _onBack(){
    goBack(context, argument: _slide.value);
  }
// -----------------------------------------------------------------------------
  static const List<BlendMode> _modes = <BlendMode>[
    BlendMode.clear,
    BlendMode.color,
    BlendMode.clear,
    BlendMode.colorBurn,
    BlendMode.screen,
    BlendMode.colorDodge,
    BlendMode.darken,
    BlendMode.difference,
    BlendMode.dst,
    BlendMode.dstATop,
    BlendMode.dstIn,
    BlendMode.dstOut,
    BlendMode.dstOver,
    BlendMode.exclusion,
    BlendMode.hardLight,
    BlendMode.hue,
    BlendMode.lighten,
    BlendMode.luminosity,
    BlendMode.modulate,
    BlendMode.multiply,
    BlendMode.overlay,
    BlendMode.plus,
    BlendMode.saturation,
    BlendMode.softLight,
    BlendMode.src,
    BlendMode.srcATop,
    BlendMode.srcIn,
    BlendMode.srcOut,
    BlendMode.srcOver,
    BlendMode.xor,
  ];
  int _blendIndex = 0;
  final ValueNotifier<BlendMode> _blendMode = ValueNotifier(BlendMode.clear);
  void _onBlend(){

    _blendIndex++;
    if (_blendIndex == _modes.length){
      _blendIndex = 0;
    }

    _blendMode.value = _modes[_blendIndex];
  }
// -----------------------------------------------------------------------------
  static const List<Color> _colors = <Color>[
    Colorz.nothing,
    Colorz.white10,
    Colorz.white20,
    Colorz.white50,
    Colorz.white80,
    Colorz.black0,
    Colorz.black10,
    Colorz.black20,
    Colorz.black50,
    Colorz.black80,
  ];
  final ValueNotifier<Color> _color = ValueNotifier(Colorz.nothing);
  int _colorIndex = 0;
  void _onColor(){
    _colorIndex++;
    if (_colorIndex == _colors.length){
      _colorIndex = 0;
    }

    _color.value = _colors[_colorIndex];

    blog('color has become $_colorIndex : ${_color.value}');
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, _screenHeight);
    final double _controlPanelHeight = SlideEditorControlPanel.getControlPanelHeight(context, _screenHeight);

    return MainLayout(
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarType: AppBarType.non,
      layoutWidget: Column(

        children: <Widget>[

          /// SLIDE
          SlideEditorSlidePart(
            height: _slideZoneHeight,
            slide: _slide,
            transformationController: _transformationController,
            matrix: _matrix,
            onSwipe: _onSwipe,
            filterIndex: _filterIndex,
            blendMode: _blendMode,
            color: _color,
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            onEditorTap: _onEditorTap,
            onReset: _onResetTap,
            onFlip: _onFlip,
            onBack: _onBack,
            onBlend: _onBlend,
            onColor: _onColor,
          ),

        ],

      ),
    );
  }
}
