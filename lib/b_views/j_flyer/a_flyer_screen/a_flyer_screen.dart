import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/a_flyer_reviews_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/d_heroic_flyer_big_view.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:widget_fader/widget_fader.dart';

class FlyerPreviewScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerPreviewScreen({
    @required this.flyerID,
    this.reviewID,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String flyerID;
  final String reviewID;
  /// --------------------------------------------------------------------------
  static const String routeName = Routing.flyerScreen;
  /// --------------------------------------------------------------------------
  @override
  State<FlyerPreviewScreen> createState() => _FlyerPreviewScreenState();
  /// --------------------------------------------------------------------------
}

class _FlyerPreviewScreenState extends State<FlyerPreviewScreen> {
  // -----------------------------------------------------------------------------
  FlyerModel _renderedFlyer;
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

        if (widget.flyerID != null) {

          FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
            context: context,
            flyerID: widget.flyerID,
          );

          if (_flyerModel != null){

            _flyerModel = await FlyerProtocols.renderBigFlyer(
              context: context,
              flyerModel: _flyerModel,
            );

            setState(() {
              _renderedFlyer = _flyerModel;
            });

          }


        }


        /// GO TO REVIEWS SCREEN IF REVIEW ID IS NOT NULL
        if (widget.reviewID != null) {

          await Nav.goToNewScreen(
            context: context,
            screen: FlyerReviewsScreen(
              flyerModel: _renderedFlyer,
              highlightReviewID: widget.reviewID,
            ),
          );

        }

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();

    FlyerProtocols.disposeRenderedFlyer(
      mounted: mounted,
      flyerModel: _renderedFlyer,
    );

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// TASK : reviewID is $reviewID and should auto go to reviews screen then scroll to it
    blog('reviewID is ${widget.reviewID} and should auto go to reviews screen then scroll to it');

    // --------------------
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorz.skyDarkBlue,
        body: ValueListenableBuilder(
          valueListenable: _loading,
          builder: (_, bool loading, Widget child){

            if (loading == true){
              return const LoadingFullScreenLayer();
            }

            else {

              if (_renderedFlyer == null){
                return const Center(child: NoResultFound());
              }

              else {

                return WidgetFader(
                  fadeType: FadeType.fadeIn,
                  duration: const Duration(milliseconds: 500),
                  child: HeroicFlyerBigView(
                    key: PageStorageKey<String>(_renderedFlyer.id),
                    flyerBoxWidth: Scale.screenWidth(context),
                    renderedFlyer: _renderedFlyer,
                    heroPath: 'FlyerPreviewScreen',
                  ),
                );

              }

            }

          },
        ),

      ),
    );
    // --------------------
  }
}
