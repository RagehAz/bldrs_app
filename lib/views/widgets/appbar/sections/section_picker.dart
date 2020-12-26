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
            label: getTranslated(context, currentSection),
            labelDescription: '',
            sectionsListIsOpen: sectionsListIsOpen,
            tappingSection: openingTheList,
          )
        : Column(
            children: [
              SectionLabel(
                label: getTranslated(context, 'Properties'),
                sectionsListIsOpen: sectionsListIsOpen,
                tappingSection: () {
                  selectingASection(properties);
                },
                labelDescription:
                    getTranslated(context, 'Properties_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: getTranslated(context, 'Designs'),
                tappingSection: () {
                  selectingASection(designs);
                },
                labelDescription: getTranslated(context, 'Designs_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: getTranslated(context, 'Products'),
                tappingSection: () {
                  selectingASection(products);
                },
                labelDescription:
                    getTranslated(context, 'Products_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: getTranslated(context, 'Projects'),
                tappingSection: () {
                  selectingASection(projects);
                },
                labelDescription:
                    getTranslated(context, 'Projects_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: getTranslated(context, 'Crafts'),
                tappingSection: () {
                  selectingASection(crafts);
                },
                labelDescription: getTranslated(context, 'Crafts_description'),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SectionLabel(
                sectionsListIsOpen: sectionsListIsOpen,
                label: getTranslated(context, 'Equipment'),
                tappingSection: () {
                  selectingASection(equipment);
                },
                labelDescription:
                    getTranslated(context, 'Equipment_description'),
              ),
            ],
          );
  }
}
