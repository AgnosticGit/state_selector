class APIUrlsV1 {
  APIUrlsV1._();

  static const api = 'https://api.stagingcupid.com/api/v1/';

  static const countries = '${api}countries/';
  static String states(int countryId) => '$countries$countryId/states';
}
