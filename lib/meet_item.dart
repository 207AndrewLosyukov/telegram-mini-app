import 'package:flutter/material.dart';

class CircleModel {
  final String? image;
  final String text;
  final int color;

  CircleModel(this.image, this.text, this.color);
}

class MeetItemModel {
  final int activeCount;
  final int count;
  final String name;
  final String date;
  final String time;
  final List<CircleModel> circles;

  MeetItemModel(this.activeCount, this.count, this.name, this.date, this.time,
      this.circles);
}

class MeetItem extends StatelessWidget {
  const MeetItem({super.key, required this.model});

  final MeetItemModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Text("${model.activeCount}/${model.count}: "),
                    for (var circle in model.circles)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: circle.image == null
                            ? Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(circle.color),
                                ),
                                child: Center(
                                  child: Text(
                                    circle.text,
                                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  circle.image!,
                                  width: 20.0,
                                  height: 20.0,
                                ),
                              ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                model.date,
                textAlign: TextAlign.end,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  model.time,
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
