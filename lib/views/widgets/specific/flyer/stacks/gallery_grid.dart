import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/add_flyer_button.dart';
import 'package:flutter/material.dart';

class GalleryGrid extends StatelessWidget {

  final double gridZoneWidth;
  final List<FlyerModel> galleryFlyers;
  final List<bool> flyersVisibilities;
  final String bzID;
  final List<AuthorModel> bzAuthors;
  final BzModel bz;
  final CountryModel bzCountry;
  final CityModel bzCity;
  final bool addButtonIsOn;
  // final Function flyerOnTap;
  final Function addPublishedFlyerToGallery;

  const GalleryGrid({
    @required this.gridZoneWidth,
    @required this.flyersVisibilities,
    @required this.bzID,
    @required this.bzAuthors,
    @required this.bz,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.addPublishedFlyerToGallery,
    this.galleryFlyers,
    this.addButtonIsOn = false,
    // @required this.flyerOnTap,
    Key key,
}) : super(key: key);
// -----------------------------------------------------------------------------
  bool _concludeUserIsAuthor(){
    final List<String> _authorsIDsList = <String>[];



    if (Mapper.canLoopList(bzAuthors)){

      for (final AuthorModel author in bzAuthors){
        _authorsIDsList.add(author.userID);
      }

    }

    final String _viewerID = FireAuthOps.superUserID();
    final bool _viewerIsAuthor = _authorsIDsList.contains(_viewerID);

    return _viewerIsAuthor;
  }
// -----------------------------------------------------------------------------
  static const double _spacingRatioToGridWidth = 0.15;
// -----------------------------------------------------------------------------
  static int gridColumnCount(int flyersLength){
    final int _gridColumnsCount = flyersLength > 12 ? 3 : flyersLength > 6 ? 2 : 2;
    return _gridColumnsCount;
  }
// -----------------------------------------------------------------------------
  static double gridFlyerBoxWidth({double gridZoneWidth, int flyersLength}){
    final int _gridColumnsCount = gridColumnCount(flyersLength);
    final double _gridFlyerWidth = gridZoneWidth / (_gridColumnsCount + (_gridColumnsCount * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    return _gridFlyerWidth;
  }
// -----------------------------------------------------------------------------
  static double gridSpacing({double gridZoneWidth, int flyersLength}){
    final double _gridFlyerWidth = gridFlyerBoxWidth(gridZoneWidth: gridZoneWidth, flyersLength: flyersLength);
    return  _gridFlyerWidth * _spacingRatioToGridWidth;
  }
// -----------------------------------------------------------------------------
  static int numOfRows(int flyersLength){
    final int _gridColumnsCount = gridColumnCount(flyersLength);
    return
      (flyersLength/_gridColumnsCount).ceil();
  }
// -----------------------------------------------------------------------------
  static double gridHeight({BuildContext context, double gridZoneWidth, bool gridHasAddButton, int flyersLength}){
    // int _flyersCount = gridHasAddButton ? flyersLength + 1 : flyersLength;
    final double _gridFlyerWidth = gridFlyerBoxWidth(gridZoneWidth: gridZoneWidth, flyersLength: flyersLength);
    final double _gridFlyerHeight = _gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    final int _numOfRows = numOfRows(flyersLength);
    final double _gridHeight = _gridFlyerHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    return _gridHeight;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<FlyerModel> _gridFlyers = galleryFlyers ?? <FlyerModel>[];
    final bool _viewerIsAuthor = _concludeUserIsAuthor();
// -----------------------------------------------------------------------------
    final int _flyersLength = addButtonIsOn == true ? _gridFlyers.length + 1 : _gridFlyers.length;
    /// TASK : THERE IS SOMETHING WRONG WITH THE BELOW -5 PIXELS !
    final double _gridFlyerWidth = gridFlyerBoxWidth(gridZoneWidth: gridZoneWidth, flyersLength: _flyersLength) - 5;
    final double _gridSpacing = gridSpacing(gridZoneWidth: gridZoneWidth, flyersLength: _flyersLength);
// -----------------------------------------------------------------------------
    final double _gridHeight = gridHeight(
        context : context,
        gridZoneWidth : gridZoneWidth,
        gridHasAddButton : _viewerIsAuthor,
        flyersLength : _flyersLength,
    );
// -----------------------------------------------------------------------------

    print('the fucking flyers hena are : ${galleryFlyers}');

    return
      Container(
          width: gridZoneWidth,
          height: _gridHeight,
          child:
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(right: _gridSpacing, left: _gridSpacing, top: _gridSpacing , bottom: _gridSpacing ),
            key: PageStorageKey<String>('gridFlyers_${bzID}'),//new Key(loadedFlyers[flyerIndex].f01flyerID),
            gridDelegate:

            // SliverGridDelegateWithMaxCrossAxisExtent(
            //   crossAxisSpacing: _gridSpacing,
            //   mainAxisSpacing: _gridSpacing,
            //   childAspectRatio: 1 / (Ratioz.xxflyerZoneHeight),
            //   maxCrossAxisExtent: _gridFlyerWidth,
            // ),

            SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / (Ratioz.xxflyerZoneHeight),
              crossAxisCount: 2,
              crossAxisSpacing: _gridSpacing,
              mainAxisExtent: _gridFlyerWidth * Ratioz.xxflyerZoneHeight,
              mainAxisSpacing: _gridSpacing,
            ),

            children: <Widget>[

              /// Add new flyer button
              if (_viewerIsAuthor == true && addButtonIsOn == true)
              AddFlyerButton(
                bzModel: bz,
                flyerBoxWidth: _gridFlyerWidth,
                addPublishedFlyerToGallery: addPublishedFlyerToGallery,
                bzCountry: bzCountry,
                bzCity: bzCity,
              ),

              /// GALLERY FLYERS
              ...List<Widget>.generate(_gridFlyers.length,
                      (int index) =>

                  Opacity(
                    opacity: flyersVisibilities == null || flyersVisibilities.isEmpty || flyersVisibilities[index] == true ? 1 : 0.1,
                    child:

                      FinalFlyer(
                        flyerBoxWidth: _gridFlyerWidth,
                        flyerModel: _gridFlyers[index],
                        goesToEditor: true,
                        bzModel: bz,
                        flyerKey: ValueKey<String>('${_gridFlyers[index].id}'),
                        // initialSlideIndex: _gridFlyers[index].slideIndex,
                        onSwipeFlyer: (Sliders.SwipeDirection direction){
                          // print('Direction is ${direction}');
                        },
                      ),

                    ///
                    // TinyFlyerWidget(
                    //   tinyFlyer: _gridFlyers[index],
                    //   flyerSizeFactor: _flyerSizeFactor,
                    //   onTap: flyerOnTap,
                    // )
                    ///
                    // ChangeNotifierProvider.value(
                    //   value: _gridFlyers[index],
                    //   child:
                    //
                    //   // Flyer(
                    //   //     flyerSizeFactor: _flyerSizeFactor,
                    //   //     slidingIsOn: false,
                    //   //     // flyerID: _gridFlyers[index].flyer.flyerID,
                    //   //     tappingFlyerZone:
                    //   //     flyersVisibilities[index] == true ?
                    //   //         () => openFlyer(context, _gridFlyers[index].flyerID)
                    //   //         :
                    //   //         (){}
                    //   // ),
                    //
                    //
                    // ),

                  )

              ),

            ],

          ),
    );
  }
}
