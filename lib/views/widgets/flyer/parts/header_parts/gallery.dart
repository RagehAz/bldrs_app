import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/author_bubble/author_bubble.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/views/widgets/flyer/stacks/gallery_grid.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;
  final bool showFlyers; // why ?
  final bool addAuthorButtonIsOn;

  Gallery({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
    @required this.showFlyers,
    this.addAuthorButtonIsOn = true,
  });

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<bool> _flyersVisibilities;
  List<bool> _authorsVisibilities;
  String _selectedAuthorID;
  List<TinyFlyer> _tinyFlyers;
  List<String> _bzTeamIDs;
  BzModel _bzModel;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState(){
    _bzModel = widget.superFlyer.bz;

    print('nano flyers are ${_bzModel.nanoFlyers}');

    _tinyFlyers = TinyFlyer.getTinyFlyersFromBzModel(_bzModel);
    _bzTeamIDs = BzModel.getBzTeamIDs(_bzModel);
    setFlyersVisibility();
    super.initState();
  }
// -----------------------------------------------------------------------------
  List<bool> _createVisibilities({bool fillingValue}){
    List<bool> _visibilities = new List();

    for (var flyer in _tinyFlyers){
      _visibilities.add(fillingValue);
    }

    return _visibilities;
  }
// -----------------------------------------------------------------------------
  void setFlyersVisibility () {
    List<bool> _visibilities = _createVisibilities(fillingValue: true);

    setState(() {
      _flyersVisibilities = _visibilities;
      _selectedAuthorID = _bzTeamIDs.length == 1 ? _bzTeamIDs[0] : '';
    });
  }
// -----------------------------------------------------------------------------
  void _onAuthorLabelTap(String authorID){
    setState(() {

      _flyersVisibilities = _createVisibilities(fillingValue: false);

      if(_selectedAuthorID != authorID){
        _selectedAuthorID = '';
        _flyersVisibilities = _createVisibilities(fillingValue: true);
      }

      _tinyFlyers.asMap().forEach((index, flyer) {
        if(_tinyFlyers[index].authorID == _selectedAuthorID){
          _flyersVisibilities[index] = true;
        }
      });

    });
  }
// -----------------------------------------------------------------------------
  void _addPublishedFlyerToGallery(TinyFlyer tinyFlyer){

    // TASK : of the tasks
    // _prof.updateTinyFlyerInLocalBzTinyFlyers(tinyFlyer);

    print('starting _addPublishedFlyerToGallery white tiny flyers were ${_tinyFlyers.length} flyers WHILE flyer visibilities were ${_flyersVisibilities.length} visibilities');

    print('tiny flyer is ${tinyFlyer.flyerID}');

      _tinyFlyers.add(tinyFlyer);
    print('_tinyFlyers are now  ${_tinyFlyers.length} flyers');
      _flyersVisibilities.add(true);
    print('_flyersVisibilities are now  ${_flyersVisibilities.length} visibilities');

      _onAuthorLabelTap(tinyFlyer.authorID);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    bool _thisIsMyBz = _bzTeamIDs.contains(superUserID());

    return Container(
      width: widget.flyerZoneWidth,
      margin: EdgeInsets.only(top: widget.flyerZoneWidth * 0.005),
      color: widget.addAuthorButtonIsOn == false ? Colorz.bzPageBGColor : null,
      child:
      widget.showFlyers == false ?
      Container()
          :
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /// GRID TITLE
            Container(
              width: widget.flyerZoneWidth,
              // height: ,
              alignment: Aligners.superCenterAlignment(context),
              padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
              child:
              widget.superFlyer.bz.bzShowsTeam == false ?
              SuperVerse(
                verse: '${Wordz.flyersPublishedBy(context)} ${widget.superFlyer.bz.bzName}',
                size: 2,
                italic: true,
                margin: widget.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
                maxLines: 3,
                centered: false,
                shadow: true,
                leadingDot: true,
              )
                  :
              SuperVerse(
                verse: _bzTeamIDs.length == 1 ? '${Wordz.flyersPublishedBy(context)} ${widget.superFlyer.bz.bzAuthors[0].authorName}' :
                '${widget.superFlyer.bz.bzName} ${Wordz.authorsTeam(context)}',
                size: 2,
                italic: true,
                margin: widget.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
                maxLines: 3,
                centered: false,
                shadow: true,
                leadingDot: true,
              )
                ,
            ),

            /// AUTHORS BUBBLE
            if (widget.superFlyer.bz.bzShowsTeam != false)
              AuthorBubble(
                  flyerZoneWidth: widget.flyerZoneWidth,
                  addAuthorButtonIsOn: widget.addAuthorButtonIsOn,
                  bzAuthors: widget.superFlyer.bz.bzAuthors,
                  showFlyers: widget.showFlyers,
                  bzModel: widget.superFlyer.bz,
                  onAuthorLabelTap: (id) => _onAuthorLabelTap(id),
                  selectedAuthorID: _selectedAuthorID,
              ),


            /// FLYERS
            if (widget.flyerZoneWidth != null)
              GalleryGrid(
                gridZoneWidth: widget.flyerZoneWidth,
                bzID: widget.superFlyer.bz.bzAuthors == null || widget.superFlyer.bz.bzAuthors == [] || widget.superFlyer.bz.bzAuthors.isEmpty ?  '': widget.superFlyer.bz.bzID,
                flyersVisibilities: _flyersVisibilities,
                galleryFlyers: _tinyFlyers,
                bzAuthors: widget.superFlyer.bz.bzAuthors,
                bz: _bzModel, /// TASK : maybe should remove this as long as super flyer is here
                // flyerOnTap: widget.flyerOnTap,
                addPublishedFlyerToGallery: (flyerModel) => _addPublishedFlyerToGallery(flyerModel),
                addButtonIsOn: widget.addAuthorButtonIsOn,
              ),

          ]
      ),
    );
  }
}
