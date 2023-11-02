import 'package:flutter/material.dart';
import 'package:hibye_mini_app/meet_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.image});
  final String? image;

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
                    height: 40,
                    width: MediaQuery.of(context).size.width - 160,
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
                    child: widget.image == null
                        ? Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Image.network(
                              widget.image!,
                              width: 40.0,
                              height: 40.0,
                            ),
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
              width: MediaQuery.of(context).size.width - 90,
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
                          model: MeetItemModel(3, 5, "Встреча", "5 ноября",
                              "18:00", [CircleModel(null, "⋯", 0xFFFFF3FF), CircleModel(null, "⋯", 0xFFFFF3FF),CircleModel(null, "⋯", 0xFFFFF3FF),CircleModel(null, "⋯", 0xFFFFF3FF),CircleModel(null, "⋯", 0xFFFFF3FF),CircleModel(null, "⋯", 0xFFFFF3FF),CircleModel(null, "⋯", 0xFFFFF3FF),CircleModel(null, "⋯", 0xFFFFF3FF),CircleModel(null, "⋯", 0xFFFFF3FF),])),
                    );
                  },
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
