import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/c_protocols/media_protocols/protocols/media_protocols.dart';
import 'package:flutter/material.dart';

class BldrsImagePathToPicModel extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsImagePathToPicModel({
    required this.imagePath,
    required this.builder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String imagePath;
  final Function(bool isLoading, MediaModel? picModel) builder;
  /// --------------------------------------------------------------------------
  @override
  _BldrsImagePathToPicModelState createState() => _BldrsImagePathToPicModelState();
  /// --------------------------------------------------------------------------
}

class _BldrsImagePathToPicModelState extends State<BldrsImagePathToPicModel> {
  // -----------------------------------------------------------------------------
  bool _isFetching = true;
  MediaModel? _picModel;
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

      _triggerLoading(setTo: true).then((_) async {

        final MediaModel? _image = await MediaProtocols.fetchMedia(
          widget.imagePath,
        );

        if (mounted == true){
          setState(() {
            _picModel = _image;
            _isFetching = false;
          });
        }

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(BldrsImagePathToPicModel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {

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
    return widget.builder(_isFetching, _picModel);
    // --------------------
  }
// -----------------------------------------------------------------------------
}
