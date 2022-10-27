import 'dart:async';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/fire_base_lab/streaming_test.dart';
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
  // final ValueNotifier<List<Map<String, dynamic>>> _localMaps = ValueNotifier(<Map<String, dynamic>>[]);
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _queryParameters = FireQueryModel(
      collRef: Fire.getSuperCollRef(aCollName: 'testing'),
      // idFieldName: 'id',
      limit: 5,
      orderBy: const QueryOrderBy(fieldName: 'time', descending: true),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    // _loading.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
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
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitleVerse: Verse.plain('pagination Test'),
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
              paginationQuery: _queryParameters,
              scrollController: _scrollController,
              onDataChanged: onDataChanged,
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
  // -----------------------------------------------------------------------------
}
