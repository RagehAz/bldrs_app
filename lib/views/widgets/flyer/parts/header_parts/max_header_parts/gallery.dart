import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/views/widgets/flyer/grids/gallery_grid.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/author_label.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  final double flyerZoneWidth;
  final BzModel bz;
  final bool bzShowsTeam;
  final String bzName;
  final int followersCount;
  final List<String> bzTeamIDs;
  final bool bzPageIsOn;
  final bzConnects;
  final List<FlyerModel> galleryFlyers;
  final List<AuthorModel> authors;
  // final Function tappingMiniFlyer;

  Gallery({
    @required this.flyerZoneWidth,
    @required this.bz,
    @required this.bzShowsTeam,
    @required this.bzName,
    @required this.followersCount,
    @required this.bzTeamIDs,
    @required this.bzPageIsOn,
    @required this.bzConnects,
    @required this.galleryFlyers,
    @required this.authors,
    // @required this.tappingMiniFlyer,
  });

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<bool> flyersVisibilities;
  List<bool> authorsVisibility;
  String currentSelectedAuthor;
// ----------------------------------------------------------------------------
  void visibilityShit () {
    setState(() {
      flyersVisibilities = List.filled(widget.galleryFlyers.length, true);
      currentSelectedAuthor = widget.bzTeamIDs.length == 1 ? widget.bzTeamIDs[0] : '';
    });
}
// ----------------------------------------------------------------------------
  @override
  void initState(){
    visibilityShit();
    super.initState();
  }
// ----------------------------------------------------------------------------
    tappingAuthorLabel(String authorID){
      setState(() {
        flyersVisibilities = List.filled(widget.galleryFlyers.length, false);
        currentSelectedAuthor == authorID ? currentSelectedAuthor = '' : currentSelectedAuthor = authorID;
        currentSelectedAuthor == '' ? flyersVisibilities = List.filled(widget.galleryFlyers.length, true) : currentSelectedAuthor = authorID;
        widget.galleryFlyers.asMap().forEach((index, flyer) {
          if(widget.galleryFlyers[index].authorID == currentSelectedAuthor){flyersVisibilities[index] = true;}
        });
      });
    }
// ----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.flyerZoneWidth,
      margin: EdgeInsets.only(top: widget.flyerZoneWidth * 0.005),
      color: Colorz.bzPageBGColor,
      child: widget.bzPageIsOn == false ? Container() :
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // --- GRID TITLE
            widget.bzShowsTeam == false ?
            SuperVerse(
              verse: '${Wordz.flyersPublishedBy(context)} ${widget.bzName}',
              size: 2,
              italic: true,
              margin: widget.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
              maxLines: 3,
              centered: false,
              shadow: true,
            )
                :
            SuperVerse(
              verse: widget.bzTeamIDs.length == 1 ? '${Wordz.flyersPublishedBy(context)} ${widget.authors[0].authorName}' :
              '${widget.bzName} ${Wordz.authorsTeam(context)}',
              size: 2,
              italic: true,
              margin: widget.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
              maxLines: 3,
              centered: false,
              shadow: true,
            ),

            // --- AUTHORS LABELS
            widget.bzShowsTeam == false ? Container() :
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
                widget.authors == null ? [Container()] :
                List<Widget>.generate(
                  widget.authors.length,
                      (authorIndex) => Row(
                        children: <Widget>[
                          AuthorLabel(
                            bzPageIsOn: widget.bzPageIsOn,
                            flyerZoneWidth: widget.flyerZoneWidth,
                            followersCount: widget.followersCount,
                            authorPic: widget.authors[authorIndex].authorPic,
                            authorName: widget.authors[authorIndex].authorName,
                            authorTitle: widget.authors[authorIndex].authorTitle,
                            bzGalleryCount: 0,
                            authorGalleryCount: widget.authors[authorIndex].publishedFlyersIDs?.length,
                            authorID: widget.authors[authorIndex].userID,
                            tappingLabel:
                            // widget.bzTeamIDs.length == 1 ?
                                (id){tappingAuthorLabel(id);},
                            // :(id){print('a77a');// tappingAuthorLabel();},
                            labelIsOn: currentSelectedAuthor == widget.authors[authorIndex].userID ? true : false,
                          )
                        ],
                      ),

                ),
              ),
            ),

            // --- AUTHORS FLYERS
            GalleryGrid(
              gridZoneWidth: widget.flyerZoneWidth,
              bzID: widget.authors == null || widget.authors == [] || widget.authors.isEmpty ?  '': widget.authors[0]?.bzID,
              flyersVisibilities: flyersVisibilities,
              galleryFlyers: widget.galleryFlyers,
              bzAuthors: widget.authors,
              bz: widget.bz,
              // tappingMiniFlyer: widget.tappingMiniFlyer,
            ),

          ]
      ),
    );
  }
}
