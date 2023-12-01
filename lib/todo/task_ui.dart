import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bg_1/todo/model/todo_model.dart';
import 'package:flutter_bloc_bg_1/todo/task_bloc.dart';
import 'package:flutter_bloc_bg_1/todo/widget/task_widget.dart';

class TodoScreenMain extends StatefulWidget {
  const TodoScreenMain({super.key});

  @override
  State<TodoScreenMain> createState() => _TodoScreenMainState();
}

class _TodoScreenMainState extends State<TodoScreenMain> {
  late TextEditingController textInputTitleController;
  late TextEditingController textInputUserIdController;

  @override
  void initState() {
    super.initState();

    textInputTitleController = TextEditingController();
    textInputUserIdController = TextEditingController();
  }

  @override
  void dispose() {
    textInputTitleController.dispose();
    textInputUserIdController.dispose();
    super.dispose();
  }

  Future<Task?> _openDialog(int lastId) {
    textInputTitleController.text = '';
    textInputUserIdController.text = '';
    return showDialog<Task>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0XFFfeddaa),
        title: TextField(
            controller: textInputTitleController,
            decoration: const InputDecoration(
                fillColor: Color(0XFF322a1d),
                hintText: 'Task Title',
                border: InputBorder.none)),
        content: TextField(
            controller: textInputUserIdController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
                hintText: 'User ID', border: InputBorder.none, filled: true)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              )),
          TextButton(
            onPressed: (() {
              if (textInputTitleController.text != '' &&
                  textInputUserIdController.text != '') {
                Navigator.of(context).pop(Task(
                    id: lastId + 1,
                    userId: int.parse(textInputUserIdController.text),
                    title: textInputTitleController.text,isComplete: true));
              }
            }),
            child: const Text(
              'Add',
              style: TextStyle(
                color: Color(0xFF322a1d),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int? lastId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<TaskBloc, TasksState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const CircularProgressIndicator();
          }
          if (state is TasksLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ...state.tasks.map(
                      (task) => InkWell(
                        onTap: (() {
                          context.read<TaskBloc>().add(UpdateTask(
                              task:
                                  task.copyWith(isComplete: task.isComplete)));
                        }),
                        child: TaskWidget(
                          task: task,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Text('No Task Found');
          }
        },
      ),
      floatingActionButton: BlocListener<TaskBloc, TasksState>(
        listener: (context, state) {
          if (state is TasksLoaded) {
            lastId = state.tasks.last.id;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Task Updated!'),
            ));
          }
        },
        child: FloatingActionButton(
          backgroundColor: const Color(0xFFf8bd47),
          foregroundColor: const Color(0xFF322a1d),
          onPressed: () async {
            Task? task = await _openDialog(lastId ?? 0);
            if (task != null) {
              context.read<TaskBloc>().add(
                    AddTask(task: task),
                  );
            }
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
