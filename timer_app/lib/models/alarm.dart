
class Alarm {
    Alarm({
      required  this.id,
       required this.title,
       required this.description,
        this.isactive,
       required this.datatime,
    });

    int id;
    String title;
    String description;
    int? isactive;
    DateTime datatime;

    // factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
    //     id: json["id"],
    //     title: json["title"],
    //     description: json["description"],
    //     isactive: json["isactive"],
    //     datatime: DateTime.parse(json["datatime"]),
    // );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "title": title,
    //     "description": description,
    //     "isactive": isactive,
    //     "datatime": datatime.toIso8601String(),
    // };
}

// List<Alarm> alarm_items = [
//   Alarm(DateTime.now(), "Mon-Fri", "Regulae Class", true),
//   Alarm(DateTime.now(), "Sat", "Gym", true),
//   Alarm(DateTime.now(), "Sun", "Outing", true),
// ];
