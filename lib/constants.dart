import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

const preloader = Center(child: CircularProgressIndicator(color: Colors.orange,),);

const formSpacer = SizedBox(width: 16, height: 16,);

const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 20);

final appTheme = ThemeData.light().copyWith(

);