import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizers;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;

class StreamingTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StreamingTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _StreamingTestState createState() => _StreamingTestState();
/// --------------------------------------------------------------------------
}

class _StreamingTestState extends State<StreamingTest> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzAuthorsPage',
    );
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
      pageTitle: 'Streaming Test',
        loading: _loading,
        listWidgets: <Widget>[

          WideButton(
            verse: 'Add Data',
            onTap: () async {

              await Fire.createDoc(
                  context: context,
                  collName: 'testing',
                  input: {
                    'time' : Timers.cipherTime(time: DateTime.now(), toJSON: false),
                    'id' : Numeric.createUniqueID(),
                    'color' : Colorizers.cipherColor(Colorizers.createRandomColor()),
                  },
              );

              await TopDialog.showSuccessDialog(context : context);

            },
          ),



        ],
    );

  }
}
