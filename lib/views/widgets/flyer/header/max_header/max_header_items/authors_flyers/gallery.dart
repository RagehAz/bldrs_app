import 'package:bldrs/providers/combined_models/co_author.dart';
import 'package:bldrs/providers/combined_models/co_flyer.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/flyer/header/mini_header/mini_header_items/mini_header_strip/mini_header_strip_items/labels/author_label.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'gallery_grid.dart';

class Gallery extends StatefulWidget {
  final double flyerZoneWidth;
  final bool bzShowsTeam;
  final String bzName;
  final int followersCount;
  final List<String> bzTeamIDs;
  final bool bzPageIsOn;
  final bzConnects;
  final List<CoFlyer> galleryCoFlyers;
  final List<CoAuthor> coAuthors;
  // final Function tappingMiniFlyer;

  Gallery({
    @required this.flyerZoneWidth,
    @required this.bzShowsTeam,
    @required this.bzName,
    @required this.followersCount,
    @required this.bzTeamIDs,
    @required this.bzPageIsOn,
    @required this.bzConnects,
    @required this.galleryCoFlyers,
    @required this.coAuthors,
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
      flyersVisibilities = List.filled(widget.galleryCoFlyers.length, true);
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
      print('label is tapped $authorID');
      setState(() {
        flyersVisibilities = List.filled(widget.galleryCoFlyers.length, false);
        currentSelectedAuthor == authorID ? currentSelectedAuthor = '' : currentSelectedAuthor = authorID;
        currentSelectedAuthor == '' ? flyersVisibilities = List.filled(widget.galleryCoFlyers.length, true) : currentSelectedAuthor = authorID;
        widget.galleryCoFlyers.asMap().forEach((index, flyer) {
          if(widget.galleryCoFlyers[index].flyer.authorID == currentSelectedAuthor){flyersVisibilities[index] = true;}
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
              verse: 'flyers published by ${widget.bzName}',
              size: 2,
              italic: true,
              margin: widget.flyerZoneWidth * Ratioz.xxflyersGridSpacing,
              maxLines: 3,
              centered: false,
              shadow: true,
            )
                :
            SuperVerse(
              verse: widget.bzTeamIDs.length == 1 ? 'Flyers published by ${widget.coAuthors[0].coUser.user.name}' : '${widget.bzName} authors team',
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
                children: List<Widget>.generate(

                  widget.coAuthors.length,
                      (authorIndex) => Row(
                        children: <Widget>[
                          AuthorLabel(
                            bzPageIsOn: widget.bzPageIsOn,
                            flyerZoneWidth: widget.flyerZoneWidth,
                            followersCount: widget.followersCount,
                            authorPic: widget.coAuthors[authorIndex].coUser.user.pic,
                            authorName: widget.coAuthors[authorIndex].coUser.user.name,
                            authorTitle: widget.coAuthors[authorIndex].coUser.user.title,
                            bzGalleryCount: 0,
                            authorGalleryCount: widget.coAuthors[authorIndex].authorFlyersIDs?.length,
                            authorID: widget.coAuthors[authorIndex].author.authorID,
                            tappingLabel: widget.bzTeamIDs.length == 1 ? (){} : tappingAuthorLabel,
                            labelIsOn: currentSelectedAuthor == widget.coAuthors[authorIndex].author.authorID ? true : false,
                          )
                        ],
                      ),

                ),
              ),
            ),

            // --- AUTHORS FLYERS
            GalleryGrid(
              gridZoneWidth: widget.flyerZoneWidth,
              bzID: widget.coAuthors[0].author.bzId,
              flyersVisibilities: flyersVisibilities,
              // tappingMiniFlyer: widget.tappingMiniFlyer,
            ),

          ]
      ),
    );
  }
}
