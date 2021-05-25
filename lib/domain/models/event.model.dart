class Event {
  String? name;
  String? category;
  String? time;
  List<dynamic>? days;
  bool? isFinished;
  Event ({this.category, this.days, this.isFinished, this.name, this.time});
}