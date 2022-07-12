import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class LocalAssetChecker extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LocalAssetChecker({
    @required this.child,
    @required this.asset,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final dynamic asset;
  /// --------------------------------------------------------------------------
  @override
  State<LocalAssetChecker> createState() => _LocalAssetCheckerState();
/// --------------------------------------------------------------------------
}

class _LocalAssetCheckerState extends State<LocalAssetChecker> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'LocalAssetChecker',);
    }
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _exists = ValueNotifier(false); /// tamam disposed
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted && _exists != null) {

      _triggerLoading().then((_) async {

        final bool _assetExists = await Imagers.localAssetExists(widget.asset);

        if (mounted){
          _exists.value = _assetExists;
          await _triggerLoading();
        }

      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _exists.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.asset == null){
      return const SizedBox();
    }

    else {

      return ValueListenableBuilder(
          key: const ValueKey<String>('LocalAssetChecker'),
          valueListenable: _exists,
          child: widget.child,
          builder: (_, bool assetExists, Widget child){

            /// WHEN ASSET FOUND
            if (assetExists == true){
              return child;
            }

            /// WHEN ASSET NOT FOUND
            else {
              return const SizedBox();
            }

          }
      );

    }

  }
}
