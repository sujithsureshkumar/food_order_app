// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order_app/views/screens/verification_code_screen.dart';

import '../../constants/countries.dart';
import '../../models/country.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final _phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Country? _selectedCountry;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_new)),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Image(
                  width: 200,
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/flutter_logo.png'),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    "What's your phone number?",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                      child: DropdownSearch<Country>(
                        items: countries
                            .map(
                              (item) => (item),
                            )
                            .toList(),
                        selectedItem: _selectedCountry,
                        compareFn: (i1, i2) => i1 == i2,
                        onChanged: (value) {
                          setState(() {
                            _selectedCountry = value!;
                          });
                        },
                        validator: (item) {
                          if (item == null) {
                            return "Select a country";
                          } else {
                            return null;
                          }
                        },
                        dropdownBuilder: customdropdownPhoneCodeBuilder,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                dropdownSearchInputDecoration()),
                        popupProps: PopupProps.dialog(
                          fit: FlexFit.loose,
                          itemBuilder: popupPropsItemBuilder,
                          showSelectedItems: true,
                          showSearchBox: true,
                          dialogProps: DialogProps(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            elevation: 40,
                          ),
                          searchFieldProps: TextFieldProps(
                              //controller: _userEditTextController,
                              decoration:
                                  searchFieldPropsInputDecoration(context)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: TextFormField(
                        controller: _phoneNumber,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the area or postcode.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          //prefixIcon: Icon(Icons.search),
                          //hintText: "Where would you like to park?",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xFFf4f4f4),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xFFf4f4f4),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xFFf4f4f4),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child:
                      Text("We will send of you a text with verification code"),
                ),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  backgroundColor: Color(0xFF0c3cac),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerificationCodeScreen(
                                  phoneNumber:
                                      "+${_selectedCountry!.dialCode} ${_phoneNumber.text}",
                                )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'please fill the phone number & country code')),
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customdropdownPhoneCodeBuilder(
  BuildContext context,
  Country? item,
) {
  return Container(
      child: (item == null)
          ? const Text("+00",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Color.fromARGB(235, 158, 158, 158)))
          : Text(
              item.dialCode,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ));
}

InputDecoration dropdownSearchInputDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    //prefixIcon: Icon(Icons.search),
    hintText: "Where would you like to park?",
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: Color(0xFFf4f4f4),
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: Color(0xFFf4f4f4),
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: Color(0xFFf4f4f4),
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

Widget popupPropsItemBuilder(
    BuildContext context, Country? item, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      "${item!.dialCode} ${item.name}",
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyText1!.color),
    ),
  );
}

InputDecoration searchFieldPropsInputDecoration(BuildContext context) {
  return InputDecoration(
    filled: false,
    labelText: "search",
    /*labelStyle:
                                  TextStyle(color: ColorConstants.darkThemeTextColor),*/
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 4.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      // width: 0.0 produces a thin "hairline" border
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    ),
  );
}
