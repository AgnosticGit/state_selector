class APIUrlsV1 {
  static const api = 'https://api.stagingcupid.com/api/v1/';

  static const countries = '${api}countries/';
  static String states(int countryId) => '$countries$countryId/states';
}
