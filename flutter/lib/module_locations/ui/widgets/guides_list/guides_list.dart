import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

import '../../../../module_forms/forms_routes.dart';
import '../../../../module_guide/model/guide_list_item/guide_list_item.dart';
import '../../../../module_guide/nav_arguments/request_guide/request_guide_navigation.dart';
import '../../../../module_guide/ui/widget/guide_list_item/guide_list_item.dart';

class GuidesListWidget extends StatefulWidget {
  final List<GuideListItemModel> guides;
  final String cityId;
  final int pageSize;

  GuidesListWidget(
    this.guides,
    this.cityId, [
    this.pageSize = 10,
  ]);

  @override
  State<StatefulWidget> createState() => _GuidesListWidgetState(guides);
}

class _GuidesListWidgetState extends State<GuidesListWidget> {
  List<GuideListItemModel> displayedGuides = [];

  _GuidesListWidgetState(List<GuideListItemModel> guides) {
    displayedGuides = (guides.length > 3)
        ? guides.sublist(0, 3)
        : guides;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.guides == null) return Container();

    return Column(
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: displayedGuides.length,
            itemBuilder: (BuildContext context, int index) {
              // Construct the List into CSV text
              String citiesInText = '';
              displayedGuides[index].city.forEach((cityName) {
                citiesInText = '${citiesInText ?? ''} ${cityName ?? ''}';
              });

              // Construct the List into CSV text
              String languagesInText = '';
              displayedGuides[index].language.forEach((language) {
                languagesInText = languagesInText + language + ' ';
              });
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    FormsRoutes.requestGuideForm,
                    arguments: RequestGuideNavigationArguments(
                      guideId: displayedGuides[index].user,
                      cityId: widget.cityId,
                    ),
                  );
                },
                child: GuideListItemWidget(
                  guideCity: citiesInText,
                  guideName: displayedGuides[index].name,
                  guideLanguage: languagesInText,
                  availability: displayedGuides[index].status,
                  rate: displayedGuides[index].rating,
                  guideImage: displayedGuides[index].name,
                  isLogged: false,
                ),
              );
            }),
        if (widget.guides.length > displayedGuides.length)
          RaisedButton(
              onPressed: () {
                setState(() {
                  int startIndex = displayedGuides.length - 1;
                  displayedGuides.addAll(
                      (widget.guides.length - displayedGuides.length > 3)
                          ? widget.guides.sublist(startIndex, startIndex + 3)
                          : widget.guides.sublist(startIndex));
                });
              },
              child: Text(S.of(context).show_more))
      ],
    );
  }
}
