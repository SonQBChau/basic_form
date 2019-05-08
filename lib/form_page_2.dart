import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

class FormPage2 extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<FormPage2> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  int _age = 0;

  var _passKey = GlobalKey<FormFieldState>();

  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Demo 2'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ),
      ),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(nameTextField());
    formWidget.add(emailTextField());
    formWidget.add(ageTextField());
    formWidget.add(passwordTextField());
    formWidget.add(confirmPasswordTextField());

    return formWidget;
  }

  TextFormField nameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a name';
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Enter Email', hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter email';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  TextFormField ageTextField() {
    return TextFormField(
      decoration:
      InputDecoration(labelText: 'Enter Age', hintText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter age';
        }
      },
      onSaved: (value) {
        setState(() {
          _age = int.tryParse(value);
        });
      },
    );
  }

  TextFormField passwordTextField(){
    return TextFormField(
        key: _passKey,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password', labelText: 'Enter Password'),
        validator: (value) {
          if (value.isEmpty) return 'Please Enter password';
          if (value.length < 8)
            return 'Password should be more than 8 characters';
        });
  }

  TextFormField confirmPasswordTextField(){
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirm Password',
            labelText: 'Enter Confirm Password'),
        validator: (confirmPassword) {
          if (confirmPassword.isEmpty) return 'Enter confirm password';
          var password = _passKey.currentState.value;
          if (!equalsIgnoreCase(confirmPassword, password))
            return 'Confirm Password invalid';
        },
        onSaved: (value) {
          setState(() {
            _password = value;
          });
        });
  }



}
