import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bg_1/api_provider/api_provider.dart';
import 'package:flutter_bloc_bg_1/login/login_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(text: "eve.holt@reqres.in");
  final TextEditingController passwordController = TextEditingController(text: "cityslicka");

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 5) {
                      return 'Password should be at least 5 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final email = emailController.text;
                      final password = passwordController.text;
                      loginBloc.add(
                          PerformLoginEvent(email: email, password: password));
                    }
                  },
                  child: Text('Login'),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
                      return CircularProgressIndicator();
                    } else if (state is LoginErrorState) {
                      return Text(state.errorMessage);
                    } else if (state is LoginSuccessState) {
                      return Text(state.token);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
