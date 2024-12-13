import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

const supabaseUrl = 'https://rcuffkdcapbqkhynffta.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJjdWZma2RjYXBicWtoeW5mZnRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIzMDY3OTIsImV4cCI6MjA0Nzg4Mjc5Mn0.BCIzTLQ_6Dvni1O18zZzGxDzAPB6C7R9YcZ0duk30OU';

const preloader = Center(child: CircularProgressIndicator(color: Colors.orange,),);

const formSpacer = SizedBox(width: 16, height: 26,);

const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 20);

const formColor = Color.fromRGBO(230, 230, 240, 1);

const authRegColor = Color.fromRGBO(145, 113, 210, 1);

final appTheme = ThemeData.light().copyWith(
  primaryColor: authRegColor,
  appBarTheme: AppBarTheme(
    backgroundColor: formColor
  ),
  scaffoldBackgroundColor: formColor,
  hintColor: Colors.grey,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: authRegColor,
      foregroundColor: Colors.white,
      minimumSize: Size(double.infinity, 50)
    )
  )
);

extension ShowSnackBar on BuildContext{
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  /// Displays a red snackbar indicating error
  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

class FinanceTextField extends StatelessWidget{

  final TextEditingController controller;
  final String hintText;
  final double fontSize;

  const FinanceTextField({super.key, required this.controller, required this.hintText, required this.fontSize,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: authRegColor,
      style: TextStyle(
        fontSize: fontSize,
        color: authRegColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
          filled: false,
          fillColor: authRegColor,
      ),
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}








