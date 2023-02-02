import 'exercise.dart';

class Workout {
  final String? title;
  final List<Exercise> exercises;

  Workout({required this.title, required this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json){
    List<Exercise> exercises=[];
    int index = 0;
    int StartTime = 0;
    for(var ex in json['excercises'] as Iterable)  {

    }
  }
}