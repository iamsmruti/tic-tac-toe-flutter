// ignore_for_file: unused_element

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_v2/providers/auth_provider.dart';
import 'package:tic_tac_toe_v2/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;

  Country country = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));

    void sendPhoneNumber() {
      final ap = Provider.of<AuthProvider>(context, listen: false);
      String phoneNumber = phoneController.text.trim();
      ap.signInWithPhone(context, "+${country.phoneCode}$phoneNumber");
    }

    return Material(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 115.0, horizontal: 24.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/login.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              const Text(
                "Let's Start",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Add your number to verify your identity",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                  controller: phoneController,
                  onChanged: (value) {
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // for below version 2 use this
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Enter Phone Number",
                    hintText: "",
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                  bottomSheetHeight: 500,
                                  borderRadius: BorderRadius.circular(10)),
                              onSelect: (value) {
                                setState(() {
                                  country = value;
                                });
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            "${country.flagEmoji} +${country.phoneCode}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: phoneController.text.length > 9
                        // ignore: avoid_unnecessary_containers
                        ? Container(
                            child: const Icon(Icons.done),
                          )
                        : null,
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (phoneController.text.length != 10) {
                    showSnackBar(context, "Fill All the Fields Properly");
                    return;
                  }
                  setState(() {
                    _isLoading = true;
                  });

                  sendPhoneNumber();
                },
                child: const Text("Get OTP"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
