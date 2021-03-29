import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bz_card_preview.dart';
import '../flyer.dart';
import '../tiny_flyer_widget.dart';

class GalleryGrid extends StatelessWidget {

  final double gridZoneWidth;
  final List<TinyFlyer> galleryFlyers;
  final List<bool> flyersVisibilities;
  final String bzID;
  final List<AuthorModel> bzAuthors;
  final BzModel bz;
  // final Function tappingMiniFlyer;

  GalleryGrid({
    @required this.gridZoneWidth,
    this.galleryFlyers,
    @required this.flyersVisibilities,
    @required this.bzID,
    @required this.bzAuthors,
    @required this.bz,
    // @required this.tappingMiniFlyer,
});

  bool _concludeUserIsAuthor(){
    List<String> _authorsIDsList = new List();
    bzAuthors.forEach((au) {_authorsIDsList.add(au.userID);});
    String _viewerID = superUserID();

    bool _viewerIsAuthor = _authorsIDsList.contains(_viewerID);
    return _viewerIsAuthor;
  }

  @override
  Widget build(BuildContext context) {
    // final _prof = Provider.of<FlyersProvider>(context, listen: false);
    // final _bz = _prof.getBzByBzID(bzID);
    final List<TinyFlyer> _gridFlyers = galleryFlyers == null ? <TinyFlyer>[] : galleryFlyers;//pro.getAllFlyers;
    bool _viewerIsAuthor = _concludeUserIsAuthor();
    // -------------------------------------------------------------------------
    double _screenWidth = superScreenWidth(context);
    // -------------------------------------------------------------------------
    int _gridColumnsCount = _gridFlyers.length > 12 ? 5 : _gridFlyers.length > 6 ? 4 : 3;
    // -------------------------------------------------------------------------
    double _spacingRatioToGridWidth = 0.15;
    double _gridFlyerWidth = gridZoneWidth / (_gridColumnsCount + (_gridColumnsCount * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _gridFlyerHeight = _gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    double _gridSpacing = _gridFlyerWidth * _spacingRatioToGridWidth;
    int _flyersCount = _viewerIsAuthor ? _gridFlyers.length + 1 : _gridFlyers.length;
    // -------------------------------------------------------------------------
    int _numOfGridRows(int _flyersCount){
      return
        (_flyersCount/_gridColumnsCount).ceil();
    }
    // -------------------------------------------------------------------------
    int _numOfRows = _numOfGridRows(_flyersCount);
    // -------------------------------------------------------------------------
    double _gridHeight = _gridFlyerHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    // -------------------------------------------------------------------------
    double _flyerSizeFactor = (((gridZoneWidth - (_gridSpacing*(_gridColumnsCount+1)))/_gridColumnsCount))/_screenWidth;
    // -------------------------------------------------------------------------
    return
      Container(
          width: gridZoneWidth,
          height: _gridHeight,
          child:
          GridView(
            physics: NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.only(right: _gridSpacing, left: _gridSpacing, top: _gridSpacing * 2, bottom: _gridSpacing ),
            // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: _gridSpacing,
              mainAxisSpacing: _gridSpacing,
              childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
              maxCrossAxisExtent: _gridFlyerWidth,//_gridFlyerWidth,
            ),

            children: <Widget>[

              /// Add new flyer button
              if (_viewerIsAuthor)
              BzCardPreview(
                bz: bz,
                author: bz.bzAuthors[0],
                flyerSizeFactor: _flyerSizeFactor,
                addFlyerButton: true,
              ),

              ...List<Widget>.generate(_gridFlyers.length,
                      (index) =>

                  Opacity(
                    opacity: flyersVisibilities[index] == true ? 1 : 0.1,
                    child: TinyFlyerWidget(
                      tinyFlyer: _gridFlyers[index],
                      flyerSizeFactor: _flyerSizeFactor,
                    )


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