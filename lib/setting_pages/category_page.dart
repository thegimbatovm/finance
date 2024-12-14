import 'package:finance/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  TextEditingController _newCategory = TextEditingController();

  void requestAgain() {
    setState(() {
      _future = Supabase.instance.client
          .from('category')
          .select();
    });
  }

  var _future = Supabase.instance.client
      .from('category')
      .select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Категории', style: TextStyle(color: appHomeTheme.primaryColor, fontWeight: FontWeight.bold) ,),),
      floatingActionButton: Padding(
        padding: formPadding,
        child: FloatingActionButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
              content: FinanceTextField(controller: _newCategory,hintText: 'Новая категория', fontSize: formSize, ),
              actions: [
                      TextButton(
                          onPressed: () async {
                            await supabase
                                .from('category')
                                .insert({'name': _newCategory.text});
                            context.pop();
                            WidgetsBinding.instance.addPostFrameCallback((_){
                              requestAgain();
                            });
                          },
                          child: Text(
                            'Добавить',
                            style: TextStyle(
                                fontSize: formSize + 2,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )),
          backgroundColor: appHomeTheme.primaryColor,
          foregroundColor: formColor,
          child: Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: formPadding,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            final categoryes = snapshot.data!;
            return ListView.builder(
              itemCount: categoryes.length,
              itemBuilder: ((context, index) {
                final category = categoryes[index];
                return Column(
                  children: [
                    ListTile(
                      trailing: IconButton(
                        onPressed: () async {
                          await supabase
                              .from('category')
                              .delete()
                              .eq('id', category['id']);
                          WidgetsBinding.instance.addPostFrameCallback((_){
                            requestAgain();
                          });
                        },
                        icon: Icon(Icons.delete, color: Colors.red.withOpacity(0.3),),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: appHomeTheme.primaryColor)),
                      title: Text(category['name'], style: TextStyle(fontSize: formSize),),
                    ),
                    formSpacer
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
