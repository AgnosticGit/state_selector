import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:state_selector/core/assets/assets.gen.dart';
import 'package:state_selector/core/l10n/l10n.dart';
import 'package:state_selector/core/extensions/build_context_extension.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';
import 'package:state_selector/features/domain/redux/maps/maps_thunk.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';

import '../../../features/domain/redux/states/states_thunks.dart';

class CountrySelector extends StatefulWidget {
  const CountrySelector({
    required this.countryController,
    required this.countryFocusNode,
    required this.stateFocusNode,
    required this.stateSuggestionsController,
    required this.mapController,
    super.key,
  });

  final TextEditingController countryController;
  final FocusNode countryFocusNode;

  final FocusNode stateFocusNode;
  final SuggestionsController<StateModel> stateSuggestionsController;

  final MapController mapController;

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  @override
  void initState() {
    widget.countryFocusNode.addListener(_onCountryFocusChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (_, store) {
      final countriesState = store.state.countriesState;
      final mapsState = store.state.mapsState;

      return TypeAheadField(
        controller: widget.countryController,
        focusNode: widget.countryFocusNode,
        debounceDuration: Duration.zero,
        suggestionsCallback: _countrySuggestionsCallback,
        builder: (context, _, __) {
          final isLoading = countriesState.loadingCountriesProccess.loading;

          return TextField(
            onChanged: (_) => setState(() {}),
            controller: widget.countryController,
            focusNode: widget.countryFocusNode,
            enabled: !isLoading,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: _buildSuffixIcon(isLoading),
              isDense: true,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              labelText: L10n.country,
            ),
          );
        },
        itemBuilder: (context, country) {
          return ListTile(
            title: Text(country.name),
          );
        },
        onSelected: (country) async {
          widget.stateSuggestionsController.refresh();
          setState(() => widget.countryController.text = country.name);
          FocusManager.instance.primaryFocus?.unfocus();

          await store.dispatch(StatesThunkLoadStates(country));
          await store.dispatch(MapsThunkLoadGeoData(country: country));

          if (mapsState.countryGeoData != null) {
            widget.mapController.move(mapsState.countryGeoData!.center, 3);
          }
        },
      );
    });
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

    if (widget.countryController.text.isNotEmpty) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          context.dispatch(const StatesActionClearSelectedState());
          context.dispatch(const CountriesActionClearSelectedCountry());
          setState(() => widget.countryController.text = '');
        },
        icon: Assets.icons.cross.svg(),
      );
    }

    return null;
  }

  FutureOr<List<CountryModel>?> _countrySuggestionsCallback(String search) {
    final countries = context.state.countriesState.countries;

    if (search.isEmpty) {
      return countries;
    } else {
      return countries.where((e) => e.name.toLowerCase().contains(search.toLowerCase())).toList();
    }
  }

  void _onCountryFocusChanged() {
    final selectedCountry = context.state.countriesState.selectedCountry;

    if (!widget.countryFocusNode.hasFocus) {
      if (selectedCountry == null) {
        setState(() => widget.countryController.text = '');
        context.dispatch(const StatesActionClearStates());
      } else if (selectedCountry.name != widget.countryController.text) {
        setState(() => widget.countryController.text = selectedCountry.name);
      }
    }
  }

  @override
  void dispose() {
    widget.countryFocusNode.removeListener(_onCountryFocusChanged);
    widget.countryFocusNode.dispose();

    super.dispose();
  }
}
