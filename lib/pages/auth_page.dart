import 'package:finance/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    if (_email.text.isEmpty || _password.text.isEmpty){
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signInWithPassword(
        email: _email.text,
        password: _password.text,
      );
      user = supabase.auth.currentUser;
      metadata = user?.userMetadata;
      context.go('/Home');
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: _.toString());
    }
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: formPadding,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                  child: Center(
                      child: Text(
                        'Войти',
                        style: TextStyle(
                            fontSize: formSize+12,
                            fontWeight: FontWeight.bold,
                          color: appTheme.primaryColor
                        ),
                      )
                  )
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: formPadding,
                  child: ListView(
                      children: [
                        FinanceTextField(controller: _email,hintText: 'Email', fontSize: formSize,),
                        formSpacer,
                        FinanceTextField(controller: _password,hintText: 'Пароль', fontSize: formSize,),
                        formSpacer,
                        ElevatedButton(
                            onPressed: _isLoading ? null : _signIn,
                            child: Text('Войти', style: TextStyle(fontSize: formSize+2),),
                        ),
                        formSpacer,
                        TextButton(onPressed: (){}, child: Text('Забыли пароль?', style: TextStyle(fontSize: formSize, color: Colors.black),)),
                        formSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Нет аккаунта?', style: TextStyle(fontSize: formSize, color: Colors.grey),),
                            TextButton(
                                onPressed: () => context.go('/Auth/Reg'),
                                child: Text('Регистрация', style: TextStyle(fontSize: formSize),)
                            )
                          ],
                        )
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
