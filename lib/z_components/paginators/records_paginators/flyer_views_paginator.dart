import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_view_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class FlyerViewsPaginator extends StatefulWidget {
  // --------------------------------------------------------------------------
  const FlyerViewsPaginator({
    required this.flyerID,
    required this.bzID,
    required this.builder,
    required this.limit,
    super.key
  });
  // ------------------------------
  final String flyerID;
  final String bzID;
  final int limit;
  final Function(BuildContext, List<FlyerViewModel>, bool, Widget?, ScrollController controller) builder;
  // ------------------------------
  @override
  _FlyerViewsPaginatorState createState() => _FlyerViewsPaginatorState();
  // --------------------------------------------------------------------------
}

class _FlyerViewsPaginatorState extends State<FlyerViewsPaginator> {
  // --------------------------------------------------------------------------
  late PaginationController _paginatorController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _paginatorController = PaginationController.initialize(
      mounted: mounted,
      addExtraMapsAtEnd: true,
      // idFieldName: 'id',
      // onDataChanged: ,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {


      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _paginatorController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return RealCollPaginator(
        paginationController: _paginatorController,
        paginationQuery: RealQueryModel.createAscendingQueryModel(
          path: RealPath.records_flyers_bzID_flyerID_recordingViews(
            bzID: widget.bzID,
            flyerID: widget.flyerID,
          ),
          limit: widget.limit,
          idFieldName: 'id',
          fieldNameToOrderBy: 'time',
        ),
        builder: (_, List<Map<String, dynamic>>? maps, bool loading, Widget? child){

          final List<FlyerViewModel> _records = FlyerViewModel.decipherMaps(
            maps: maps,
          );

          return widget.builder(_, _records, loading, child, _paginatorController.scrollController);
        }

        );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
