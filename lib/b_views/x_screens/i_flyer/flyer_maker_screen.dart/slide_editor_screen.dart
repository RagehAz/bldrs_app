import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
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
  void _onBack(){
    goBack(context, argument: _slide.value);
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
            isFlipped: _isFlipped,
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            onEditorTap: _onEditorTap,
            onReset: _onResetTap,
            onFlip: _onFlip,
            onBack: _onBack,
          ),

        ],

      ),
    );
  }
}
