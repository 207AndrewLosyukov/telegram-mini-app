import 'package:flutter/material.dart';
import 'package:hibye_mini_app/meet_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.circle});
  final Future<CircleModel> circle;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D3557),
        title: const Text("Стипендия «Молодой предприниматель» ФКН"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: Colors.white,
                    ),
                    child: const Center(
                        child: Text(
                      "Участники",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: FutureBuilder(
                      future: widget.circle,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data.image == null
                              ? Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color(snapshot.data.color),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.data.text,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    snapshot.data.image!,
                                    width: 40.0,
                                    height: 40.0,
                                  ),
                                );
                        } else {
                          return Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xFFFFF3FF),
                            ),
                            child: const Center(
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFF2F2F2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      // отступ на последнем = 0
                      padding: EdgeInsets.only(bottom: index < 10 ? 5.0 : 0.0),
                      child: MeetItem(
                          model: MeetItemModel(
                              3, 5, "Встреча", "5 ноября", "18:00", [
                        CircleModel(null, "⋯", 0xFFFFF3FF),
                        CircleModel(null, "⋯", 0xFFFFF3FF),
                        CircleModel(null, "⋯", 0xFFFFF3FF),
                        CircleModel(null, "⋯", 0xFFFFF3FF),
                        CircleModel(null, "⋯", 0xFFFFF3FF),
                        CircleModel(null, "⋯", 0xFFFFF3FF),
                      ])),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: Row(children: [
                InkWell(
                  child: Container(
                      height: 50,
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFF1D3557)),
                      child: const Center(
                        child: Text(
                          "HiBye",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    child: Container(
                        height: 50,
                        width: (MediaQuery.of(context).size.width - 60) / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xFF1D3557)),
                        child: const Center(
                          child: Text(
                            "Создать",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ]),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
