import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:flutter/material.dart';

import 'section_label.dart';

class SectionPicker extends StatelessWidget {
  final String currentSection;
  final Function selectingASection;
  final bool sectionsListIsOpen;
  final Function openingTheList;

  SectionPicker({
    @required this.currentSection,
    @required this.selectingASection,
    @required this.sectionsListIsOpen,
    @required this.openingTheList,
  });

  @override
  Widget build(BuildContext context) {
    String properties = 'Properties';
    String designs = 'Designs';
    String products = 'Products';
    String projects = 'Projects';
    String crafts = 'Crafts';
    String equipment = 'Equipment';

    return sectionsListIsOpen == false
        ? SectionLabel(
            label: translate(context, currentSection),
            labelDescription: '',
            sectionsListIsOpen: sectionsListIsOpen,
            tappingSection: openingTheList,
          )
        : Column(
            children: [
              SectionLabel(
                label: translate(context, 'Properties'),
                sectionsListIsOpen: sectionsListIsOpen,
                tappingSection: () {
                  selectingASection(properties);
                },
                labelDescription:
                    translate(context, 'Properties_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: translate(context, 'Designs'),
                tappingSection: () {
                  selectingASection(designs);
                },
                labelDescription: translate(context, 'Designs_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: translate(context, 'Products'),
                tappingSection: () {
                  selectingASection(products);
                },
                labelDescription:
                    translate(context, 'Products_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: translate(context, 'Projects'),
                tappingSection: () {
                  selectingASection(projects);
                },
                labelDescription:
                    translate(context, 'Projects_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: translate(context, 'Crafts'),
                tappingSection: () {
                  selectingASection(crafts);
                },
                labelDescription: translate(context, 'Crafts_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: translate(context, 'Equipment'),
                tappingSection: () {
                  selectingASection(equipment);
                },
                labelDescription:
                    translate(context, 'Equipment_description'),
              ),
            ],
          );
  }
}
