import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';

class SlidesNew extends StatelessWidget {
  final PageController horizontalController;
  final DraftFlyerModel draft;
  final Function onPageChanged;
  final double flyerZoneWidth;
  final Function triggerKeywordsView;

  const SlidesNew({
    @required this.horizontalController,
    @required this.draft,
    @required this.onPageChanged,
    @required this.flyerZoneWidth,
    @required this.triggerKeywordsView,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      pageSnapping: true,
      controller: horizontalController,
      physics: const BouncingScrollPhysics(),
      allowImplicitScrolling: false,
      clipBehavior: Clip.antiAlias,
      restorationId: '${draft.key.value}',
      onPageChanged: draft.listenToSwipe ? (i) => onPageChanged(i) : (i) => Sliders.zombie(i),
      scrollDirection: Axis.horizontal,
      children: <Widget>[

        ...List.generate(draft.numberOfSlides, (i){

          // print('========= BUILDING PROGRESS BAR FOR ||| index : $draft.currentSlideIndex, numberOfSlides : $draft.numberOfSlides');

          BoxFit _currentPicFit = draft.boxesFits.length == 0 ? null : draft.boxesFits[draft.currentSlideIndex];

          ImageSize _originalAssetSize =
          draft.numberOfSlides == 0 ? null :
          draft.assetsSources.length == 0 ? null :
          ImageSize(
            width: draft.assetsSources[draft.currentSlideIndex].originalWidth,
            height: draft.assetsSources[draft.currentSlideIndex].originalHeight,
          );


          return
            draft.numberOfSlides == 0 ? Container() :
            AnimatedOpacity(
              key: ObjectKey(draft.key.value + i),
              opacity: draft.visibilities[i] == true ? 1 : 0,
              duration: Ratioz.durationFading200,
              child: Stack(
                children: <Widget>[

                  SingleSlide(
                    key: ObjectKey(draft.key.value + i),
                    flyerZoneWidth: flyerZoneWidth,
                    flyerID: null, //_flyer.flyerID,
                    picture: draft.assetsFiles[i],//_currentSlides[index].picture,
                    slideMode: draft.editMode ? SlideMode.Editor : SlideMode.View,//slidesModes[index],
                    boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                    titleController: draft.headlinesControllers[i],
                    title: draft.headlinesControllers[i].text,
                    imageSize: _originalAssetSize,
                    textFieldOnChanged: (text){
                      print('text is : $text');
                    },
                    onTap: (){},
                  ),

                  if (draft.editMode == false)
                    FlyerFooter(
                      flyerZoneWidth: flyerZoneWidth,
                      saves: 0,
                      shares: 0,
                      views: 0,
                      onShareTap: null,
                      onCountersTap: triggerKeywordsView,
                    ),

                ],
              ),
            );

        }),

      ],
    );
  }
}
