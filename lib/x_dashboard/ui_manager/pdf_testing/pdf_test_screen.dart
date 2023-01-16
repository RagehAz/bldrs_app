import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pdf_bubble/pdf_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:flutter/material.dart';

class PDFTestingScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PDFTestingScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _PDFTestingScreenState createState() => _PDFTestingScreenState();
/// --------------------------------------------------------------------------
}

class _PDFTestingScreenState extends State<PDFTestingScreen> {
  // -----------------------------------------------------------------------------
  PDFModel _existingPDF;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _flyerID;
  String _bzID;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
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

      _triggerLoading(setTo: true).then((_) async {

        final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

        final BzModel _bzModel = await BzProtocols.fetchBz(
          context: context,
          bzID: _userModel.myBzzIDs.first,
        );

        final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: _bzModel.flyersIDs.first,
        );

        setState(() {
          _flyerID = _flyerModel.id;
          _bzID = _bzModel.id;
        });

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        if (_flyerID != null)
        Form(
          key: _formKey,
          child: PDFSelectionBubble(
              formKey: _formKey,
              onChangePDF: (PDFModel pdfModel) async {

                pdfModel.blogPDFModel(
                  invoker: 'PDFTestingScreen',
                );

              },
              onDeletePDF: () async {
                blog('deleted pdf');
              },
              existingPDF: _existingPDF,
              appBarType: AppBarType.non,
              canValidate: true,
              flyerID: _flyerID,
              bzID: _bzID,
          ),
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
