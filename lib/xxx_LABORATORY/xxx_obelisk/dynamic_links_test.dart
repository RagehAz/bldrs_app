import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/dynamic_links.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DynamicLinkTest extends StatefulWidget {
  static const routeName = Routez.DynamicLinkTest;


  @override
  _DynamicLinkTestState createState() => _DynamicLinkTestState();
}

class _DynamicLinkTestState extends State<DynamicLinkTest> {
  String _link = 'nothing';
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _getDynamicLink () async {
    print('get dynamic Link isa');

    dynamic _dynamicLink = await DynamicLinksApi().createDynamicLink(context, true);

    setState(() {
      _link = _dynamicLink;
    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _thing = ModalRoute.of(context).settings.arguments as String;

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      // appBarBackButton: true,
      appBarType: AppBarType.Basic,
      tappingRageh: (){print('dynamic link isa');},
      loading: _loading,
      pageTitle: 'Dynamic Links Test',
      appBarRowWidgets: [],
      layoutWidget: ListView(

        children: <Widget>[

          Stratosphere(),

          SuperVerse(
            verse: _link,
            labelColor: Colorz.White30,
            onTap: (){

              print('_link : $_link');
              // launchURL(_link);

            },
          ),

          DreamBox(
            height: 55,
            margins: 10,
            verse: 'the thing is : $_thing',
            verseColor: Colorz.Black230,
            color: Colorz.White255,
            onTap: (){},
          ),

          DreamBox(
            height: 55,
            margins: 10,
            verse: 'Get Dynamic Link',
            color: Colorz.Yellow255,
            onTap: () => _getDynamicLink(),
          ),

        ],
      ),
    );
  }

}
