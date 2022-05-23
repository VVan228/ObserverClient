import 'package:flutter/material.dart';

import '../model/auth_impl.dart';
import '../model/intefaces/auth_model.dart';
import '../presenters/interfaces/sign_in_presenter.dart';
import '../presenters/sign_in_impl.dart';
import 'interfaces/sign_in_view.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final SignInPresenter presenter = SignInImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(child: SignInForm(presenter)),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  final SignInPresenter presenter;
  const SignInForm(this.presenter, {Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> implements SignInView {
  AuthModel auth = AuthImpl();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _msg = "";

  void _changeMsg(String m) {
    setState(() {
      _msg = m;
    });
  }

  @override
  void initState() {
    widget.presenter.setView(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sign in', style: Theme.of(context).textTheme.headline4),
              const SizedBox(
                width: 32,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(hintText: 'password'),
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0), child: Text(_msg)),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Theme.of(context).colorScheme.secondary;
                }),
              ),
              onPressed: () {
                widget.presenter.submitClick(
                    _emailController.text, _passwordController.text);
              },
              child: const Text('Sign in'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void showMassage(String msg) {
    _changeMsg(msg);
  }

  @override
  void openAdminPage() {
    // TODO: implement openAdminPage
  }

  @override
  void openStudentPage() {
    // TODO: implement openStudentPage
  }

  @override
  void openTeacherPage() {
    // TODO: implement openTeacherPage
  }
}
