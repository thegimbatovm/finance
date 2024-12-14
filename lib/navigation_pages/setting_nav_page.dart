import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';

class SettingNavPage extends StatefulWidget {
  const SettingNavPage({super.key});

  @override
  State<SettingNavPage> createState() => _SettingNavPageState();
}

class _SettingNavPageState extends State<SettingNavPage> {

  bool isOut = false;

  Future<void> _signOut() async {
    setState(() {
      isOut = true;
    });
    try {
      await supabase.auth.signOut();
      context.go('/Auth');
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: _.toString());
    }
    if (mounted) {
      setState(() {
        isOut = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Выйти'),
        onPressed: isOut ? null : _signOut,
      ),
    );
  }
}
