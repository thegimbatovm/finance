import 'dart:collection';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finance/constants.dart';
import 'package:finance/supabase.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  TextEditingController _newCategory = TextEditingController();

  final List<Color> listColor = [Colors.red, Colors.blue, Colors.green, Colors.orange];
  Color? selectedValue;

  int? _toogleDebetKredetState = 0;

  void requestAgain() {
    setState(() {
      _future = supabase
          .from('category')
          .select().eq('userid', user!.id).eq('debet', _toogleDebetKredetState == 0 ? true:false);
    });
  }

  var _future = supabase
      .from('category')
      .select().eq('userid', user!.id).eq('debet', true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Категории', style: TextStyle(color: appHomeTheme.primaryColor, fontWeight: FontWeight.bold) ,),),
      floatingActionButton: Padding(
        padding: formPadding,
        child: FloatingActionButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => StatefulBuilder(
              builder: (context, StateSetter setState) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                contentPadding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                        children: [
                          FinanceTextField(
                            controller: _newCategory,
                            hintText: 'Новая категория',
                            fontSize: formSize,
                          ),
                          formSpacer,
                          DropdownButton2<Color>(
                            underline: Container(height: 1, color: Colors.black.withOpacity(0.7),),
                            barrierColor: Colors.grey.withOpacity(0.5),
                            hint: Text('Выберите цвет', style: TextStyle(color: Colors.grey, fontSize: formSize),),
                            isExpanded: true,
                            value: selectedValue,
                            items: listColor.map((Color item) => DropdownMenuItem<Color>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(color: item,),
                                )
                            ) ).toList(),
                            onChanged: (Color? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          )
                        ],
                      ),
                actions: [
                        TextButton(
                            onPressed: () async {
                              await supabase
                                  .from('category')
                                  .insert({
                                'name': _newCategory.text,
                                'userid': user!.id,
                                'hexColor': selectedValue?.value.toInt()
                                  });
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
                    );
              }
            )),
          backgroundColor: appHomeTheme.primaryColor,
          foregroundColor: formColor,
          child: Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: formPadding,
        child: Column(
          children: [
            buildToggleSwitch,
            formSpacer,
            Expanded(
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
                            contentPadding: EdgeInsets.only(left: 2,right: 10, top: 2, bottom: 2),
                            leading: Container(
                              width: 10,
                              decoration: BoxDecoration(
                                  color: Color(category['hexColor']),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7),
                                      bottomLeft: Radius.circular(7)
                                  )
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                deleteCategory(category['id']);
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
          ],
        ),
      ),
    );
  }

  ToggleSwitch get buildToggleSwitch {
    return ToggleSwitch(
            borderColor: [appHomeTheme.primaryColor],
            minWidth: double.infinity,
            minHeight: 80,
            cornerRadius: 20.0,
            activeBgColors: [
              [appHomeTheme.primaryColor],
              [appHomeTheme.primaryColor]
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: formColor,
            inactiveFgColor: Colors.black,
            initialLabelIndex:
            _toogleDebetKredetState,
            totalSwitches: 2,
            labels: ['Приход', 'Расход'],
            radiusStyle: true,
            onToggle: (index) {
              setState(() {
                _toogleDebetKredetState = index;
              });
            },
          );
  }
}
