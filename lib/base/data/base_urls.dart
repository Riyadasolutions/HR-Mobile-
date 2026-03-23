import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseAppURLs {
  // static const String kBaseDomainURL = "https://care-connect.agents-pal.com/";
  static final String kBaseDomainURL = dotenv.env['API_URL']??'';
  // static const String kBaseDomainURL = "http://hdd.careconnectksa.com/";
  static final String kBaseAPIURL = "${kBaseDomainURL}api/v1/";

}



final apiUrl = dotenv.env['API_URL'];
final apiKey = dotenv.env['API_KEY'];