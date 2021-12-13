import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key key}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final bool _loading = false;
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.dvBlankSVG,
      appBarRowWidgets: const <Widget>[],
      loading: _loading,
      pageTitle: 'Questions',
      appBarType: AppBarType.basic,
      layoutWidget: Column(
        children: const <Widget>[
          Stratosphere(),
        ],
      ),
    );
  }
}
