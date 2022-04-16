import 'package:http/http.dart' as http;
import 'dart:convert';

String currentCurrency = 'AUD';
int currentRateBTC = 0;
int currentRateETH = 0;
int currentRateLTC = 0;
const String apiKey = '0180FE1F-3642-4F9B-84F8-06D99052A085';

Future<int> getRate(String value1, String value2) async {
  http.Response response = await http.get(Uri.parse(
      'https://rest.coinapi.io/v1/exchangerate/$value1/$value2?apikey=$apiKey'));
  if (response.statusCode == 200) {
    double currentR = jsonDecode(response.body)['rate'];
    return currentR.round();
  } else {
    print(response.statusCode);
    return 0;
  }
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {}
