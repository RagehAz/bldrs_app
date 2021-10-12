import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/firestore/auth_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/add_flyer_button.dart';
import 'package:flutter/material.dart';

class GalleryGrid extends StatelessWidget {

  final double gridZoneWidth;
  final List<TinyFlyer> galleryFlyers;
  final List<bool> flyersVisibilities;
  final String bzID;
  final List<AuthorModel> bzAuthors;
  final BzModel bz;
  final bool addButtonIsOn;
  // final Function flyerOnTap;
  final Function addPublishedFlyerToGallery;

  const GalleryGrid({
    @required this.gridZoneWidth,
    this.galleryFlyers,
    @required this.flyersVisibilities,
    @required this.bzID,
    @required this.bzAuthors,
    @required this.bz,
    this.addButtonIsOn = false,
    // @required this.flyerOnTap,
    @required this.addPublishedFlyerToGallery,
});
// -----------------------------------------------------------------------------
  bool _concludeUserIsAuthor(){
    final List<String> _authorsIDsList = <String>[];

    if (bzAuthors != null){
      bzAuthors.forEach((au) {_authorsIDsList.add(au.userID);});
    }

    final String _viewerID = superUserID();

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
  static double gridflyerBoxWidth({double gridZoneWidth, int flyersLength}){
    final int _gridColumnsCount = gridColumnCount(flyersLength);
    final double _gridFlyerWidth = gridZoneWidth / (_gridColumnsCount + (_gridColumnsCount * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    return _gridFlyerWidth;
  }
// -----------------------------------------------------------------------------
  static double gridSpacing({double gridZoneWidth, int flyersLength}){
    final double _gridFlyerWidth = gridflyerBoxWidth(gridZoneWidth: gridZoneWidth, flyersLength: flyersLength);
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
    final double _gridFlyerWidth = gridflyerBoxWidth(gridZoneWidth: gridZoneWidth, flyersLength: flyersLength);
    final double _gridFlyerHeight = _gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    final int _numOfRows = numOfRows(flyersLength);
    final double _gridHeight = _gridFlyerHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    return _gridHeight;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<TinyFlyer> _gridFlyers = galleryFlyers == null ? <TinyFlyer>[] : galleryFlyers;//pro.getAllFlyers;
    final bool _viewerIsAuthor = _concludeUserIsAuthor();
// -----------------------------------------------------------------------------
    final int _flyersLength = addButtonIsOn == true ? _gridFlyers.length + 1 : _gridFlyers.length;
    final double _gridFlyerWidth = gridflyerBoxWidth(gridZoneWidth: gridZoneWidth, flyersLength: _flyersLength);
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
            shrinkWrap: false,
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.only(right: _gridSpacing, left: _gridSpacing, top: _gridSpacing , bottom: _gridSpacing ),
            key: PageStorageKey<String>('gridFlyers_${bzID}'),//new Key(loadedFlyers[flyerIndex].f01flyerID),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: _gridSpacing,
              mainAxisSpacing: _gridSpacing,
              childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
              maxCrossAxisExtent: _gridFlyerWidth,
            ),

            children: <Widget>[

              /// Add new flyer button
              if (_viewerIsAuthor == true && addButtonIsOn == true)
              AddFlyerButton(
                bzModel: bz,
                flyerBoxWidth: _gridFlyerWidth,
                addPublishedFlyerToGallery: addPublishedFlyerToGallery,
              ),

              /// GALLERY FLYERS
              ...List<Widget>.generate(_gridFlyers.length,
                      (index) =>

                  Opacity(
                    opacity: flyersVisibilities == null || flyersVisibilities.length == 0 || flyersVisibilities[index] == true ? 1 : 0.1,
                    child:

                      FinalFlyer(
                        flyerBoxWidth: _gridFlyerWidth,
                        tinyFlyer: _gridFlyers[index],
                        goesToEditor: true,
                        bzModel: bz,
                        inEditor: false,
                        flyerKey: ValueKey('${_gridFlyers[index].flyerID}'),
                        // initialSlideIndex: _gridFlyers[index].slideIndex,

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