import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatelessWidget {
  final List<FilterModel> filtersModels;
  final Function onTap;
  final FilterModel selectedFilter;

  FiltersPage({
    Key key,
    @required this.filtersModels,
    @required this.onTap,
    @required this.selectedFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 20,
      // height: 20,
      // color: _colors[pageIndex],
      child: ListView.builder(
          itemCount: filtersModels.length,
          padding: const EdgeInsets.all(Ratioz.appBarMargin),
          itemBuilder: (context, keyIndex){

            FilterModel _filterModel = filtersModels[keyIndex];

            Color _color = selectedFilter?.filterID == _filterModel.filterID ? Colorz.Yellow : Colorz.Nothing;

            return
              DreamBox(
                height: 70,
                // width: 120,
                color: _color,
                margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
                verse: _filterModel.filterID,
                boxFunction: () => onTap(_filterModel),
              );
          }
      ),
    );
  }
}
