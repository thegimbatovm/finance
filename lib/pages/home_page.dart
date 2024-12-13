import 'package:finance/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isOut = false;

  Future<void> _signOut() async {
    setState(() {
      _isOut = true;
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
        _isOut = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appHomeTheme,
      home: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: _isOut ? null: _signOut,
            child: Text('Выйти'),
          ),
        ),
      ),
    );
  }
}
