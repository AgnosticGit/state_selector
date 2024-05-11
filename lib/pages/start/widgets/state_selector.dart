import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:state_selector/core/assets/assets.gen.dart';
import 'package:state_selector/core/extensions/build_context_extension.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';
import 'package:state_selector/features/domain/redux/maps/maps_thunk.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';

class StateSelector extends StatefulWidget {
  const StateSelector({
    required this.stateController,
    required this.stateFocusNode,
    required this.stateSuggestionsController,
    super.key,
  });

  final TextEditingController stateController;
  final FocusNode stateFocusNode;
  final SuggestionsController<StateModel> stateSuggestionsController;

  @override
  State<StateSelector> createState() => _StateSelectorState();
}

class _StateSelectorState extends State<StateSelector> {
  @override
  void initState() {
    widget.stateFocusNode.addListener(_onStateFocusChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (_, store) {
        final countriesState = store.state.countriesState;

        return TypeAheadField(
          controller: widget.stateController,
          focusNode: widget.stateFocusNode,
          debounceDuration: Duration.zero,
          suggestionsController: widget.stateSuggestionsController,
          suggestionsCallback: stateSuggestionsCallback,
          builder: (context, _, __) {
            if (countriesState.loadingCountriesProccess.loading) {
              return Container();
            }

            return TextField(
              enabled: countriesState.selectedCountry != null,
              onChanged: (_) => setState(() {}),
              controller: widget.stateController,
              focusNode: widget.stateFocusNode,
              decoration: InputDecoration(
                suffixIcon: _buildSuffixIcon(),
                isDense: true,
                border: const OutlineInputBorder(),
                labelText: 'State',
              ),
            );
          },
          itemBuilder: (context, country) {
            return ListTile(
              title: Text(country.name),
            );
          },
          onSelected: (state) async {
            setState(() => widget.stateController.text = state.name);
            store.dispatch(StatesActionSelectState(state));
            
            final selectedCountry = store.state.countriesState.selectedCountry;
            await store.dispatch(MapsThunkLoadGeoData(country: selectedCountry!, state: state));
          },
        );
      },
    );
  }

  FutureOr<List<StateModel>?> stateSuggestionsCallback(String search) {
    final states = context.state.statesState.states;

    if (search.isEmpty) {
      return states;
    } else {
      return states.where((e) => e.name.toLowerCase().contains(search.toLowerCase())).toList();
    }
  }

  void _onStateFocusChanged() {
    final selectedState = context.state.statesState.selectedState;

    if (!widget.stateFocusNode.hasFocus) {
      if (selectedState == null) {
        setState(() => widget.stateController.text = '');
      } else if (selectedState.name != widget.stateController.text) {
        setState(() => widget.stateController.text = selectedState.name);
      }
    }
  }

  Widget? _buildSuffixIcon() {
    if (widget.stateController.text.isNotEmpty) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          context.dispatch(const StatesActionClearSelectedState());
          setState(() => widget.stateController.text = '');
        },
        icon: Assets.icons.cross.svg(),
      );
    }

    return null;
  }

  @override
  void dispose() {
    widget.stateFocusNode.removeListener(_onStateFocusChanged);
    widget.stateFocusNode.dispose();

    super.dispose();
  }
}
