import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/streamers/real/real_coll_paginator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class FlyerCountersAndRecords extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerCountersAndRecords({
    @required this.pageWidth,
    @required this.flyerModel,
    @required this.flyerCounter,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel flyerModel;
  final ValueNotifier<FlyerCounterModel> flyerCounter;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: pageWidth,
      child: ValueListenableBuilder(
        valueListenable: flyerCounter,
        builder: (_, FlyerCounterModel counter, Widget child){

          if (counter == null){
            return const SizedBox();
          }
          else {

            final int _saves = counter.saves ?? 0;
            final int _shares = counter.saves ?? 0;
            final int _views = counter.views ?? 0;

            return Column(
              children: <Widget>[

                /// SAVES
                if (counter != null && _saves > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headline: '$_saves Total flyer saves',
                    icon: Iconz.saveOn,
                    realNodePath: 'saves/${flyerModel.id}/',
                  ),

                /// SHARES
                if (counter != null && _shares > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headline: '$_shares Total shares',
                    icon: Iconz.share,
                    realNodePath: 'shares/${flyerModel.id}/',
                  ),

                /// VIEWS
                if (counter != null && _views > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headline: '$_views Total views',
                    icon: Iconz.viewsIcon,
                    realNodePath: 'views/${flyerModel.id}/',
                  ),

              ],
            );
          }

        },
      ),
    );

  }
}

class FlyerRecordsBox extends StatelessWidget {

  const FlyerRecordsBox({
    @required this.pageWidth,
    @required this.headline,
    @required this.icon,
    @required this.realNodePath,
    Key key
  }) : super(key: key);

  final double pageWidth;
  final String headline;
  final String icon;
  final String realNodePath;

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
                  borderRadius: superBorderAll(context, 10),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: _records.length,
                  itemBuilder: (_, int index){

                    return FutureBuilder(
                      future: UsersProvider.proFetchUserModel(context: context, userID: _records[index].userID),
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
}

class MiniUserBanner extends StatelessWidget {

  const MiniUserBanner({
    @required this.userModel,
    @required this.size,
    Key key
  }) : super(key: key);

  final UserModel userModel;
  final double size;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[

        DreamBox(
          height: size,
          width: size,
          icon: userModel?.pic,
          margins: superInsets(context: context, enRight: 5, enLeft: 5),
          onTap: (){},
        ),

        SizedBox(
          width: size+10,
          height: 30,
          child: SuperVerse(
            verse: userModel?.name,
            size: 1,
            weight: VerseWeight.thin,
            maxLines: 2,
          ),
        ),

      ],
    );

  }
}
