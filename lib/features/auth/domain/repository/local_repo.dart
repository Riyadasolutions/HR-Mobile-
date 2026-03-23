


abstract class LocalRepository {

  Future<bool> saveSecuredData(String token);
  Future<bool> clearSharedData();
  bool getIsLoggedIn();
  Future<String> getUserToken();

  bool getIsFirstTime();

  Future<bool> saveCurrency(String symbol);
  String getCurrency();
}
