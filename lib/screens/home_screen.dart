import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                          leading: const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.edit),
                          ),
                          title: Text(workout.title!),
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
                              leading: const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.edit),
                              ),
                              title: Text(workout.exercises[index].title!),
                            ))))
                .toList(),
          ),
        ),
      ),
    );
  }
}
