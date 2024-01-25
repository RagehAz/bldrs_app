import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/material.dart';

class ThingBuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ThingBuilder({
    required this.builder,
    this.initialValue,
    this.child,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? initialValue;
  final Widget? child;
  final Function(bool isLoading, String? value, Widget? child) builder;
  /// --------------------------------------------------------------------------
  @override
  _ThingBuilderState createState() => _ThingBuilderState();
/// --------------------------------------------------------------------------
}

class _ThingBuilderState extends State<ThingBuilder> {
  // -----------------------------------------------------------------------------
  String? _value;
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

    _value = widget.initialValue;

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await Future.delayed(const Duration(seconds: 1));

        await _triggerLoading(setTo: true);

        if (mounted == true){
          setState(() {
            _value = 'newValue';
          });
        }

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(ThingBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {

      _isInit = true;
      didChangeDependencies();

    }
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
