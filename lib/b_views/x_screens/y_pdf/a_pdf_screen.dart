import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PDFScreen({
    @required this.file,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final File file;
  @override
  _PDFScreenState createState() => _PDFScreenState();
/// --------------------------------------------------------------------------
}

class _PDFScreenState extends State<PDFScreen> {
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
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        Container(
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenHeight(context),
          color: Colorz.bloodTest,
          child: FutureBuilder(
            future: Floaters.getUint8ListFromFile(widget.file),
            builder: (_, AsyncSnapshot<Uint8List> snapshot){

              return PDFView(
                pdfData: snapshot.data,
              );


            },
          ),
        ),

      ],
    );

  }

}
