import 'package:finance/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _repeatPassword = TextEditingController();

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
                  flex: 2,
                  child: Center(
                      child: Text(
                        'Регистрация',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: appTheme.primaryColor
                        ),
                      )
                  )
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: formPadding,
                  child: ListView(
                      children: [
                        FinanceTextField(controller: _username,hintText: 'Имя пользователя', fontSize: 20,),
                        formSpacer,
                        FinanceTextField(controller: _email,hintText: 'Email', fontSize: 20,),
                        formSpacer,
                        FinanceTextField(controller: _password,hintText: 'Пароль', fontSize: 20,),
                        formSpacer,
                        FinanceTextField(controller: _repeatPassword, hintText: 'Повторите пароль', fontSize: 20),
                        formSpacer,
                        ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          child: Text('Зарегистрироваться', style: TextStyle(fontSize: 22),),
                        ),
                        formSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Уже есть аккаунт', style: TextStyle(fontSize: 20, color: Colors.grey),),
                            TextButton(
                                onPressed: () => context.go('/Auth'),
                                child: Text('Войти', style: TextStyle(fontSize: 20),)
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