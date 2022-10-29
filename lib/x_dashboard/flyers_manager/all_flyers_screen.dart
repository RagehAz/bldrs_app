import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/e_back_end/x_queries/flyers_queries.dart';
import 'package:bldrs/e_back_end/z_helpers/pagination_controller.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class AllFlyersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AllFlyersScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AllFlyersScreenState createState() => _AllFlyersScreenState();
  /// --------------------------------------------------------------------------
}

class _AllFlyersScreenState extends State<AllFlyersScreen> {
  // -----------------------------------------------------------------------------
  PaginationController _paginationController;
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

    _paginationController = PaginationController.initialize(
      addExtraMapsAtEnd: false,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   unawaited(_triggerLoading(setTo: false));
      //
      // });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onFlyerOptionsTap(FlyerModel flyer) async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: 80,
        numberOfWidgets: 2,
        builder: (_){

          return <Widget>[

            /// DELETE FLYER
            BottomDialog.wideButton(
                context: context,
                verse:  Verse.plain('Delete'),
                icon: Iconz.xLarge,
                onTap: () async {

                  await Nav.goBack(context: context);

                  final BzModel bzModel = await BzProtocols.fetch(
                      context: context,
                      bzID: flyer.bzID,
                  );

                  await FlyerProtocols.wipeTheFlyer(
                    context: context,
                    flyerModel: flyer,
                    bzModel: bzModel,
                    showWaitDialog: true,
                    isDeletingBz: false,
                  );

                  _paginationController.deleteMapByID(
                    id: flyer.id,
                  );

                  unawaited(Dialogs.showSuccessDialog(
                      context: context
                  ));

                }
            ),

            /// PROMOTE FLYER
            // BottomDialog.wideButton(
            //     context: context,
            //     verse:  'Promote Flyer',
            //     icon: Iconz.star,
            //     onTap: () async {
            //       await goToNewScreen(context, FlyerPromotionScreen(
            //         flyer: flyer,
            //       ));
            //     }
            // ),

          ];

        },
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitleVerse: Verse.plain('All Flyers'),
      appBarRowWidgets: const <Widget>[],
      // loading: _loading,
      layoutWidget: FireCollPaginator(
        paginationQuery: allFlyersPaginationQuery(),
        paginationController: _paginationController,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

          final List<FlyerModel> _flyers = FlyerModel.decipherFlyers(
              maps: maps,
              fromJSON: false,
          );

          return FlyersGrid(
            gridWidth: Scale.superScreenWidth(context),
            gridHeight: Scale.superScreenHeight(context),
            // numberOfColumns: 2,
            flyers: _flyers,
            scrollController: ScrollController(),
            heroPath: 'allFlyersScreenGrid',
            onFlyerOptionsTap: _onFlyerOptionsTap,
          );

        },
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
