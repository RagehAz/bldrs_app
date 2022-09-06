import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/ggg_mini_user_banner.dart';
import 'package:bldrs/b_views/z_components/streamers/real/real_coll_paginator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerRecordsBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerRecordsBox({
    @required this.pageWidth,
    @required this.headline,
    @required this.icon,
    @required this.realNodePath,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final String headline;
  final String icon;
  final String realNodePath;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        DreamBox(
          height: 30,
          verse: headline,
          verseWeight: VerseWeight.thin,
          verseItalic: true,
          icon: icon,
          iconSizeFactor: 0.6,
          bubble: false,
          verseCentered: false,
          margins: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        ),

        RealCollPaginator(
            nodePath: realNodePath,
            limit: 6,
            scrollController: ScrollController(),
            builder: (_, List<Map<String, dynamic>> maps, bool loading){

              final List<RecordModel> _records = RecordModel.decipherRecords(
                maps: maps,
                fromJSON: true,
              );

              return Container(
                width: pageWidth,
                height: 100,
                decoration: BoxDecoration(
                  color: Colorz.white20,
                  borderRadius: Borderers.superBorderAll(context, 10),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: _records.length,
                  itemBuilder: (_, int index){

                    return FutureBuilder(
                      future: UserProtocols.fetchUser(context: context, userID: _records[index].userID),
                      builder: (_, AsyncSnapshot<dynamic> snapshot){

                        final UserModel _user = snapshot.data;

                        return MiniUserBanner(
                          size: 50,
                          userModel: _user,
                        );

                      },
                    );

                  },
                ),
              );

            }
        ),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
