import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:flutter/material.dart';

class BzzBuilder extends StatefulWidget {
  // --------------------------------------------------------------------------
  const BzzBuilder({
    required this.bzzIDs,
    required this.builder,
    this.child,
    super.key
  });
  // --------------------
  final List<String>? bzzIDs;
  final Widget Function(bool loading, List<BzModel> bzzModels, Widget? child) builder;
  final Widget? child;
  // --------------------
  @override
  _BzzBuilderState createState() => _BzzBuilderState();
  // --------------------------------------------------------------------------
}

class _BzzBuilderState extends State<BzzBuilder> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<BzModel>> _bzzModelsNotifier = ValueNotifier([]);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _loadBzz(widget.bzzIDs);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------

  @override
  void didUpdateWidget(BzzBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (Lister.checkListsAreIdentical(list1: oldWidget.bzzIDs, list2: widget.bzzIDs) == false) {
      unawaited(_loadBzz(widget.bzzIDs));
    }

  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _bzzModelsNotifier.dispose();
    super.dispose();
  }
  // --------------------
  Future<void> _loadBzz(List<String>? bzzIDs) async {

    if (Lister.checkCanLoop(bzzIDs) == true){

      await _triggerLoading(setTo: true);

      final List<BzModel> _bzz = await BzProtocols.fetchBzz(
        bzzIDs: bzzIDs,
      );

      setNotifier(
        notifier: _bzzModelsNotifier,
        mounted: mounted,
        value: _bzz,
      );

      await _triggerLoading(setTo: false);

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
        valueListenable: _loading,
        child: widget.child,
        builder: (_, bool isLoading, Widget? child){

          return ValueListenableBuilder(
              valueListenable: _bzzModelsNotifier,
              child: child,
              builder: (_, List<BzModel> bzzModels, Widget? ch){

                return widget.builder(isLoading, bzzModels, ch);

              },
          );

        },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
