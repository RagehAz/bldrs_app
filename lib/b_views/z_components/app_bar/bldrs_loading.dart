import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_strips.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AppBarLoading extends StatelessWidget {

  const AppBarLoading({
    @required this.loading,
    @required this.swipeDirection,
    @required this.index,
    @required this.numberOfStrips,
    Key key
  }) : super(key: key);

  final ValueNotifier<bool> loading;
  final ValueNotifier<SwipeDirection> swipeDirection;
  final ValueNotifier<int> index;
  final int numberOfStrips;

  @override
  Widget build(BuildContext context) {

    final double _abWidth = BldrsAppBar.width(context);
    final EdgeInsets _margins = EdgeInsets.only(top: Ratioz.appBarSmallHeight - StaticStrips.stripThickness(_abWidth));


    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (_, bool isLoading, Widget child){

        if (isLoading == true){
          return StaticProgressBar(
            index: 0,
            numberOfSlides: 1,
            opacity: 0.4,
            swipeDirection: SwipeDirection.freeze,
            loading: isLoading,
            flyerBoxWidth: _abWidth,
            margins: _margins,
          );
        }

        else if (index != null){
          return ValueListenableBuilder(
              valueListenable: index,
              builder: (_, int _index, Widget childB){

                return ValueListenableBuilder(
                    valueListenable: swipeDirection,
                    builder: (_, SwipeDirection direction, Widget childC){

                      return StaticProgressBar(
                        index: _index,
                        numberOfSlides: numberOfStrips,
                        opacity: 1,
                        swipeDirection: direction,
                        loading: isLoading,
                        flyerBoxWidth: _abWidth,
                        margins: _margins,
                      );

                    }
                );

              }
          );
        }

        else {
          return const SizedBox();
        }

      },
    );

  }
}
