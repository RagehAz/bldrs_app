import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';

class SlidesNew extends StatelessWidget {
  final SuperFlyer superFlyer;
  // final PageController horizontalController;
  // final DraftFlyerModel draft;
  // final Function onPageChanged;
  // final double flyerZoneWidth;
  // final Function triggerKeywordsView;

  const SlidesNew({
    @required this.superFlyer,
    // @required this.horizontalController,
    // @required this.draft,
    // @required this.onPageChanged,
    // @required this.flyerZoneWidth,
    // @required this.triggerKeywordsView,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return PageView(
      pageSnapping: true,
      controller: superFlyer.horizontalController,
      physics: const BouncingScrollPhysics(),
      allowImplicitScrolling: false,
      clipBehavior: Clip.antiAlias,
      restorationId: '${superFlyer.key.value}',
      onPageChanged: superFlyer.listenToSwipe ? (i) => superFlyer.onHorizontalSlideSwipe(i) : (i) => Sliders.zombie(i),
      scrollDirection: Axis.horizontal,
      children: <Widget>[

        ...List.generate(superFlyer.numberOfSlides, (i){

          // print('========= BUILDING PROGRESS BAR FOR ||| index : $draft.currentSlideIndex, numberOfSlides : $draft.numberOfSlides');

          BoxFit _currentPicFit = superFlyer.boxesFits.length == 0 ? null : superFlyer.boxesFits[superFlyer.currentSlideIndex];

          ImageSize _originalAssetSize =
          superFlyer.assetsSources == null ? null :
          superFlyer.numberOfSlides == 0 ? null :
          superFlyer.assetsSources.length == 0 ? null :
          ImageSize(
            width: superFlyer.assetsSources[superFlyer.currentSlideIndex].originalWidth,
            height: superFlyer.assetsSources[superFlyer.currentSlideIndex].originalHeight,
          );


          return
            superFlyer.numberOfSlides == 0 ? Container() :
            AnimatedOpacity(
              key: ObjectKey('${superFlyer.key.value}${i}'),
              opacity: superFlyer.slidesVisibilities[i] == true ? 1 : 0,
              duration: Ratioz.durationFading200,
              child: Stack(
                children: <Widget>[

                  SingleSlide(
                    key: ObjectKey('${superFlyer.key.value}${i}'),
                    flyerZoneWidth: superFlyer.flyerZoneWidth,
                    flyerID: superFlyer.flyerID, //_flyer.flyerID,
                    picture: superFlyer.editMode ? superFlyer.assetsFiles[i] : superFlyer.slides[i].picture,
                    // slideMode: superFlyer.editMode ? SlideMode.Editor : SlideMode.View,//slidesModes[index],
                    boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                    titleController: superFlyer.editMode ? superFlyer.headlinesControllers[i] : null,
                    title: superFlyer.editMode ? superFlyer.headlinesControllers[i].text : superFlyer.slides[i].headline,
                    imageSize: _originalAssetSize,
                    textFieldOnChanged: (text){
                      print('text is : $text');
                    },
                    onTap: (){},
                  ),

                  if (superFlyer.flyerState != FlyerState.Draft)
                    FlyerFooter(
                      flyerZoneWidth: superFlyer.flyerZoneWidth,
                      saves: 0,
                      shares: 0,
                      views: 0,
                      onShareTap: null,
                      onCountersTap: () => superFlyer.onVerticalPageSwipe(1),
                    ),

                ],
              ),
            );

        }),

      ],
    );
  }
}
