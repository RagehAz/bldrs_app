import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/saved_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/buttons/flyer_type_button.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_sliver_app_bar_small.dart';
import 'package:bldrs/c_controllers/e_saves_controller.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedFlyersScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreenView({
    @required this.selectionMode,
    @required this.currentFlyerType,
    @required this.onChangeCurrentFlyerType,
    @required this.flyersGridScrollController,
    @required this.sliverNestedScrollController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool selectionMode;
  final ValueNotifier<FlyerType> currentFlyerType;
  final ValueChanged<FlyerType> onChangeCurrentFlyerType;
  final ScrollController flyersGridScrollController;
  final ScrollController sliverNestedScrollController;
  /// --------------------------------------------------------------------------
  bool _isSelected({
    @required FlyerType flyerType,
    @required FlyerType currentFlyerType,
  }){

    bool _isSelected = false;

    if (currentFlyerType == flyerType){
      _isSelected = true;
    }

    return _isSelected;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return NestedScrollView(
      key: const ValueKey<String>('SavedFlyersScreenView'),
      // controller: sliverNestedScrollController,
      physics: const BouncingScrollPhysics(),
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){

        return <Widget>[

          /// SAVED FLYER SCREEN SLIVER TABS
          ValueListenableBuilder(
            valueListenable: currentFlyerType,
            builder: (_, FlyerType _currentFlyerType, Widget childB){

              return BldrsSliverAppBarSmall(
                content: ListView.builder(
                  controller: ScrollController(),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: sectionsList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (_, index){

                    final FlyerType _flyerType = sectionsList[index];

                    final String _flyerTypeString = cipherFlyerType(_flyerType);

                    final bool _typeIsSelected = _isSelected(
                      flyerType: _flyerType,
                      currentFlyerType: _currentFlyerType,
                    );

                    return
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.5),
                        child: FlyerTypeButton(
                            key: ValueKey<String>('saved_flyer_tab_button_$_flyerTypeString'),
                            verse: TextGen.flyerTypePluralStringer(context, _flyerType),
                            icon: Iconizer.flyerTypeIconOff(_flyerType),
                            isSelected: _typeIsSelected,
                            onTap: () => onChangeCurrentFlyerType(_flyerType),
                        ),
                      );

                  },
                ),
              );

            },
          ),
        ];

      },

      /// FLYERS GRIDS PAGES
      body: Consumer<FlyersProvider>(
        builder: (_, FlyersProvider flyersProvider, Widget child){

          final List<FlyerModel> _savedFlyers = flyersProvider.savedFlyers;
          final List<FlyerModel> _selectedFlyers = flyersProvider.selectedFlyers;

          return

            ValueListenableBuilder(
                valueListenable: currentFlyerType,
                builder: (_, FlyerType _currentFlyerType, Widget childB){

                  final List<FlyerModel> _flyersOfThisType = FlyerModel.filterFlyersByFlyerType(
                    flyers: _savedFlyers,
                    flyerType: _currentFlyerType,
                  );

                  return

                    SavedFlyersGrid(
                      key: ValueKey<String>('Saved_flyers_page_$_currentFlyerType'),
                      flyersGridScrollController: flyersGridScrollController,
                      selectionMode: selectionMode,
                      onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
                        context: context,
                        flyer: flyer,
                      ),
                      selectedFlyers: _selectedFlyers,
                      flyers: _flyersOfThisType,
                    );

                }
            );

        },
      ),

    );

  }
}
