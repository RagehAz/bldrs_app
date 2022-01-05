import 'package:flutter/material.dart';

class TabModel {
  /// --------------------------------------------------------------------------
  const TabModel({
    @required this.tabButton,
    @required this.page,
  });
  /// --------------------------------------------------------------------------
  final Widget tabButton;
  final Widget page;
  /// --------------------------------------------------------------------------
  static List<Widget> getPageWidgetsFromTabModels(List<TabModel> tabModels) {
    final List<Widget> _widgets = <Widget>[];

    for (final TabModel tabModel in tabModels) {
      _widgets.add(tabModel.page);
    }

    return _widgets;
  }
// -----------------------------------------------------------------------------
  static List<Widget> getTabButtonsFromTabModels(List<TabModel> tabModels) {
    final List<Widget> _widgets = <Widget>[];

    for (final TabModel tabModel in tabModels) {
      _widgets.add(tabModel.tabButton);
    }

    return _widgets;
  }
// -----------------------------------------------------------------------------
}
