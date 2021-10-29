import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
//   Future <void> _triggerLoading({Function function}) async {
//
//     if (function == null){
//       setState(() {
//         _loading = !_loading;
//       });
//     }
//
//     else {
//       setState(() {
//         _loading = !_loading;
//         function();
//       });
//     }
//
//     _loading == true?
//     print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
//   }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarRowWidgets: const <Widget>[],
      loading: _loading,
      pageTitle: 'Questions',
      appBarType: AppBarType.Basic,
      layoutWidget: Column(
        children: const <Widget>[

          const Stratosphere(),

        ],
      ),
    );
  }
}
