import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/location_routes.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';
import 'package:tourists/module_search/bloc/search_bloc/search_bloc.dart';

class AddLocationDialog extends StatefulWidget {
  final SearchBloc predictionProvider;

  AddLocationDialog(this.predictionProvider);

  @override
  State<StatefulWidget> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  String currentLocation;
  bool showPredictions = true;
  List <LocationListItem> predictions;

  final _searchController = TextEditingController();

  @override
  void initState() {
    widget.predictionProvider.predictionStream.listen((event) {
      predictions = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: S.of(context).searchQuery,
                labelText: S.of(context).searchQuery,
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  showPredictions = true;
                  widget.predictionProvider.getPredictions(query);
                }
              },
            ),
          ),
          Expanded(
            child: showPredictions
                ? SingleChildScrollView(child: buildPredictionList(predictions))
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget buildPredictionList(List<LocationListItem> predictions) {
    var tiles = <Widget>[];

    predictions.forEach((val) {
      tiles.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            LocationRoutes.addLocation,
            arguments: val.id,
          );
        },
        child: ListTile(
          leading: Container(
            height: 75,
            child: Image.network(val.path[0].path),
          ),
          title: Text('${val.name}'),
          subtitle: Text('${val.description}'),
          trailing: SmoothStarRating(
            isReadOnly: true,
            color: Colors.black,
            borderColor: Colors.black,
            starCount: 5,
            rating: double.parse(val.ratingAverage),
            size: 12,
          ),
        ),
      ));
    });

    return Flex(
      direction: Axis.vertical,
      children: tiles,
    );
  }

}
