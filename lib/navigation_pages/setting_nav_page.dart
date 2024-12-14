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
                            Text(username, style: TextStyle(fontSize: formSize+2, color: formColor),)
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
                          InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(Icons.co_present, color: appHomeTheme.primaryColor,),
                              trailing: Icon(Icons.navigate_next, color: appHomeTheme.primaryColor,),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: appHomeTheme.primaryColor
                                )
                              ),
                              title: Text('Личные данные', style: TextStyle(fontSize: formSize, ),),
                            ),
                          ),
                          formSpacer,
                          InkWell(
                            onTap: () => context.go('/Auth/Home/Category'),
                            child: ListTile(
                              leading: Icon(Icons.category, color: appHomeTheme.primaryColor,),
                              trailing: Icon(Icons.navigate_next, color: appHomeTheme.primaryColor,),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: appHomeTheme.primaryColor
                                  )
                              ),
                              title: Text('Категории', style: TextStyle(fontSize: formSize, ),),
                            ),
                          ),
                          formSpacer,
                          ListTile(
                            leading: Icon(Icons.tune, color: appHomeTheme.primaryColor,),
                            trailing: Icon(Icons.navigate_next, color: appHomeTheme.primaryColor,),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: appHomeTheme.primaryColor
                                )
                            ),
                            title: Text('Настройки', style: TextStyle(fontSize: formSize),),
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
              child: Text('Выйти', style: TextStyle(color: Colors.grey.withOpacity(0.7), fontSize: formSize),),
              onPressed: isOut ? null : _signOut,
            ),
          ),
        ),
      ],
    );
  }
}
