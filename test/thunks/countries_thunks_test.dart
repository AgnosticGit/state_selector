import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:state_selector/features/domain/redux/countries/countries_thunks.dart';
import 'package:test/test.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_selector/features/data/countries_repository.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';

class MockCountriesRepository extends Mock implements CountriesRepository {}

@GenerateMocks([CountriesRepository])
void main() {
  group('CountriesThunkLoadCountries', () {
    test('dispatches loading success action when countries are fetched successfully', () async {
      final store = Store<AppState>(
        (state, action) => state,
        initialState: AppState.initial(),
        middleware: [thunkMiddleware],
      );
      final expectedCountries = [
        const CountryModel(id: 1, name: 'Country1'),
        const CountryModel(id: 2, name: 'Country2')
      ];
      when(MockCountriesRepository().getCountries())
          .thenAnswer((_) async => Right(expectedCountries));

      await CountriesThunkLoadCountries().call(store);
      expect(store.state.countriesState.loadingCountriesProccess.loading, true);
      expect(store.state.countriesState.loadingCountriesProccess.failure, null);
      expect(store.state.countriesState.countries, expectedCountries);
    });

    test('dispatches loading failure action when countries fetching fails', () async {
      // Arrange
      final store = Store<AppState>(
        (state, action) => state, // Replace with your actual reducer
        initialState: AppState.initial(),
        middleware: [thunkMiddleware],
      );
      const failure = Failure(1, 'Failed to fetch countries');
      when(MockCountriesRepository().getCountries()).thenAnswer((_) async => const Left(failure));

      // Act
      await CountriesThunkLoadCountries().call(store);

      // Assert
      expect(store.state.countriesState.loadingCountriesProccess.loading, false);
      expect(store.state.countriesState.loadingCountriesProccess.failure, failure);
    });
  });
}
