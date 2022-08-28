

import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class ReOrderListTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ReOrderListTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ReOrderListTestState createState() => _ReOrderListTestState();
/// --------------------------------------------------------------------------
}

class _ReOrderListTestState extends State<ReOrderListTest> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
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
  /// XXXX
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  final List<Color> _colors = <Color>[
    Colorz.bloodTest,
    Colorz.yellow125,
    Colorz.blue255,
    Colorz.green50,
    Colorz.lightGrey255,
  ];
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        WideButton(
          translate: false,
          verse:  'Fuck this',
          onTap: () async {

            blog('fuck this');

          },
        ),

        Container(
          width: Scale.superScreenWidth(context),
          height: 400,
          color: Colorz.bloodTest,
          child: ReorderableListView.builder(
            // physics: const BouncingScrollPhysics(),
            itemCount: _colors.length,
            // buildDefaultDragHandles: true,

            onReorder: (oldIndex, newIndex) {
              // setState(() {
              //   if (newIndex > oldIndex) {
              //     newIndex = newIndex - 1;
              //   }
              //   final element = _colors.removeAt(oldIndex);
              //   _colors.insert(newIndex, element);
              // });

              },
            itemBuilder: (_, int index){

              return WideButton(
                key: ValueKey<String>(_colors[index].toString()),
                verse: _colors[index].toString(),
                translate: false,
                color: _colors[index],
              );

              },

          ),
        ),

      ],
    );

  }

}
