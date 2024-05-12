import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:state_selector/core/assets/assets.gen.dart';
import 'package:state_selector/core/l10n/l10n.dart';
import 'package:state_selector/core/extensions/build_context_extension.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/maps/maps_thunk.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';

class StateSelector extends StatefulWidget {
  const StateSelector({
    required this.stateController,
    required this.stateFocusNode,
    required this.stateSuggestionsController,
    required this.mapController,
    super.key,
  });

  final TextEditingController stateController;
  final FocusNode stateFocusNode;
  final SuggestionsController<StateModel> stateSuggestionsController;

  final MapController mapController;

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
        final statesState = store.state.statesState;
        final mapsState = store.state.mapsState;

        return TypeAheadField(
          controller: widget.stateController,
          focusNode: widget.stateFocusNode,
          debounceDuration: Duration.zero,
          suggestionsController: widget.stateSuggestionsController,
          suggestionsCallback: stateSuggestionsCallback,
          builder: (context, _, __) {
            final isLoading = statesState.loadingStatesProccess.loading;

            return TextField(
              enabled: countriesState.selectedCountry != null && !isLoading,
              onChanged: (_) => setState(() {}),
              controller: widget.stateController,
              focusNode: widget.stateFocusNode,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: _buildSuffixIcon(isLoading),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                isDense: true,
                border: const OutlineInputBorder(),
                labelText: L10n.state,
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
            FocusManager.instance.primaryFocus?.unfocus();
            store.dispatch(StatesActionSelectState(state));

            final selectedCountry = store.state.countriesState.selectedCountry;
            await store.dispatch(MapsThunkLoadGeoData(country: selectedCountry!, state: state));

            if (mapsState.stateGeoData != null) {
              widget.mapController.move(mapsState.stateGeoData!.center, 4);
            }
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

  Widget? _buildSuffixIcon(bool isLoading) {
    if (isLoading) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
        width: 10,
        height: 10,
        child: const LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          colors: [Colors.blue],
        ),
      );
    }

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
