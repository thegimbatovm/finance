import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../constants.dart';

class AddNavPage extends StatefulWidget {
  const AddNavPage({super.key});

  @override
  State<AddNavPage> createState() => _AddNavPageState();
}

class _AddNavPageState extends State<AddNavPage> {

  var _toogleDebetKredetState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _toogleDebetKredetState = 0;
  }

  void requestAgain() {
    setState(() {
      _future = supabase
          .from('event')
          .select().eq('userid', user!.id);
    });
  }

  var _future = supabase
      .from('event')
      .select().eq('userid', user!.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: formPadding,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final events = snapshot.data!;
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: ((context, index) {
                    final event = events[index];
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(
                              left: 20, right: 20, top: 2, bottom: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side:
                                  BorderSide(color: appHomeTheme.primaryColor)),
                          title: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Жена',
                                            style:
                                                TextStyle(fontSize: formSize)),
                                        Icon(
                                          Icons.remove,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    formSpacer,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Расход",
                                          style: TextStyle(
                                              fontSize: formSize + 5,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        Text('500',
                                            style: TextStyle(
                                                fontSize: formSize + 5,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black))
                                      ],
                                    ),
                                    formSpacer,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          now.day.toString() +
                                              "." +
                                              now.month.toString() +
                                              '.' +
                                              now.year.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: formSize),
                                        ),
                                        Text(
                                          now.hour.toString() +
                                              ':' +
                                              now.minute.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: formSize),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        formSpacer
                      ],
                    );
                  }),
                );
              },
            ),
            TextButton(
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      Size size = MediaQuery.of(context).size;
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Container(
                          height: size.height,
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 150, top: 100),
                            child: Container(
                              decoration: BoxDecoration(
                                color: formColor,
                                border: Border.all(
                                  color: appHomeTheme.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: size.height * 0.6,
                              width: size.width * 0.8,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: formPadding,
                                    child: ToggleSwitch(
                                      minWidth: double.infinity,
                                      cornerRadius: 20.0,
                                      activeBgColors: [
                                        [Colors.green[800]!],
                                        [Colors.red[800]!]
                                      ],
                                      activeFgColor: Colors.white,
                                      inactiveBgColor: Colors.grey,
                                      inactiveFgColor: Colors.white,
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
                                    ),
                                  ),
                                  Text("$_toogleDebetKredetState"),
                                  Builder(builder: (context) {
                                    if (_toogleDebetKredetState == 0) {
                                      return Text('f');
                                    }
                                    return Card(
                                      child: DropdownButton<String>(
                                        items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (_) {},
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
                child: Text('Добавить'))
          ]),
        ));
  }
}
