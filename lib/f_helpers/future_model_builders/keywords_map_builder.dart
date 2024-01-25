// ignore_for_file: avoid_positional_boolean_parameters
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/c_protocols/keywords_protocols/keywords_protocols.dart';
import 'package:flutter/material.dart';

class KeywordMapBuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const KeywordMapBuilder({
    required this.builder,
    this.child,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget? child;
  final Function(bool isLoading, Map<String, dynamic>? value, Widget? child) builder;
  /// --------------------------------------------------------------------------
  @override
  _KeywordMapBuilderState createState() => _KeywordMapBuilderState();
/// --------------------------------------------------------------------------
}

class _KeywordMapBuilderState extends State<KeywordMapBuilder> {
  // -----------------------------------------------------------------------------
  Map<String, dynamic>? _value;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
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

        await _triggerLoading(setTo: true);

        final Map<String, dynamic>? _map = await KeywordsProtocols.fetch();


        if (mounted == true){
          setState(() {
            _value = _map;
          });
        }

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(KeywordMapBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.initialValue != widget.initialValue) {
    //
    //   _isInit = true;
    //   didChangeDependencies();
    //
    // }
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    // _uiImage?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return widget.builder(_loading.value, _value, widget.child);
    // --------------------
  }
// -----------------------------------------------------------------------------
}
