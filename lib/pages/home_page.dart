import 'dart:developer';

import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/services/api.dart';
import 'package:currency_converter/wigets/anytoany.dart';
import 'package:currency_converter/wigets/usdtoany.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map> fetchcurrency;
  late Future<Rates> fectrates;
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchcurrency = ApiService().fetchcurrency();
      fectrates = ApiService().fetchrates();
      log(" This is the home Api data currency: $fetchcurrency");
      log(" This is the home Api data rates: $fectrates");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/currency.jpeg"),
          ),
        ),
        child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: FutureBuilder<Rates>(
                  future: fectrates,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(
                      child: FutureBuilder(
                        future: fetchcurrency,
                        builder: (context, currsnapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                UsdToAny(
                                  rate: snapshot.data!.rates,
                                  currencies: currsnapshot.data ?? {},
                                ),
                                const SizedBox(height: 10),
                                AnyToAny(
                                  rate: snapshot.data!.rates,
                                  currencies: currsnapshot.data ?? {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ))),
      ),
    );
  }
}
