import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/location_routes.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';
import 'package:tourists/module_search/bloc/search_bloc/search_bloc.dart';

@provide
class SearchScreen extends StatefulWidget {
  final SearchBloc bloc;

  SearchScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String currentLocation;
  bool showPredictions = true;
  List<LocationListItem> predictions = [];

  final _searchController = TextEditingController();

  @override
  void initState() {
    widget.bloc.predictionStream.listen((event) {
      predictions = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: S.of(context).search,
            labelText: S.of(context).search,
          ),
          onChanged: (query) {
            if (query.isNotEmpty) {
              showPredictions = true;
              widget.bloc.getPredictions(query);
            }
          },
        ),
      ),
      body: Column(
        children: [
          buildPredictionList(predictions),
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
            LocationRoutes.locationDetails,
            arguments: val.id,
          );
        },
        child: Card(
          child: ListTile(
            leading: Container(
              height: 75,
              width: 75,
              child: Image.network(val.path[0].path,fit: BoxFit.cover,),
            ),
            title: Text('${val.name}'),
            subtitle: Text(
              '${val.description}',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: SmoothStarRating(
              isReadOnly: true,
              color: Colors.black,
              borderColor: Colors.black,
              starCount: 5,
              rating: double.parse(val.ratingAverage),
              size: 12,
            ),
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
