import 'dart:async';

import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/d_flyer_footer_buttons.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/top_button/top_button.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooter({
    required this.flyerBoxWidth,
    required this.flyerModel,
    required this.tinyMode,
    required this.onSaveFlyer,
    required this.footerPageController,
    required this.headerIsExpanded,
    required this.inFlight,
    required this.flyerIsSaved,
    required this.infoButtonExpanded,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel? flyerModel;
  final bool tinyMode;
  final Function onSaveFlyer;
  final PageController footerPageController;
  final ValueNotifier<bool> headerIsExpanded;
  final bool inFlight;
  final ValueNotifier<bool> flyerIsSaved;
  final ValueNotifier<bool?> infoButtonExpanded;
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
  final ValueNotifier<FlyerCounterModel?> _flyerCounter = ValueNotifier(null);
  final ValueNotifier<bool> _isSharing = ValueNotifier(false);
  // --------------------
  final ValueNotifier<bool> _canShowConvertibleReviewButton = ValueNotifier(true);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
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
      _isInit = false; // good
      // ----------
      _triggerLoading(setTo: true).then((_) async {
        // ----------
        if (Authing.userHasID() == true){
          // ----------
          final FlyerCounterModel? _counter = await RecorderProtocols.fetchFlyerCounters(
            flyerID: widget.flyerModel?.id,
            bzID: widget.flyerModel?.bzID,
            forceRefetch: false,
          );
          // ----------
          setNotifier(
            notifier: _flyerCounter,
            mounted: mounted,
            value: _counter,
          );
          // ----------
        }
        // ----------
        await _triggerLoading(setTo: false);
        // ----------
      });
      // ----------
    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _flyerCounter.dispose();
    _infoPageVerticalController.dispose();
    _reviewPageVerticalController.dispose();
    _reviewTextController.dispose();
    _canShowConvertibleReviewButton.dispose();
    _loading.dispose();
    _isSharing.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> onInfoButtonTap() async {

    setNotifier(
        notifier: widget.infoButtonExpanded,
        mounted: mounted,
        value: !Mapper.boolIsTrue(widget.infoButtonExpanded.value),
    );

    if(widget.infoButtonExpanded.value  == false){
      unawaited(
          _infoPageVerticalController.animateTo(0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
          )
      );

      await Future.delayed(const Duration(milliseconds: 200), (){
        setNotifier(
            notifier: _canShowConvertibleReviewButton,
            mounted: mounted,
            value: true,
        );
      });

    }

    if (Mapper.boolIsTrue(widget.infoButtonExpanded.value)  == true){
      setNotifier(
        notifier: _canShowConvertibleReviewButton,
        mounted: mounted,
        value: false,
      );
    }

    // /// LOAD FLYER COUNTERS
    // if (_infoButtonExpanded.value  == true && widget.tinyMode == false){
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
      builder: (_, bool _headerIsExpanded, Widget? footerWidgets){

        return AnimatedOpacity(
          opacity: _headerIsExpanded ? 0 : 1,
          duration: Ratioz.duration150ms,
          child: footerWidgets,
        );

      },
      child: FooterBox(
        flyerBoxWidth: widget.flyerBoxWidth,
        footerPageController: widget.footerPageController,
        infoButtonExpanded: widget.infoButtonExpanded,
        showTopButton: checkCanShowTopButton(flyerModel: widget.flyerModel),
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
                isSharing: _isSharing,
              ),

              /// INFO BUTTON
              if (_canShowInfoButtonChecker(_infoButtonType) == true)
                InfoButtonStarter(
                  flyerBoxWidth: widget.flyerBoxWidth,
                  flyerModel: widget.flyerModel,
                  tinyMode: widget.tinyMode,
                  infoButtonExpanded: widget.infoButtonExpanded,
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
