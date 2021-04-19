import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/grids/gallery_grid.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/author_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Gallery extends StatefulWidget {
  final double flyerZoneWidth;
  final BzModel bz;
  final bool showFlyers;
  final Function flyerOnTap;

  Gallery({
    @required this.flyerZoneWidth,
    @required this.bz,
    @required this.showFlyers,
    @required this.flyerOnTap,
  });

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<bool> flyersVisibilities;
  List<bool> authorsVisibility;
  String currentSelectedAuthor;
  List<TinyFlyer> _tinyFlyers;
  List<String> _bzTeamIDs;
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
    _tinyFlyers = TinyFlyer.getTinyFlyersFromBzModel(widget.bz);
    _bzTeamIDs = BzModel.getBzTeamIDs(widget.bz);
    setFlyersVisibility();
    super.initState();
  }
// -----------------------------------------------------------------------------
  void setFlyersVisibility () {
    setState(() {
      flyersVisibilities = List.filled(_tinyFlyers.length, true);
      currentSelectedAuthor = _bzTeamIDs.length == 1 ? _bzTeamIDs[0] : '';
    });
  }
// -----------------------------------------------------------------------------
  tappingAuthorLabel(String authorID){
    setState(() {
      flyersVisibilities = List.filled(_tinyFlyers.length, false);
      currentSelectedAuthor == authorID ? currentSelectedAuthor = '' : currentSelectedAuthor = authorID;
      currentSelectedAuthor == '' ? flyersVisibilities = List.filled(_tinyFlyers.length, true) : currentSelectedAuthor = authorID;
      _tinyFlyers.asMap().forEach((index, flyer) {
        if(_tinyFlyers[index].authorID == currentSelectedAuthor){flyersVisibilities[index] = true;}
      });
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.flyerZoneWidth,
      margin: EdgeInsets.only(top: widget.flyerZoneWidth * 0.005),
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
            //   margin: widget.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
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
            //   margin: widget.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
            //   maxLines: 3,
            //   centered: false,
            //   shadow: true,
            // ),

            // --- AUTHORS LABELS

            widget.bz.bzShowsTeam == false ? Container() :
            Container(
              width: widget.flyerZoneWidth,
              height: widget.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 0,
                  bottom: widget.flyerZoneWidth * Ratioz.xxflyersGridSpacing),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: widget.flyerZoneWidth * 0.01),
                children:
                widget.bz.bzAuthors == null ? [Container()] :
                List<Widget>.generate(
                  widget.bz.bzAuthors.length,
                      (authorIndex) {

                    AuthorModel _author = widget.bz.bzAuthors[authorIndex];
                    TinyUser _tinyAuthor = AuthorModel.getTinyAuthorFromAuthorModel(_author);

                    return
                        Row(
                          children: <Widget>[
                            AuthorLabel(
                              showLabel: widget.showFlyers == true ? true : false,
                              flyerZoneWidth: widget.flyerZoneWidth,
                              tinyAuthor: _tinyAuthor,
                              tinyBz: TinyBz.getTinyBzFromBzModel(widget.bz),
                              authorGalleryCount: AuthorModel.getAuthorGalleryCountFromBzModel(widget.bz, _author),
                              tappingLabel:
                              // widget.bzTeamIDs.length == 1 ?
                                  (id) {
                                tappingAuthorLabel(id);
                              },
                              // :(id){print('a77a');// tappingAuthorLabel();},
                              labelIsOn: currentSelectedAuthor == widget.bz.bzAuthors[authorIndex].userID ? true : false,
                            )
                          ],
                        );
                      }
                ),
              ),
            ),

            // --- AUTHORS FLYERS
            GalleryGrid(
              gridZoneWidth: widget.flyerZoneWidth,
              bzID: widget.bz.bzAuthors == null || widget.bz.bzAuthors == [] || widget.bz.bzAuthors.isEmpty ?  '': widget.bz.bzID,
              flyersVisibilities: flyersVisibilities,
              galleryFlyers: _tinyFlyers,
              bzAuthors: widget.bz.bzAuthors,
              bz: widget.bz,
              flyerOnTap: widget.flyerOnTap,
            ),

          ]
      ),
    );
  }
}
