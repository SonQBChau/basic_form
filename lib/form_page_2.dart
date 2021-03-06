import 'package:rubber/rubber.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

class FormPage2 extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<FormPage2> with SingleTickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _name = '';
  String _email = '';
  int _age = 0;
  int _selectedGender = 0;
  List<DropdownMenuItem<int>> genderList = [];
  String _maritalStatus = 'single';
  bool _termsChecked = true;
  final GlobalKey<ScaffoldState> _bottomScaffoldKey = GlobalKey<ScaffoldState>();


  var _passKey = GlobalKey<FormFieldState>();
  String _password = '';





  void loadGenderList() {
    genderList = [];
    genderList.add(new DropdownMenuItem(
      child: new Text('Male'),
      value: 0,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('Female'),
      value: 1,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('Other'),
      value: 2,
    ));
  }

  void onPressedSubmit() {
    if (_formKey.currentState.validate() && _termsChecked) {
      _formKey.currentState.save();

      print("Name " + _name);
      print("Email " + _email);
      print("Age " + _age.toString());
      switch (_selectedGender) {
        case 0:
          print("Gender Male");
          break;
        case 1:
          print("Gender Female");
          break;
        case 3:
          print("Gender Others");
          break;
      }
      print("Marital Status " + _maritalStatus);
      print("Password " + _password);
      print("Termschecked " + _termsChecked.toString());

      final snackBar = SnackBar(content: Text('Form Submitted'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Form Demo 2'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ),
      ),

//    body : sidekickStack(controller,  context),

    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(nameTextField());
    formWidget.add(emailTextField());
    formWidget.add(ageTextField());
    formWidget.add(passwordTextField());
    formWidget.add(confirmPasswordTextField());
    formWidget.add(genderDropdown());
    formWidget.add(statusRadioButton());
    formWidget.add(termCheckbox());
    formWidget.add(submitButton());






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
      decoration: InputDecoration(labelText: 'Enter Email', hintText: 'Email'),
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
      decoration: InputDecoration(labelText: 'Enter Age', hintText: 'Age'),
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

  TextFormField passwordTextField() {
    return TextFormField(
        key: _passKey,
        obscureText: true,
        decoration:
            InputDecoration(hintText: 'Password', labelText: 'Enter Password'),
        validator: (value) {
          if (value.isEmpty) return 'Please Enter password';
          if (value.length < 8)
            return 'Password should be more than 8 characters';
        });
  }

  TextFormField confirmPasswordTextField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirm Password', labelText: 'Enter Confirm Password'),
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

  DropdownButton genderDropdown() {
    return DropdownButton(
      hint: new Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      isExpanded: true,
    );
  }

  Widget statusRadioButton() {
    return Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Single'),
          value: 'single',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Married'),
          value: 'married',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value;
            });
          },
        ),
      ],
    );
  }

  Widget termCheckbox() {
    return CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value;
        });
      },
      subtitle: !_termsChecked
          ? Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: new Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget submitButton() {
    return RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('Sign Up'),
        onPressed: onPressedSubmit);
  }







  }



