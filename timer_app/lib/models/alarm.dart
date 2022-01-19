class Alarm {
  Alarm({
    this.id,
    required this.title,
    required this.description,
    this.isactive,
    required this.datatime,
  });

  int? id;
  String title;
  String description;
  int? isactive;
  DateTime datatime;
}


