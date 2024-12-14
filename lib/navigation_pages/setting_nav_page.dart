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
    return Column(
      children: [
        Expanded(
          flex: 9,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          color: appHomeTheme.primaryColor,
                          width: double.infinity,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            formSpacer,
                            CircleAvatar(
                              child: Icon(Icons.person, size: 35,),
                              maxRadius: 55,
                            ),
                            formSpacer,
                            Text('Имя пользователя', style: TextStyle(fontSize: 20, color: formColor),)
                          ],
                        ),
                      ]
                    )
                ),
                Expanded(
                  flex: 7,
                    child: Padding(
                      padding: formPadding,
                      child: ListView(
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: appHomeTheme.primaryColor
                              )
                            ),
                            title: Text('Личные данные', style: TextStyle(fontSize: 20),),
                          ),
                          formSpacer,
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: appHomeTheme.primaryColor
                                )
                            ),
                            title: Text('Категории', style: TextStyle(fontSize: 20),),
                          ),
                          formSpacer,
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: appHomeTheme.primaryColor
                                )
                            ),
                            title: Text('Настройки', style: TextStyle(fontSize: 20),),
                          ),
                        ],
                      ),
                    )
                )
              ],
            )
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: TextButton(
              child: Text('Выйти', style: TextStyle(color: Colors.red, fontSize: 20),),
              onPressed: isOut ? null : _signOut,
            ),
          ),
        ),
      ],
    );
  }
}
