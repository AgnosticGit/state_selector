class Links {
  const Links._();

  static const mapsTemplateUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static String countryGeoDataUrl(String country) =>
      'https://nominatim.openstreetmap.org/search?country=$country&polygon_geojson=1&format=json';
  static String stateGeoDataUrl(String country, String state) =>
      'https://nominatim.openstreetmap.org/search?country=$country&state=$state&polygon_geojson=1&format=json';
}
