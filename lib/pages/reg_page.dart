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

  final bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _signUp() async {
    // final isValid = _formKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    final email = _email.text;
    final password = _password.text;
    final username = _username.text;
    try {
      await supabase.auth.signUp(
          email: email, password: password, data: {'username': username});
      context.go('/Home');
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          key: _formKey,
          padding: formPadding,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Text(
                        'Регистрация',
                        style: TextStyle(
                            fontSize: formSize+12,
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
                        FinanceTextField(controller: _username,hintText: 'Имя пользователя', fontSize: formSize,),
                        formSpacer,
                        FinanceTextField(controller: _email,hintText: 'Email', fontSize: formSize,),
                        formSpacer,
                        FinanceTextField(controller: _password,hintText: 'Пароль', fontSize: formSize,),
                        formSpacer,
                        FinanceTextField(controller: _repeatPassword, hintText: 'Повторите пароль', fontSize: formSize),
                        formSpacer,
                        ElevatedButton(
                          onPressed: _isLoading ? null : _signUp,
                          child: Text('Зарегистрироваться', style: TextStyle(fontSize: formSize + 2),),
                        ),
                        formSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Уже есть аккаунт', style: TextStyle(fontSize: formSize, color: Colors.grey),),
                            TextButton(
                                onPressed: () => context.go('/Auth'),
                                child: Text('Войти', style: TextStyle(fontSize: formSize),)
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