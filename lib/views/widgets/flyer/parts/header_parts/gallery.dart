import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/author_label.dart';
import 'package:bldrs/views/widgets/flyer/stacks/gallery_grid.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  final SuperFlyer superFlyer;
  final bool showFlyers;
  final Function flyerOnTap;

  Gallery({
    @required this.superFlyer,
    @required this.showFlyers,
    @required this.flyerOnTap,
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
    _bzModel = BzModel.getBzModelFromSuperFlyer(widget.superFlyer);

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
      width: widget.superFlyer.flyerZoneWidth,
      margin: EdgeInsets.only(top: widget.superFlyer.flyerZoneWidth * 0.005),
      // color: Colorz.bzPageBGColor,
      child: widget.showFlyers == false ? Container() :
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // // --- GRID TITLE
            // widget.bz.bzShowsTeam == false ?
            // SuperVerse(
            //   verse: '${Wordz.flyersPublishedBy(context)} ${widget.bz.bzName}',
            //   size: 2,
            //   italic: true,
            //   margin: widget.superFlyer.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
            //   maxLines: 3,
            //   centered: false,
            //   shadow: true,
            // )
            //     :
            // SuperVerse(
            //   verse: _bzTeamIDs.length == 1 ? '${Wordz.flyersPublishedBy(context)} ${widget.bz.bzAuthors[0].authorName}' :
            //   '${widget.bz.bzName} ${Wordz.authorsTeam(context)}',
            //   size: 2,
            //   italic: true,
            //   margin: widget.superFlyer.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
            //   maxLines: 3,
            //   centered: false,
            //   shadow: true,
            // ),

            // --- AUTHORS LABELS

            if (widget.superFlyer.bzShowsTeam != false)
            Container(
              width: widget.superFlyer.flyerZoneWidth,
              height: widget.superFlyer.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 0,
                  bottom: widget.superFlyer.flyerZoneWidth * Ratioz.xxflyersGridSpacing),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: widget.superFlyer.flyerZoneWidth * 0.01),
                children:
                widget.superFlyer.bzAuthors == null ?
                <Widget>[Container()]
                    :

                <Widget>[

                  ...List<Widget>.generate(
                      widget.superFlyer.bzAuthors.length,
                          (authorIndex) {

                        AuthorModel _author = widget.superFlyer.bzAuthors[authorIndex];
                        TinyUser _tinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(_author);

                        return
                          Row(
                            children: <Widget>[
                              AuthorLabel(
                                showLabel: widget.showFlyers == true ? true : false,
                                flyerZoneWidth: widget.superFlyer.flyerZoneWidth,
                                tinyAuthor: _tinyAuthor,
                                tinyBz: TinyBz.getTinyBzFromSuperFlyer(widget.superFlyer),
                                authorGalleryCount: AuthorModel.getAuthorGalleryCountFromBzModel(_bzModel, _author),
                                onTap:
                                // widget.bzTeamIDs.length == 1 ?
                                    (id) {
                                  _onAuthorLabelTap(id);
                                  },
                                // :(id){print('a77a');// tappingAuthorLabel();},
                                labelIsOn: _selectedAuthorID == widget.superFlyer.bzAuthors[authorIndex].userID ? true : false,
                              )
                            ],
                          );
                      }
                ),

                  if (_thisIsMyBz == true)
                  AuthorPic(
                    flyerZoneWidth: widget.superFlyer.flyerZoneWidth,
                    authorPic: null,
                    isAddAuthorButton: true,
                    tinyBz: TinyBz.getTinyBzFromSuperFlyer(widget.superFlyer),
                  ),

                ]


              ),
            ),

            // --- AUTHORS FLYERS
            if (widget.superFlyer.flyerZoneWidth != null)
              GalleryGrid(
                  gridZoneWidth: widget.superFlyer.flyerZoneWidth,
                  bzID: widget.superFlyer.bzAuthors == null || widget.superFlyer.bzAuthors == [] || widget.superFlyer.bzAuthors.isEmpty ?  '': widget.superFlyer.bzID,
                  flyersVisibilities: _flyersVisibilities,
                  galleryFlyers: _tinyFlyers,
                  bzAuthors: widget.superFlyer.bzAuthors,
                  bz: _bzModel, /// TASK : maybe should remove this as long as super flyer is here
                  flyerOnTap: widget.flyerOnTap,
                  addPublishedFlyerToGallery: (flyerModel) => _addPublishedFlyerToGallery(flyerModel),
                  ),

          ]
      ),
    );
  }
}
