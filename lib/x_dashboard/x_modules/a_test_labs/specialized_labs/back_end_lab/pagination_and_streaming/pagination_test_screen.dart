import 'dart:async';

import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_paginator.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/back_end_lab/pagination_and_streaming/streaming_test.dart';
import 'package:flutter/material.dart';

class PaginatorTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PaginatorTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _PaginatorTestState createState() => _PaginatorTestState();
/// --------------------------------------------------------------------------
}

class _PaginatorTestState extends State<PaginatorTest> {
// -----------------------------------------------------------------------------
  FireQueryModel _queryParameters;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'PaginatorTest',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _queryParameters = FireQueryModel(
      collRef: Fire.createSuperCollRef(aCollName: 'testing'),
      limit: 5,
      orderBy: const QueryOrderBy(fieldName: 'time', descending: true),
      onDataChanged: onDataChanged,
    );

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {


        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _scrollController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  ///
  // final ValueNotifier<List<Map<String, dynamic>>> _localMaps = ValueNotifier(<Map<String, dynamic>>[]);
  Future<void> onDataChanged(List<Map<String, dynamic>> newMaps) async {

    blog('RECEIEVED NEW MAPS AHOOOOOOO');

    // final bool _result = await CenterDialog.showCenterDialog(
    //   context: context,
    //   title: 'New data has arrived !',
    //   body: 'Would you like to update local Data ?',
    //   boolDialog: true,
    // );
    //
    // if (_result == true){
    //   _localMaps.value = newMaps;
    //   unawaited(
    //       TopDialog.showTopDialog(
    //         context: context,
    //         firstLine: 'Local Data is synced',
    //         seconds: 1,
    //       )
    //   );
    // }

  }
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    return MainLayout(
      pageTitleVerse: Verse.plain('pagination Test'),
      loading: _loading,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      pyramidType: PyramidType.glass,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        padding: Stratosphere.stratosphereInsets,
        scrollDirection: Axis.horizontal,
        children: <Widget>[

          SizedBox(
            // width: superScreenWidth(context),
            child: FireCollPaginator(
              queryModel: _queryParameters,
              scrollController: _scrollController,
              builder: (_, List<Map<String, dynamic>> _maps, bool isLoading, Widget child){

                return Column(
                  children: <Widget>[

                    ...List.generate(_maps.length, (index){

                      return ColorButton(
                        map: _maps[index],
                      );

                    }),

                    // Loading(loading: isLoading,),

                  ],
                );

              },
            ),
          ),

        ],
      ),
    );

  }
}
