class Alarm {
  DateTime? dateTime;
  String? description;
  String? day;
  bool? isset;

  Alarm(this.dateTime, this.day, this.description, this.isset);
}

List<Alarm> alarm_items = [
  Alarm(DateTime.now(), "Mon-Fri", "Regulae Class", true),
  Alarm(DateTime.now(), "Sat", "Gym", true),
  Alarm(DateTime.now(), "Sun", "Outing", true),
];
