import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:latlong2/latlong.dart';
import 'package:state_selector/core/assets/assets.gen.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/core/extensions/build_context_extension.dart';
import 'package:state_selector/core/ui_kit/safe_scaffold.dart';
import 'package:state_selector/features/data/maps_repository.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';
import 'package:state_selector/features/domain/redux/countries/countries_state.dart';
import 'package:state_selector/features/domain/redux/countries/countries_thunks.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';
import 'package:state_selector/features/domain/redux/states/states_thunks.dart';
import 'package:state_selector/main.dart';
import 'package:state_selector/pages/start/widgets/country_selector.dart';
import 'package:state_selector/pages/start/widgets/maps.dart';
import 'package:state_selector/pages/start/widgets/state_selector.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();

  final _countryFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();

  final _stateSuggestionsController = SuggestionsController<StateModel>();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
            child: CountrySelector(
              countryController: _countryController,
              countryFocusNode: _countryFocusNode,
              stateFocusNode: _stateFocusNode,
              stateSuggestionsController: _stateSuggestionsController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: StateSelector(
              stateController: _stateController,
              stateFocusNode: _stateFocusNode,
              stateSuggestionsController: _stateSuggestionsController,
            ),
          ),
          const Maps(),
        ],
      ),
    );
  }
}
