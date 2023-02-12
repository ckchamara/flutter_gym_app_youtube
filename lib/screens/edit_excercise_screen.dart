import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:numberpicker/numberpicker.dart';

import '../helpers.dart';

class EditExerciseScreen extends StatefulWidget {
  final Workout? workout;
  final int workoutIndex;
  final int? exIndex;

  const EditExerciseScreen(
      {Key? key, this.workout, required this.workoutIndex, this.exIndex})
      : super(key: key);

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  TextEditingController? _title;

  @override
  void initState() {
    _title = TextEditingController(
        text: widget.workout!.exercises[widget.exIndex!].title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: InkWell(
              onLongPress: () => showDialog(
                  context: context,
                  builder: (_) {
                    final controller = TextEditingController(
                        text: widget.workout!.exercises[widget.exIndex!].prelude
                            .toString());
                    return AlertDialog(
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            labelText: "Prelude (Seconds)"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                Navigator.pop(context);
                                setState(() {
                                  widget.workout!.exercises[widget.exIndex!] =
                                      widget.workout!.exercises[widget.exIndex!]
                                          .copyWith(prelude: int.parse(controller.text));
                                  BlocProvider.of<WorkoutsCubit>(context)
                                      .saveWorkouts(
                                          widget.workout!, widget.workoutIndex);
                                });
                              }
                            },
                            child: Text("save"))
                      ],
                    );
                  }),
              child: NumberPicker(
                  itemHeight: 30,
                  minValue: 0,
                  maxValue: 3599,
                  value: widget.workout!.exercises[widget.exIndex!].prelude!,
                  textMapper: (strVal) => formatTime(int.parse(strVal), false),
                  onChanged: (value) => setState(() {
                        widget.workout!.exercises[widget.exIndex!] = widget
                            .workout!.exercises[widget.exIndex!]
                            .copyWith(prelude: value);
                        BlocProvider.of<WorkoutsCubit>(context)
                            .saveWorkouts(widget.workout!, widget.workoutIndex);
                      })),
            )),
            Expanded(
              flex: 3,
                child: TextField(
              textAlign: TextAlign.center,
              controller: _title,
              onChanged: (value) => setState(() {
                widget.workout!.exercises[widget.exIndex!] = widget
                    .workout!.exercises[widget.exIndex!]
                    .copyWith(title: value);
                BlocProvider.of<WorkoutsCubit>(context)
                    .saveWorkouts(widget.workout!, widget.workoutIndex);
              }),
            )),
            Expanded(
                child: InkWell(
                  onLongPress: () => showDialog(
                      context: context,
                      builder: (_) {
                        final controller = TextEditingController(
                        text: widget.workout!.exercises[widget.exIndex!].duration
                                .toString());
                        return AlertDialog(
                          content: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                labelText: "Duration (Seconds)"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    Navigator.pop(context);
                                    setState(() {
                                      widget.workout!.exercises[widget.exIndex!] =
                                          widget.workout!.exercises[widget.exIndex!]
                                              .copyWith(duration: int.parse(controller.text));
                                      BlocProvider.of<WorkoutsCubit>(context)
                                          .saveWorkouts(
                                          widget.workout!, widget.workoutIndex);
                                    });
                                  }
                                },
                                child: Text("save"))
                          ],
                        );
                      }),
                  child: NumberPicker(
                      itemHeight: 30,
                      minValue: 0,
                      maxValue: 3599,
                      value: widget.workout!.exercises[widget.exIndex!].duration!,
                      textMapper: (strVal) => formatTime(int.parse(strVal), false),
                      onChanged: (value) => setState(() {
                        widget.workout!.exercises[widget.exIndex!] = widget
                            .workout!.exercises[widget.exIndex!]
                            .copyWith(duration: value);
                        BlocProvider.of<WorkoutsCubit>(context)
                            .saveWorkouts(widget.workout!, widget.workoutIndex);
                      })),
                )),

          ],
        )
      ],
    );
  }
}
