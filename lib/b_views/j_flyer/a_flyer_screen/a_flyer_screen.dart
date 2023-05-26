import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/a_flyer_reviews_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/d_heroic_flyer_big_view.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:filers/filers.dart';
import 'package:layouts/layouts.dart';
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
      invoker: 'FlyerPreviewScreen',
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
                return const _NoFlyerFoundView();
              }

              else {

                return WidgetFader(
                  fadeType: FadeType.fadeIn,
                  duration: const Duration(milliseconds: 500),
                  child: HeroicFlyerBigView(
                    key: ValueKey<String>(_renderedFlyer.id),
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
  // -----------------------------------------------------------------------------
}

class _NoFlyerFoundView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _NoFlyerFoundView({Key key}) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        const BldrsBox(
          height: 400,
          width: 400,
          icon: Iconz.flyer,
          bubble: false,
          opacity: 0.04,
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const BldrsText(
              verse: Verse(
                id: 'phid_flyer_not_found',
                translate: true,
              ),
              size: 3,
              maxLines: 2,
            ),

            BldrsBox(
              height: 50,
              icon: Iconizer.superBackIcon(context),
              iconSizeFactor: 0.7,
              verse: const Verse(id: 'phid_go_back', translate: true),
              onTap: () => Nav.goBack(context: context),
              margins: 20,
            ),

          ],
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
