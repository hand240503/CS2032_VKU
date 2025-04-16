import 'package:flutter/material.dart';

// Các màu sắc chính
const kPrimaryColor = Colors.white;
const kSecondaryColor = Colors.grey;

// Các kiểu chữ
const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

// Cấu hình giao diện TextField
const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: kPrimaryColor, // Sử dụng màu chính ở đây
  icon: Icon(
    Icons.location_city,
    color: kPrimaryColor, // Sử dụng màu chính cho biểu tượng
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: kSecondaryColor, // Màu xám cho văn bản gợi ý
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
