import 'exercise.dart';

class Workout {
  final String? title;
  final List<Exercise> exercises;

  Workout({required this.title, required this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json){
    List<Exercise> exercises=[];
    int index = 0;
    int startTime = 0;
    for(var ex in json['excercises'] as Iterable)  {
      exercises.add(Exercise.fromJson(json, index, startTime));
      index++;
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(title: json['title'] as String?, exercises: exercises);
  }
}