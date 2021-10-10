import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/saved_flyers_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TASK : if flyer is deleted from database, its ID will still remain in user's saved flyers
/// then we need to handle this situation
class SavedFlyersScreen extends StatefulWidget {
  final bool selectionMode;

  SavedFlyersScreen({
    this.selectionMode = false,
});

  @override
  _SavedFlyersScreenState createState() => _SavedFlyersScreenState();
}

class _SavedFlyersScreenState extends State<SavedFlyersScreen> with SingleTickerProviderStateMixin {
  int _currentTabIndex;
  List<Section> _sectionsList;
  List<TinyFlyer> _allTinyFlyers;
  TabController _tabController;
  List<TinyFlyer> _selectedTinyFlyers;
// -----------------------------------------------------------------------------
  @override
  void initState() {
     super.initState();
     _sectionsList = addAllButtonToSections();
     _currentTabIndex = 0;

     final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
     _allTinyFlyers =  _flyersProvider.savedTinyFlyers;

     _tabModels = createTabModels();

     _tabController = TabController(vsync: this, length: _sectionsList.length);

     _tabController.addListener(() async {
       _onSetSection(_tabController.index);
     });

     _tabController.animation
       ..addListener(() {
         if(_tabController.indexIsChanging == false){
         _onSetSection((_tabController.animation.value).round());
         }
       });

     ///
     if(widget.selectionMode == true){
       _selectedTinyFlyers = [];
     }
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  List<Section> addAllButtonToSections(){
    const List<Section> _originalList = SectionClass.SectionsList;
    const List<Section> _newListWithAddButton = <Section>[Section.All,..._originalList];
    return _newListWithAddButton;
  }
// -----------------------------------------------------------------------------
  List<TabModel> _tabModels = [];
  List<TabModel> createTabModels(){
    final List<TabModel> _models = <TabModel>[];

    for (int i = 0; i < _sectionsList.length; i++){
      _models.add(
          TabModel(

            tabButton: TabButton(
              verse: TextGenerator.sectionStringer(context, _sectionsList[i]),
              icon: Iconizer.sectionIconOff(_sectionsList[i]),
              isSelected: _sectionsList[_currentTabIndex] == _sectionsList[i],
              onTap: (){

                print('tapping on ${_sectionsList[i]}');
                _onSetSection(i);

              },
            ),

            page: SavedFlyersGrid(
              selectionMode: widget.selectionMode,
              onSelectFlyer: (TinyFlyer tinyFlyer) => _onSelectFlyer(tinyFlyer),
              selectedTinyFlyers: _selectedTinyFlyers,
              tinyFlyers: TinyFlyer.filterTinyFlyersBySection(
                tinyFlyers : _allTinyFlyers,
                section: _sectionsList[i],
              ),
            ),

          )
      );
    }

    return _models;
  }
// -----------------------------------------------------------------------------
  Future<void> _onSetSection(int index) async {

    setState(() {
      _currentTabIndex = index;
      _tabModels = createTabModels();
    });

    _tabController.animateTo(index, curve: Curves.easeIn, duration: Ratioz.duration150ms);

  }
// -----------------------------------------------------------------------------
  void _onSelectFlyer(TinyFlyer tinyFlyer){

    print('selecting flyer : ${tinyFlyer.flyerID}');

    final bool _alreadySelected = TinyFlyer.tinyFlyersContainThisID(
      tinyFlyers: _selectedTinyFlyers,
      flyerID: tinyFlyer.flyerID,
    );

    if (_alreadySelected == true){
      setState(() {
        _selectedTinyFlyers.remove(tinyFlyer);
        _tabModels = createTabModels();
      });
    }

    else {
      setState(() {
        _selectedTinyFlyers.add(tinyFlyer);
        _tabModels = createTabModels();
      });
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return
      TabLayout(
        tabModels: _tabModels,
        pageTitle: 'Saved flyers ', //${TextGenerator.sectionStringer(context, _sectionsList[_currentIndex])}',
        tabController: _tabController,
        currentIndex: _currentTabIndex,
        selectionMode: widget.selectionMode,
        selectedItems: _selectedTinyFlyers,
      );

  }


}