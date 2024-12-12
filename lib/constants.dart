import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

const supabaseUrl = 'https://rcuffkdcapbqkhynffta.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJjdWZma2RjYXBicWtoeW5mZnRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIzMDY3OTIsImV4cCI6MjA0Nzg4Mjc5Mn0.BCIzTLQ_6Dvni1O18zZzGxDzAPB6C7R9YcZ0duk30OU';

const preloader = Center(child: CircularProgressIndicator(color: Colors.orange,),);

const formSpacer = SizedBox(width: 16, height: 16,);

const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 20);

final appTheme = ThemeData.light().copyWith(

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