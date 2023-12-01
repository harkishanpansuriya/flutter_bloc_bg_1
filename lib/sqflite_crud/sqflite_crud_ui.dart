import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bg_1/sqflite_crud/model/user_model.dart';
import 'package:flutter_bloc_bg_1/sqflite_crud/sqflite_crud_bloc.dart';
import 'package:flutter_bloc_bg_1/util/extension.dart';

class SqfliteCrudUi extends StatefulWidget {
  const SqfliteCrudUi({Key? key}) : super(key: key);

  @override
  State<SqfliteCrudUi> createState() => _SqfliteCrudUiState();
}

class _SqfliteCrudUiState extends State<SqfliteCrudUi> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when they are no longer needed
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQFLite Crud'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<SqfliteCrudBloc, SqfliteCrudState>(
        builder: (context, state) {
          if (state is SqfliteCrudLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SqfliteCrudLoaded) {
            return ListView.builder(
              itemCount: state.userModel.length,
              itemBuilder: (BuildContext context, int index) {
                final user = state.userModel[index];
                return ListTile(
                  leading: Text('ID: ${user.id}'), // Leading displays ID
                  trailing: IconButton(
                    onPressed: () {
                      context.read<SqfliteCrudBloc>().add(
                            DeleteSqfliteCrudDetail(userModel: user),
                          );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  title: Text('Name: ${user.name}'), // Title displays Name
                  subtitle:
                      Text('Email: ${user.email}'), // Subtitle displays Email
                );
              },
            );
          }
          if (state is SqfliteCrudError) {
            return Center(
              child: Text(state.message.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Name and Email'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                UserModel userModel = UserModel();
                userModel.id = Random().nextIntInRange();
                userModel.name = nameController.text;
                userModel.email = emailController.text;

                // Call a method to update the user in your database, e.g., updateUserInfo(userModel);
                // Make sure to implement the updateUserInfo method.

                context.read<SqfliteCrudBloc>().add(
                      AddSqfliteCrudDetail(userModel: userModel),
                    );

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
