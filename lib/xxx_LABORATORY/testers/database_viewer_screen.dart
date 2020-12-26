import 'package:bldrs/ambassadors/db_brain/db_controller.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/combined_models/co_author.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/views/widgets/layouts/dream_list.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/swiper_layout.dart';
import 'package:flutter/material.dart';

class DatabaseViewerScreen extends StatefulWidget {



  @override
  _DatabaseViewerScreenState createState() => _DatabaseViewerScreenState();
}

class _DatabaseViewerScreenState extends State<DatabaseViewerScreen> {
  @override
  Widget build(BuildContext context) {

  List<BzModel> allBz = getAllBzz();
  List<UserModel> allUsers = getAllUsers();
  List<CoAuthor> allCoAuthors = getAllCoAuthors();

  Widget allBzzDreamList = DreamList(
    itemCount: allBz?.length,
    itemBuilder: (BuildContext c, int x) =>
    DreamTile(
      index: x,
      info: '${allBz[x]?.bzId}: ${bzTypeStringer(c, allBz[x]?.bzType)}, ${bzFormStringer(c,allBz[x]?.bzForm)}, ${allBz[x]?.bzCity}',
      icon: allBz[x].bzLogo,
      verse: allBz[x].bzName,
      secondLine: 'canPublish:${allBz[x]?.bzAccountCanPublish} ... isPublished:${allBz[x]?.bzAccountIsPublished}',
    ),

  );

  Widget allUsersDreamList = DreamList(
    itemCount: allUsers.length,
    itemBuilder: (BuildContext c, int x) =>
        DreamTile(
          index: x,
          info: '${allUsers[x]?.userID}: ${allUsers[x]?.userCity}, whatsapp: ${allUsers[x]?.userWhatsAppIsOn}',
          icon: allUsers[x]?.pic,
          verse: allUsers[x]?.name,
          secondLine: '${allUsers[x]?.title}',
        ),
  );

  Widget allAuthorsDreamList = DreamList(
    itemCount: allCoAuthors.length,
    itemBuilder: (BuildContext c, int x) =>
        DreamTile(
          index: x,
          info: '${allCoAuthors[x].author.authorID}: ${allCoAuthors[x].coUser.user.userCity}, bzID: ${allCoAuthors[x].author.bzId}',
          icon: allCoAuthors[x].coUser.user.pic,
          verse: allCoAuthors[x].coUser.user.name,
          secondLine: '${allCoAuthors[x].coUser.user.title}',
        ),
  );

  List<Widget> pages = [allBzzDreamList,allUsersDreamList,allAuthorsDreamList];

    double screenWidth = superScreenWidth(context);
    double screenHeight = superScreenHeight(context);

    return MainLayout(
      scrollableAppBar: true,
      appBarRowWidgets: <Widget>[],
      layoutWidget: SwiperLayout(
        pagesLength: pages.length,
        itemBuilder: (BuildContext context, int i) =>
        Container(
          width: screenWidth,
          height: screenHeight,
          child: pages[i],
        )
        ,
      ),
    );
  }
}
