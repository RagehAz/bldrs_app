import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_back_end/c_real/real_models/real_query_model.dart';
import 'package:bldrs/e_back_end/c_real/widgets/real_coll_paginator.dart';
import 'package:bldrs/e_back_end/c_real/widgets/real_coll_streamer.dart';
import 'package:bldrs/e_back_end/c_real/widgets/real_doc_streamer.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/fire_base_lab/streaming_test.dart';
import 'package:flutter/material.dart';

class RealTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const RealTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<RealTestScreen> createState() => _RealTestScreenState();
/// --------------------------------------------------------------------------
}

class _RealTestScreenState extends State<RealTestScreen> {
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const String _collName = 'colors';
    const String _dummyDocName = 'colorID';

    return MainLayout(
      pyramidType: PyramidType.yellow,
      pyramidsAreOn: true,
      appBarType: AppBarType.scrollable,
      appBarRowWidgets: <Widget>[

        RealDocStreamer(
          collName: 'colors',
          docName: 'colorID',
          builder: (_, Map<String, dynamic> map){

            return AppBarButton(
              verse: Verse.plain('STREAM'),
              buttonColor: map == null ? Colorz.white255 : Colorizer.decipherColor(map['color']),
            );

          },
        ),

        /// CREATE
        AppBarButton(
          verse: Verse.plain('CREATE'),
          onTap: () async {

            final Color _color = Colorizer.createRandomColor();

            final Map<String, dynamic> _map = {
              'index' : Numeric.createRandomIndex(listLength: 10),
              'color' : Colorizer.cipherColor(_color),
              'time' : Timers.cipherTime(time: DateTime.now(), toJSON: true),
            };

            final Map<String, dynamic> _maw = await Real.createDoc(
              collName: _collName,
              map: _map,
              addDocIDToOutput: true,
            );

            Mapper.blogMap(_maw, invoker: 'MAW IS');

          },
        ),

        /// CREATE NAMED
        AppBarButton(
          verse: Verse.plain('CREATE NAMED'),
          onTap: () async {

            final Color _color = Colorizer.createRandomColor();

            final Map<String, dynamic> _map = {
              'id' : Numeric.createUniqueID().toString(),
              'color' : Colorizer.cipherColor(_color),
              'time' : Timers.cipherTime(time: DateTime.now(), toJSON: true),
            };

            await Real.createNamedDoc(
              collName: _collName,
              docName: _dummyDocName,
              map: _map,
            );

          },
        ),

        /// READ
        AppBarButton(
          verse: Verse.plain('READ'),
          onTap: () async {

            final Map<String, dynamic> _map = await Real.readDoc(
              collName: _collName,
              docName: _dummyDocName,
            );

            Mapper.blogMap(_map, invoker: 'REAL READ DOC TEST');

          },
        ),

        /// READ ONCE
        AppBarButton(
          verse: Verse.plain('READ ONCE'),
          onTap: () async {

            final Map<String, dynamic> _map = await Real.readDocOnce(
              collName: _collName,
              docName: _dummyDocName,
            );

            Mapper.blogMap(_map, invoker: 'REAL READ DOC TEST');

          },
        ),

        /// UPDATE
        AppBarButton(
          verse: Verse.plain('UPDATE'),
          onTap: () async {

            final Color _color = Colorizer.createRandomColor();

            final Map<String, dynamic> _map = {
              'color' : Colorizer.cipherColor(_color),
              'name' : 'Ahmed',
              'time' : Timers.cipherTime(time: DateTime.now(), toJSON: true),
            };

            await Real.updateDoc(
              collName: _collName,
              docName: _dummyDocName,
              map: _map,
            );

          },
        ),

        /// UPDATE FIELD
        AppBarButton(
          verse: Verse.plain('UPDATE FIELD'),
          onTap: () async {

            await Real.updateDocField(
              collName: _collName,
              docName: _dummyDocName,
              fieldName: 'name',
              value: 'diko',
            );

          },
        ),

        /// DELETE FIELD
        AppBarButton(
          verse: Verse.plain('DELETE FIELD'),
          onTap: () async {

            await Real.deleteField(
              collName: _collName,
              docName: _dummyDocName,
              fieldName: 'name',
            );

          },
        ),

        /// DELETE DOC
        AppBarButton(
          verse: Verse.plain('DELETE DOC'),
          onTap: () async {

            await Real.deleteDoc(
              collName: _collName,
              docName: _dummyDocName,
            );

          },
        ),

      ],
      layoutWidget: Row(
        children: <Widget>[

          SizedBox(
            width: Scale.superScreenWidth(context) * 0.5,
            height: Scale.superScreenHeight(context),
            child: RealCollPaginator(
                realQueryModel: const RealQueryModel(
                    path: 'colors/'
                ),
                scrollController: _scrollController,
                builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: Stratosphere.stratosphereSandwich,
                    controller: _scrollController,
                    children: <Widget>[
                      if (maps != null)
                        ...List.generate(maps.length, (index){
                          return GestureDetector(
                            onTap: () async {

                              await Real.deleteDoc(
                                collName: _collName,
                                docName: maps[index]['id'],
                              );

                              },
                            child: ColorButton(
                              map: maps[index],
                              mapIsFromJSON: true,
                            ),
                          );
                        }),
                      // Loading(loading: isLoading,),
                    ],
                  );

                }),
          ),

          SizedBox(
            width: Scale.superScreenWidth(context) * 0.5,
            height: Scale.superScreenHeight(context),
            child: RealCollStreamer(
                collName: 'colors',
                builder: (_, List<Map<String, dynamic>> maps){

                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: Stratosphere.stratosphereSandwich,
                    controller: ScrollController(),
                    children: <Widget>[

                      if (maps != null)
                        ...List.generate(maps.length, (index){

                          return GestureDetector(
                            onTap: () async {

                              await Real.deleteDoc(
                                collName: _collName,
                                docName: maps[index]['id'],
                              );

                            },
                            child: ColorButton(
                              map: maps[index],
                              mapIsFromJSON: true,
                            ),
                          );

                        }),


                      // Loading(loading: isLoading,),

                    ],
                  );

                }
            ),
          ),

        ],
      ),
    );

  }
}
