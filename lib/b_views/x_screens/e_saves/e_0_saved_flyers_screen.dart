import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/tab_layout.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/saved_flyers_grid.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TASK : if flyer is deleted from database, its ID will still remain in user's saved flyers
/// then we need to handle this situation
class SavedFlyersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreen({
    this.selectionMode = false,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final bool selectionMode;

  /// --------------------------------------------------------------------------
  @override
  _SavedFlyersScreenState createState() => _SavedFlyersScreenState();

  /// --------------------------------------------------------------------------
}

class _SavedFlyersScreenState extends State<SavedFlyersScreen>
    with SingleTickerProviderStateMixin {
  int _currentTabIndex;
  List<SectionClass.Section> _sectionsList;
  List<FlyerModel> _allFlyers;
  TabController _tabController;
  List<FlyerModel> _selectedFlyers;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _sectionsList = addAllButtonToSections();
    _currentTabIndex = 0;

    final FlyersProvider _flyersProvider =
        Provider.of<FlyersProvider>(context, listen: false);
    _allFlyers = _flyersProvider.savedFlyers;

    _tabModels = createTabModels();

    _tabController = TabController(vsync: this, length: _sectionsList.length);

    _tabController.addListener(() async {
      await _onSetSection(_tabController.index);
    });

    _tabController.animation.addListener(() {
      if (_tabController.indexIsChanging == false) {
        _onSetSection((_tabController.animation.value).round());
      }
    });

    ///
    if (widget.selectionMode == true) {
      _selectedFlyers = <FlyerModel>[];
    }
  }

// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

// -----------------------------------------------------------------------------
  List<SectionClass.Section> addAllButtonToSections() {
    const List<SectionClass.Section> _originalList = SectionClass.sectionsList;
    const List<SectionClass.Section> _newListWithAddButton =
        <SectionClass.Section>[SectionClass.Section.all, ..._originalList];
    return _newListWithAddButton;
  }

// -----------------------------------------------------------------------------
  List<TabModel> _tabModels = <TabModel>[];
  List<TabModel> createTabModels() {
    final List<TabModel> _models = <TabModel>[];

    for (int i = 0; i < _sectionsList.length; i++) {
      _models.add(TabModel(
        tabButton: TabButton(
          verse: TextGen.sectionStringer(context, _sectionsList[i]),
          icon: Iconizer.sectionIconOff(_sectionsList[i]),
          isSelected: _sectionsList[_currentTabIndex] == _sectionsList[i],
          onTap: () {
            blog('tapping on ${_sectionsList[i]}');
            _onSetSection(i);
          },
        ),
        page: SavedFlyersGrid(
          selectionMode: widget.selectionMode,
          onSelectFlyer: (FlyerModel flyer) => _onSelectFlyer(flyer),
          selectedFlyers: _selectedFlyers,
          flyers: FlyerModel.filterFlyersBySection(
            flyers: _allFlyers,
            section: _sectionsList[i],
          ),
        ),
      ));
    }

    return _models;
  }

// -----------------------------------------------------------------------------
  Future<void> _onSetSection(int index) async {
    setState(() {
      _currentTabIndex = index;
      _tabModels = createTabModels();
    });

    _tabController.animateTo(index,
        curve: Curves.easeIn, duration: Ratioz.duration150ms);
  }

// -----------------------------------------------------------------------------
  void _onSelectFlyer(FlyerModel flyer) {
    blog('selecting flyer : ${flyer.id}');

    final bool _alreadySelected = FlyerModel.flyersContainThisID(
      flyers: _selectedFlyers,
      flyerID: flyer.id,
    );

    if (_alreadySelected == true) {
      setState(() {
        _selectedFlyers.remove(flyer);
        _tabModels = createTabModels();
      });
    } else {
      setState(() {
        _selectedFlyers.add(flyer);
        _tabModels = createTabModels();
      });
    }
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return TabLayout(
      tabModels: _tabModels,
      pageTitle:
          'Saved flyers ', //${TextGenerator.sectionStringer(context, _sectionsList[_currentIndex])}',
      tabController: _tabController,
      currentIndex: _currentTabIndex,
      selectionMode: widget.selectionMode,
      selectedItems: _selectedFlyers,
    );
  }
}
