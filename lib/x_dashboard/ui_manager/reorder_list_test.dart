import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
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
  /*
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
   */
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

      // _triggerLoading(setTo: true).then((_) async {
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// XXXX
  @override
  void dispose() {
    // _loading.dispose();
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
      // loading: _loading,
      listWidgets: <Widget>[

        WideButton(
          verse: Verse.plain('ReOrderListTest wide button'),
          onTap: () async {

            blog('ReOrderListTest wide button on tap');

          },
        ),

        Container(
          width: Scale.screenWidth(context),
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
                verse:Verse.plain(_colors[index].toString()),
                color: _colors[index],
              );

              },

          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
