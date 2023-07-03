enum Categ { work, entertainment, routine }

class Productivity {
  String taskName;
  DateTime startTime;
  DateTime endTime;
  int duration;
  Categ type;

  Productivity(
      {required this.taskName,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.type});
}
