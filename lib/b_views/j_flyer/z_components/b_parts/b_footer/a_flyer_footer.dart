import 'dart:async';

import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/d_flyer_footer_buttons.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/e_db/real/ops/flyer_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooter({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.tinyMode,
    @required this.onSaveFlyer,
    @required this.footerPageController,
    @required this.headerIsExpanded,
    @required this.inFlight,
    @required this.flyerIsSaved,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final bool tinyMode;
  final Function onSaveFlyer;
  final PageController footerPageController;
  final ValueNotifier<bool> headerIsExpanded;
  final bool inFlight;
  final ValueNotifier<bool> flyerIsSaved;
  /// --------------------------------------------------------------------------
  @override
  State<FlyerFooter> createState() => _FlyerFooterState();
  /// --------------------------------------------------------------------------
}

class _FlyerFooterState extends State<FlyerFooter> {
  // -----------------------------------------------------------------------------
  final ScrollController _infoPageVerticalController = ScrollController();
  final ScrollController _reviewPageVerticalController = ScrollController();
  final TextEditingController _reviewTextController = TextEditingController();
  final ValueNotifier<FlyerCounterModel> _flyerCounter = ValueNotifier(null);
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
      blogLoading(loading: _loading.value, callerName: 'FlyerFooter',);
    }
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
    if (_isInit) {
      // ----------
      _triggerLoading(setTo: true).then((_) async {
        // ----------
        if (AuthModel.userIsSignedIn() == true){
          // ----------
          final FlyerCounterModel _counter = await FlyerRecordRealOps.readFlyerCounters(
            context: context,
            flyerID: widget.flyerModel.id,
          );
          // ----------
          setNotifier(
            notifier: _flyerCounter,
            mounted: mounted,
            value: _counter,
            addPostFrameCallBack: false,
          );
          // ----------
        }
        // ----------
        await _triggerLoading(setTo: false);
        // ----------
      });
      // ----------
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _flyerCounter.dispose();
    _infoPageVerticalController.dispose();
    _reviewPageVerticalController.dispose();
    _reviewTextController.dispose();
    _infoButtonExpanded.dispose();
    _canShowConvertibleReviewButton.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _infoButtonExpanded = ValueNotifier(false);
  // --------------------
  Future<void> onInfoButtonTap() async {
    _infoButtonExpanded.value = !_infoButtonExpanded.value;

    if(_infoButtonExpanded.value == false){
      unawaited(
          _infoPageVerticalController.animateTo(0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
          )
      );

      await Future.delayed(const Duration(milliseconds: 200), (){
        _canShowConvertibleReviewButton.value = true;
      });
    }

    if (_infoButtonExpanded.value == true){
      _canShowConvertibleReviewButton.value = false;
    }

    // /// LOAD FLYER COUNTERS
    // if (_infoButtonExpanded.value == true && widget.tinyMode == false){
    //
    //   _flyerCounter.value ??= await FlyerRecordOps.readFlyerCounters(
    //         context: context,
    //         flyerID: widget.flyerModel.id,
    //     );
    //
    //
    // }

  }
  // --------------------
  final ValueNotifier<bool> _canShowConvertibleReviewButton = ValueNotifier(true);
  // --------------------
  bool _canShowInfoButtonChecker(InfoButtonType infoButtonType){
    bool _canShow = true;

    if (widget.tinyMode == true || widget.inFlight == true){
      if (infoButtonType == InfoButtonType.info){
        _canShow = false;
      }
    }

    return _canShow;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const InfoButtonType _infoButtonType = InfoButtonType.info;
    // --------------------
    return ValueListenableBuilder(
      key: const ValueKey<String>('FlyerFooter'),
      valueListenable: widget.headerIsExpanded,
      builder: (_, bool _headerIsExpanded, Widget footerWidgets){

        return AnimatedOpacity(
          opacity: _headerIsExpanded ? 0 : 1,
          duration: Ratioz.duration150ms,
          child: footerWidgets,
        );

      },
      child: FooterBox(
        flyerBoxWidth: widget.flyerBoxWidth,
        footerPageController: widget.footerPageController,
        infoButtonExpanded: _infoButtonExpanded,
        footerPageViewChildren: <Widget>[

          /// FOOTER
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[

              // /// BOTTOM SHADOW
              // FooterShadow(
              //   key: const ValueKey<String>('FooterShadow'),
              //   flyerBoxWidth: widget.flyerBoxWidth,
              // ),

              /// FOOTER BUTTONS
              // if (widget.tinyMode == false)// && widget.inFlight == false)
              FlyerFooterButtons(
                key: const ValueKey<String>('FooterButtons'),
                flyerModel: widget.flyerModel,
                flyerBoxWidth: widget.flyerBoxWidth,
                tinyMode: widget.tinyMode,
                onSaveFlyer: widget.onSaveFlyer,
                inFlight: widget.inFlight,
                infoButtonType: _infoButtonType,
                flyerIsSaved: widget.flyerIsSaved,
                flyerCounter: _flyerCounter,
              ),

              /// INFO BUTTON
              if (_canShowInfoButtonChecker(_infoButtonType) == true)
                InfoButtonStarter(
                  flyerBoxWidth: widget.flyerBoxWidth,
                  flyerModel: widget.flyerModel,
                  tinyMode: widget.tinyMode,
                  infoButtonExpanded: _infoButtonExpanded,
                  onInfoButtonTap: onInfoButtonTap,
                  infoButtonType: _infoButtonType,
                  infoPageVerticalController: _infoPageVerticalController,
                  inFlight: widget.inFlight,
                  flyerCounter: _flyerCounter,
                ),

              // /// CONVERTIBLE REVIEW BUTTON
              // if (widget.tinyMode == false && widget.inFlight == false)
              // ConvertibleReviewPagePreStarter(
              //   infoButtonExpanded: _infoButtonExpanded,
              //   canShowConvertibleReviewButton: _canShowConvertibleReviewButton,
              //   flyerBoxWidth: widget.flyerBoxWidth,
              //   tinyMode: widget.tinyMode,
              //   onReviewButtonTap: onReviewButtonTap,
              //   reviewButtonExpanded: _reviewButtonExpanded,
              //   reviewPageVerticalController: _reviewPageVerticalController,
              //   inFlight: widget.inFlight,
              //   onEditReview: _onEditReview,
              //   isEditingReview: _isEditingReview,
              //   onSubmitReview: _onSubmitReview,
              //   reviewTextController: _reviewTextController,
              //   onShowReviewOptions: _onShowReviewOptions,
              //   flyerID: widget.flyerModel.id,
              // ),

            ],
          ),

          /// FAKE PAGE TO SLIDE FOOTER WHEN OUT OF SLIDES EXTENTS
          const SizedBox(),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
