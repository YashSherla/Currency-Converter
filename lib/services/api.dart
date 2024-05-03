import 'dart:developer';

import 'package:currency_converter/models/currencies_model.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/utils/app_id.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Rates> fetchrates() async {
    String url = "https://openexchangerates.org/api/latest.json?app_id=$appId";
    var response = await http.get(Uri.parse(url));
    final data = ratesFromJson(response.body);
    log(" This is the  Api data rates: $data");
    return data;
  }

  Future<Map> fetchcurrency() async {
    String url =
        "https://openexchangerates.org/api/currencies.json?app_id=$appId";
    var response = await http.get(Uri.parse(url));
    final data = currenciesFromJson(response.body);
    log(" This is the  Api data currency: $data");
    return data;
  }
}

String convertusd(
    {required Map exchange, required String amount, required String currency}) {
  String output =
      ((exchange[currency] * double.parse(amount))).toStringAsFixed(2);
  log(" This is the convertusd output: $output");
  return output;
}

String anyconvertany(
    {required Map exchange,
    required String amount,
    required String currencyuser,
    required String currencytoconvert}) {
  String output = (double.parse(amount) /
          exchange[currencyuser] *
          exchange[currencytoconvert])
      .toStringAsFixed(2);
  log(" This is the convertusd output: $output");
  return output;
}
