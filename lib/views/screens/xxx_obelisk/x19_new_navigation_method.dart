import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewNavigationMethodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      layoutWidget: Center(
        child: DreamBox(
          height: 50,
          verse: 'kos ommak ya Hesham EL Kady\nit does not work you little shit',
          verseMaxLines: 3,
          verseScaleFactor: 0.7,
          boxFunction: (){
            NavigationService.goTo('/secondPage');
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {

  static const routeName = '/secondPage';

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        pyramids: Iconz.PyramidzYellow,
        appBarType: AppBarType.Basic,
        layoutWidget: Center(
          child: Column(
            children: <Widget>[

              DreamBox(
                height: 50,
                verse: 'Show Dialog',
                boxFunction: (){
                  NavigationService.showMyDialog();
                },
              ),

              DreamBox(
                height: 50,
                verse: 'Go Back',
                boxFunction: (){
                  NavigationService.back();
                },
              ),
            ],
          ),
        )
    );
  }
}



class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static void goTo(routeName){
    navigatorKey.currentState.pushNamed(routeName);
  }

  static void back(){
    navigatorKey.currentState.pop();
  }

  static void showMyDialog(){
    showDialog(
      context: navigatorKey.currentContext,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Hello fuckers'),
      ));
    }

    static final NavigationService _navigationService = NavigationService._internal();

  factory NavigationService(){
    return _navigationService;
  }

  NavigationService._internal();
}