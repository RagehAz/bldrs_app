import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:flutter/material.dart';

class StatefulTest extends StatefulWidget {


  @override
  _StatefulTestState createState() => _StatefulTestState();
}

class _StatefulTestState extends State<StatefulTest> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return TestLayout(
      screenTitle: 'Stateful test',
      appbarButtonVerse: 'print',
      appbarButtonOnTap: (){
        print('testing');
        },

      listViewWidgets: <Widget>[

        ],
    );
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void didUpdateWidget(covariant StatefulTest oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
// -----------------------------------------------------------------------------
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
// -----------------------------------------------------------------------------
}
