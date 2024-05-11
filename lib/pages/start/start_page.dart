import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:state_selector/core/extensions/build_context_extension.dart';
import 'package:state_selector/core/ui_kit/safe_scaffold.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/countries/countries_thunks.dart';
import 'package:state_selector/pages/start/widgets/country_selector.dart';
import 'package:state_selector/pages/start/widgets/maps.dart';
import 'package:state_selector/pages/start/widgets/maps_loading_indicator.dart';
import 'package:state_selector/pages/start/widgets/state_selector.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _countryController = TextEditingController();
  final _countryFocusNode = FocusNode();

  final _stateController = TextEditingController();
  final _stateFocusNode = FocusNode();
  final _stateSuggestionsController = SuggestionsController<StateModel>();

  final mapController = MapController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.dispatch(CountriesThunkLoadCountries());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Stack(
        children: [
          Maps(mapController: mapController),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
                child: CountrySelector(
                  countryController: _countryController,
                  countryFocusNode: _countryFocusNode,
                  stateFocusNode: _stateFocusNode,
                  stateSuggestionsController: _stateSuggestionsController,
                  mapController: mapController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: StateSelector(
                  stateController: _stateController,
                  stateFocusNode: _stateFocusNode,
                  stateSuggestionsController: _stateSuggestionsController,
                  mapController: mapController,
                ),
              ),
            ],
          ),
          const MapsLoadingIndicator(),
        ],
      ),
    );
  }
}
