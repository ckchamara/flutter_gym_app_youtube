import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

import '../blocs/workouts_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Time'),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.event_available)),
          IconButton(onPressed: null, icon: Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, workouts) => ExpansionPanelList.radio(
            children: workouts
                .map((workout) => ExpansionPanelRadio(
                    value: workout,
                    headerBuilder: (BuildContext context, bool isExpanded) =>
                        ListTile(
                          visualDensity: const VisualDensity(
                              vertical: 0,
                              horizontal: VisualDensity.minimumDensity),
                          leading: IconButton(
                            onPressed: () {
                              BlocProvider.of<WorkoutCubit>(context)
                                  .editWorkout(
                                      workout, workouts.indexOf(workout));
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          title: Text(workout.title!),
                          trailing: Text(formatTime(workout.getTotal(), true)),
                          onTap: () => !isExpanded
                              ? BlocProvider.of<WorkoutCubit>(context)
                                  .startWorkout(workout)
                              : null,
                        ),
                    body: ListView.builder(
                        shrinkWrap: true,
                        itemCount: workout.exercises.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ListTile(
                              onTap: null,
                              visualDensity: const VisualDensity(
                                  vertical: 0,
                                  horizontal: VisualDensity.minimumDensity),
                              leading: Text(formatTime(
                                  workout.exercises[index].prelude!, true)),
                              title: Text(workout.exercises[index].title!),
                              trailing: Text(formatTime(
                                  workout.exercises[index].duration!, true)),
                            ))))
                .toList(),
          ),
        ),
      ),
    );
  }
}
