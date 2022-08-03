import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/b_submitted_reviews.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/single_slide.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerReviewsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerReviewsScreen({
    @required this.flyerModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  _FlyerReviewsScreenState createState() => _FlyerReviewsScreenState();
/// --------------------------------------------------------------------------
}

class _FlyerReviewsScreenState extends State<FlyerReviewsScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    const double _slidesShelfHeight = 120;
    const double _separatorHeight = 5;
    final double _reviewsBozHeight = _screenHeight - Ratioz.stratosphere - _separatorHeight - _slidesShelfHeight;
    const double _flyerBoxHeight = _slidesShelfHeight;
    final double _flyerBoxWidth = FlyerBox.widthByHeight(context, _flyerBoxHeight);

    return MainLayout(
      pageTitle: 'Flyer Reviews',
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      hasKeyboard: false,
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          /// SLIDES
          SizedBox(
            width: _screenWidth,
            height: _slidesShelfHeight,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.flyerModel.slides.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (_, index){

                return Container(
                  margin: Scale.superInsets(context: context, enRight: 5),
                  alignment: Alignment.center,
                  child: SingleSlide(
                      flyerBoxWidth: _flyerBoxWidth,
                      flyerBoxHeight: _flyerBoxHeight,
                      slideModel: widget.flyerModel.slides[index],
                      tinyMode: false,
                      onSlideNextTap: null,
                      onSlideBackTap: null,
                      onDoubleTap: null,
                  ),
                );

              }
            ),
          ),

          /// SEPARATOR
          Container(
            width: _screenWidth,
            height: _separatorHeight,
            color: Colorz.bloodTest,
          ),

          /// REVIEWS
          Container(
            width: _screenWidth,
            height: _reviewsBozHeight,
            color: Colorz.grey80,
            child: SubmittedReviews(
              flyerModel: widget.flyerModel,
              flyerBoxWidth: _screenWidth,
              pageWidth: _screenWidth - 10,
              pageHeight: _reviewsBozHeight - 10,
            ),
          ),

        ],
      ),
    );

  }
}
