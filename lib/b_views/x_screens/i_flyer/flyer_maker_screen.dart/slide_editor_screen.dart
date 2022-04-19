import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;

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
// ------------------------------------
  @override
  void initState() {
    _slide = ValueNotifier<MutableSlide>(widget.slide);
    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _onFitTap() async {

    if (_slide.value.picFit == BoxFit.fitWidth){
      _slide.value = _slide.value.updatePicFit(BoxFit.fitHeight);
    }
    else {
      _slide.value = _slide.value.updatePicFit(BoxFit.fitWidth);
    }

  }
// ------------------------------------
  Future<void> _onCropTap() async {
    blog('start cropping');
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
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            onCropTap: _onCropTap,
            onFitTap: _onFitTap,
            onBack: _onBack,
          ),

        ],

      ),
    );
  }
}
