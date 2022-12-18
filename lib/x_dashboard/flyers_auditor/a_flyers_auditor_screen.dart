import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/e_back_end/x_queries/flyers_queries.dart';
import 'package:bldrs/e_back_end/z_helpers/pagination_controller.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/x_dashboard/flyers_auditor/x_flyer_auditor_controller.dart';
import 'package:flutter/material.dart';

class FlyersAuditor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyersAuditor({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _FlyersAuditorState createState() => _FlyersAuditorState();
  /// --------------------------------------------------------------------------
}

class _FlyersAuditorState extends State<FlyersAuditor> {
  // -----------------------------------------------------------------------------
  PaginationController _paginatorController;
  // --------------------
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _paginatorController = PaginationController.initialize(
      addExtraMapsAtEnd: false,
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
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _scrollController.dispose();
    _loading.dispose();
    _paginatorController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

    return MainLayout(
      pageTitleVerse: Verse.plain('Flyers Auditor'),
      appBarType: AppBarType.basic,
      loading: _loading,
      skyType: SkyType.black,
      layoutWidget: FireCollPaginator(
        paginationQuery: flyerAuditingPaginationQuery(),
        scrollController: _scrollController,
        paginationController: _paginatorController,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

          final List<FlyerModel> _flyers = FlyerModel.decipherFlyers(
              maps: maps,
              fromJSON: false,
          );

          if (Mapper.checkCanLoopList(_flyers) == true){

            return FlyersGrid(
              flyers: _flyers,
              gridWidth: _screenWidth,
              gridHeight: _screenHeight,
              scrollController: _scrollController,
              screenName: 'flyerAuditorScreenGrid',
              isLoadingGrid: isLoading,
              onFlyerOptionsTap: (FlyerModel flyer) => onFlyerOptionsTap(
                context: context,
                flyerModel: flyer,
                controller: _paginatorController,
              ),
            );

          }

          else {

            return const Center(
              child: SuperVerse(
                verse: Verse(
                  text: 'No Flyers Left',
                  translate: false,
                ),
                weight: VerseWeight.black,
                italic: true,
                size: 4,
              ),
            );

          }

        },
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
