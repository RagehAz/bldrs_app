import 'dart:async';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/review_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/d_footer_buttons.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/a_convertible_review_page_pre_starter.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooter({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    @required this.tinyMode,
    @required this.onSaveFlyer,
    @required this.flyerIsSaved,
    @required this.footerPageController,
    @required this.headerIsExpanded,
    @required this.inFlight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;
  final bool tinyMode;
  final Function onSaveFlyer;
  final ValueNotifier<bool> flyerIsSaved;
  final PageController footerPageController;
  final ValueNotifier<bool> headerIsExpanded;
  final bool inFlight;

  @override
  State<FlyerFooter> createState() => _FlyerFooterState();
}

class _FlyerFooterState extends State<FlyerFooter> {

  ScrollController _infoPageVerticalController;
  ScrollController _reviewPageVerticalController;
  TextEditingController _reviewTextController;

  @override
  void initState() {
    _infoPageVerticalController = ScrollController();
    _reviewPageVerticalController = ScrollController();
    _reviewTextController = TextEditingController();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    disposeScrollControllerIfPossible(_infoPageVerticalController);
    disposeScrollControllerIfPossible(_reviewPageVerticalController);
    disposeControllerIfPossible(_reviewTextController);
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _onShareFlyer(){
    blog('SHARE FLYER NOW');
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _infoButtonExpanded = ValueNotifier(false);
// ----------------------------------------
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
      _reviewButtonExpanded.value = false;
      _canShowConvertibleReviewButton.value = false;
    }

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _reviewButtonExpanded = ValueNotifier(false);
  final ValueNotifier<bool> _canShowConvertibleReviewButton = ValueNotifier(true);
// ----------------------------------------
  void onReviewButtonTap(){
    _reviewButtonExpanded.value = !_reviewButtonExpanded.value;
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isEditingReview = ValueNotifier(false);
  void _onEditReview(){
    blog('onEditReview');
    _isEditingReview.value = !_isEditingReview.value;
  }
// -----------------------------------------------------------------------------
  void _onSubmitReview(){
    blog('_onSubmitReview : ${_reviewTextController.text}');
  }
// -----------------------------------------------------------------------------
  void _onShowReviewOptions(ReviewModel reviewModel){
    blog('_onShowReviewOptions : $reviewModel');
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const InfoButtonType _infoButtonType = InfoButtonType.price;

    return ValueListenableBuilder(
      valueListenable: widget.headerIsExpanded,
      builder: (_, bool _headerIsExpanded, Widget child){

        return AnimatedOpacity(
          opacity: _headerIsExpanded ? 0 : 1,
          duration: Ratioz.duration150ms,
          child: child,
        );

        },
      child: FooterBox(
        key: const ValueKey<String>('Flyer_footer_box'),
        flyerBoxWidth: widget.flyerBoxWidth,
        footerPageController: widget.footerPageController,
        infoButtonExpanded: _infoButtonExpanded,
        reviewButtonIsExpanded: _reviewButtonExpanded,
        tinyMode: widget.tinyMode,
        footerPageViewChildren: <Widget>[

          /// FOOTER
          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// BOTTOM SHADOW
              FooterShadow(
                key: const ValueKey<String>('FooterShadow'),
                flyerBoxWidth: widget.flyerBoxWidth,
                tinyMode: widget.tinyMode,
              ),

              /// FOOTER BUTTONS
              // if (widget.tinyMode == false)// && widget.inFlight == false)
                FooterButtons(
                    key: const ValueKey<String>('FooterButtons'),
                    flyerBoxWidth: widget.flyerBoxWidth,
                    tinyMode: widget.tinyMode,
                    onSaveFlyer: widget.onSaveFlyer,
                    onReviewFlyer: onReviewButtonTap,
                    onShareFlyer: _onShareFlyer,
                    flyerIsSaved: widget.flyerIsSaved
                ),

              /// PRICE BUTTON
                InfoButtonStarter(
                  flyerBoxWidth: widget.flyerBoxWidth,
                  flyerModel: widget.flyerModel,
                  flyerZone: widget.flyerZone,
                  tinyMode: widget.tinyMode,
                  infoButtonExpanded: _infoButtonExpanded,
                  onInfoButtonTap: onInfoButtonTap,
                  infoButtonType: _infoButtonType,
                  infoPageVerticalController: _infoPageVerticalController,
                  inFlight: widget.inFlight,
                ),

              /// CONVERTIBLE REVIEW BUTTON
              if (widget.tinyMode == false && widget.inFlight == false)
              ConvertibleReviewPagePreStarter(
                infoButtonExpanded: _infoButtonExpanded,
                canShowConvertibleReviewButton: _canShowConvertibleReviewButton,
                flyerBoxWidth: widget.flyerBoxWidth,
                tinyMode: widget.tinyMode,
                onReviewButtonTap: onReviewButtonTap,
                reviewButtonExpanded: _reviewButtonExpanded,
                reviewPageVerticalController: _reviewPageVerticalController,
                inFlight: widget.inFlight,
                onEditReview: _onEditReview,
                isEditingReview: _isEditingReview,
                onSubmitReview: _onSubmitReview,
                reviewTextController: _reviewTextController,
                onShowReviewOptions: _onShowReviewOptions,
                flyerModel: widget.flyerModel,
              ),

            ],
          ),

          /// FAKE PAGE TO SLIDE FOOTER WHEN OUT OF SLIDES EXTENTS
          const SizedBox(),

        ],
      ),
    );

  }
}
