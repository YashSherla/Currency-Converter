import 'dart:developer';

import 'package:currency_converter/services/api.dart';
import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final Map rate;
  final Map currencies;
  const AnyToAny({super.key, required this.rate, required this.currencies});

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  final amountController = TextEditingController();
  String dropdownValue1 = 'AUD';
  String dropdownValue2 = 'AUD';
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
              'Any to Any Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(hintText: 'Enter a amount'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                      value: dropdownValue1,
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
                          dropdownValue1 = value.toString();
                        });
                      }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DropdownButton(
                      value: dropdownValue2,
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
                          dropdownValue2 = value.toString();
                          log(dropdownValue2);
                        });
                      }),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      answer =
                          "${amountController.text} $dropdownValue1 = ${anyconvertany(
                        exchange: widget.rate,
                        amount: amountController.text,
                        currencyuser: dropdownValue1,
                        currencytoconvert: dropdownValue2,
                      )} $dropdownValue2";
                    });
                  },
                  child: const Text("Convert")),
            ),
            Text(answer),
          ],
        ),
      ),
    );
  }
}
