import 'dart:developer';

import 'package:currency_converter/services/api.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final Map rate;
  final Map currencies;
  const UsdToAny({super.key, required this.rate, required this.currencies});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  final usdController = TextEditingController();
  String dropdownValue = 'AUD';
  String answer = 'Converted Amount';
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'USD to Any Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: usdController,
              decoration: const InputDecoration(hintText: 'Enter USD'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      items: widget.currencies.keys.toSet().map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value.toString();
                        });
                      }),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        answer =
                            '${usdController.text} USD = ${convertusd(exchange: widget.rate, amount: usdController.text, currency: dropdownValue)} $dropdownValue';
                      });
                      log(widget.rate.toString());
                    },
                    child: const Text("Convert"))
              ],
            ),
            Text(answer),
          ],
        ),
      ),
    );
  }
}
