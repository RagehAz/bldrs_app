import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:widget_fader/widget_fader.dart';

class LightSmallFlyer extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const LightSmallFlyer({
    @required this.flyerBoxWidth,
    @required this.onTap,
    @required this.flyerID,
    this.flyerModel,
    this.onMoreTap,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function(FlyerModel flyerModel, BzModel bzModel) onTap;
  final String flyerID;
  final FlyerModel flyerModel;
  final Function onMoreTap;
  // -----------------------------------------------------------------------------
  @override
  State<LightSmallFlyer> createState() => _LightSmallFlyerState();
  // -----------------------------------------------------------------------------
}

class _LightSmallFlyerState extends State<LightSmallFlyer> {
  // -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
  // BzModel _bzModel;
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

        await _prepareModels();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(LightSmallFlyer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (
    oldWidget.flyerID != widget.flyerID ||
    oldWidget.flyerModel != widget.flyerModel
    ) {

      _disposeModels();

      _triggerLoading(setTo: true).then((_) async {
        await _prepareModels();
        await _triggerLoading(setTo: false);
      });

    }

  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _disposeModels();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  ///
  void _disposeModels() {

    // blog('dispose stuff pre mounted');
    //
    // if (mounted == true) {
    //
    //   blog('dispose stuff');
    //
    //   /// DISPOSE FIRST SLIDE
    //   if (Mapper.checkCanLoopList(_flyerModel?.slides) == true) {
    //     blog('xxxxx - === >>> disposing flyer[0] SLIDE IMAGE');
    //     _flyerModel?.slides?.first?.uiImage?.dispose();
    //   }
    //
    //   /// DISPOSE BZ LOGE
    //   blog('xxxxx - === >>> disposing flyer LOGO IMAGE');
    //   _flyerModel?.bzLogoImage?.dispose();
    //
    // }

    FlyerProtocols.disposeRenderedFlyer(
      flyerModel: _flyerModel,
      mounted: mounted,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _prepareModels() async {

    /// GET FLYER MODEL
    FlyerModel _flyer = widget.flyerModel;

    /// OR FETCH FLYER MODEL
    if(mounted){
      _flyer ??= await FlyerProtocols.fetchFlyer(
        context: context,
        flyerID: widget.flyerID,
      );
      _flyer = await FlyerProtocols.renderSmallFlyer(
        context: context,
        flyerModel: _flyer,
      );
    }

    // _flyer?.blogFlyer(invoker: 'LightSmallFlyer');

    if (_flyer != null){

      // /// IMAGIFY FIRST SLIDE
      // if (mounted){
      //   _flyer = await FlyerProtocols.imagifyFirstSlide(_flyer);
      // }

      // /// IMAGIFY BZ LOGO
      // if (mounted){
      //   _flyer = await FlyerProtocols.imagifyBzLogo(_flyer);
      // }

      // /// GET BZ MODEL
      // BzModel _bz;
      // if (mounted){
      //   _bz = await BzProtocols.fetchBz(
      //     context: context,
      //     bzID: _flyer?.bzID,
      //   );
      // }

      /// SET STUFF
      // if (_bz != null && mounted == true) {
        blog('xxxxx - === >>> setting flyer and bz models');
        setState(() {
          _flyerModel = _flyer;
          // _bzModel = _bz;
        });
      // }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget smallFlyer){

          /// LOADING
          if (loading == true){
            return FlyerLoading(
              flyerBoxWidth: widget.flyerBoxWidth,
              animate: true,
              boxColor: widget.flyerModel?.slides?.first?.midColor ?? Colorz.white10,
              direction: Axis.vertical,
            );
          }

          /// LOADED
          else {

            ///  FLYER IS NULL
            if (_flyerModel == null){

              return FlyerBox(
                key: const ValueKey<String>('DummyListSmallFlyer'),
                flyerBoxWidth: widget.flyerBoxWidth,
              );

            }

            /// FLYER IS VIEWABLE
            else {

              return smallFlyer;

            }

          }

        },

      child: WidgetFader(
        fadeType: FadeType.fadeIn,
        duration: const Duration(milliseconds: 200),
        child: FlyerBox(
          key: const ValueKey<String>('LightSmallFlyer'),
          flyerBoxWidth: widget.flyerBoxWidth,
          onTap: () => widget.onTap(_flyerModel, _flyerModel?.bzModel),
          stackWidgets: <Widget>[

            // /// STATIC SINGLE SLIDE
            // LightSlide(
            //   flyerBoxWidth: widget.flyerBoxWidth,
            //   slideModel: _flyerModel?.slides?.first,
            //   isAnimated: true,
            //   // flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(context, widget.flyerBoxWidth),
            //   // tinyMode: false,
            //   // onSlideNextTap: null,
            //   // onSlideBackTap: null,
            //   // onDoubleTap: null,
            // ),

            // if (Mapper.checkCanLoopList(_flyerModel?.slides) == true)
            // AnimateWidgetToMatrix(
            //   matrix: Trinity.renderSlideMatrix(
            //     matrix: _flyerModel?.slides?.first?.matrix,
            //     flyerBoxWidth: widget.flyerBoxWidth,
            //     flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(context, widget.flyerBoxWidth),
            //   ),
            //   child: SuperFilteredImage(
            //     width: widget.flyerBoxWidth,
            //     height: FlyerDim.flyerHeightByFlyerWidth(context, widget.flyerBoxWidth),
            //     pic: _flyerModel?.slides?.first?.uiImage,
            //     filterModel: ImageFilterModel.getFilterByID(_flyerModel?.slides?.first?.filterID),
            //     boxFit: _flyerModel?.slides?.first?.picFit,
            //   ),
            // ),

            SingleSlide(
              key: const ValueKey<String>('SingleSlideImagePart'),
              flyerBoxWidth: widget.flyerBoxWidth,
              flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(context, widget.flyerBoxWidth),
              tinyMode: true,
              slideModel: _flyerModel?.slides?.first,
              onSlideBackTap: () {
                blog('onSlideBackTap');
              },
              onSlideNextTap: () {
                blog('onSlideBackTap');
              },
              onDoubleTap: () {
                blog('onDoubleTap');
              },
              blurLayerIsOn: true,
              slideShadowIsOn: true,
              canTapSlide: false,
              canAnimateMatrix: true,
              canUseFilter: true,
              canPinch: false,
            ),

            /// STATIC HEADER
            StaticHeader(
              flyerBoxWidth: widget.flyerBoxWidth,
              bzModel: _flyerModel?.bzModel,
              // bzImageLogo: _flyerModel?.bzLogoImage,
              authorID: _flyerModel?.authorID,
              flyerShowsAuthor: _flyerModel?.showsAuthor,
              // flightTweenValue: 1,
              // flightDirection: flightDirection,
              // onTap: ,
              // authorImage: _flyerModel?.authorImage,
              bzImageLogo: _flyerModel?.bzLogoImage,
            ),

            /// STATIC FOOTER
            StaticFooter(
              flyerBoxWidth: widget.flyerBoxWidth,
              isSaved: UserModel.checkFlyerIsSaved(
                userModel: UsersProvider.proGetMyUserModel(
                  context: context,
                  listen: true,
                ),
                flyerID: _flyerModel?.id,
              ),
              onMoreTap: widget.onMoreTap,
              flightTweenValue: 0,
            ),

          ],
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
