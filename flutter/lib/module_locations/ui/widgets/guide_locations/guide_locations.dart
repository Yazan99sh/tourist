import 'package:flutter/material.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';
import 'package:tourists/module_locations/ui/widgets/guide_location_card/guide_location_card.dart';

class GuideLocations extends StatelessWidget {
  final List<LocationListItem> locations;
  final List<String> selectedLocations;
  final Function(String) onLocationSelected;

  GuideLocations({
    this.locations,
    this.selectedLocations,
    this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: locations
            .map((e) => GestureDetector(
                onTap: () {
                  onLocationSelected(e.id);
                },
                child: GuideLocationCard(e, selectedLocations.contains('${e.id}'))))
            .toList(),
      ),
    );
  }
}
