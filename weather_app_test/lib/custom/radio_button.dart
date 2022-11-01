import 'package:flutter/material.dart';
import 'package:flutter/src/material/radio_list_tile.dart';
import 'package:weather_app_test/utils/app_constants.dart';
import 'package:weather_app_test/utils/pref.dart';

class RadioButton extends StatefulWidget {

  final String text;
  final int index;
  final int selectedButton;
  final Function press;

  const RadioButton({
    Key? key,
    required this.text,
    required this.index,
    required this.selectedButton,
    required this.press,
  }) : super();

  @override
  State<StatefulWidget> createState() => _RadioButtonPage();
}

class _RadioButtonPage extends State<RadioButton> {

  int id = 1;
  late bool _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.press(widget.index);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                // height: 60.0,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.grey,
                        disabledColor: Colors.blue),
                    child: Column(children: [
                      RadioListTile(
                        title: Text(
                          widget.text,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          softWrap: true,
                        ),
                        groupValue: widget.selectedButton,
                        value: widget.index,
                        activeColor: Colors.green,
                        onChanged: (val) async {
                          debugPrint('Radio button is clicked onChanged $val');
                          var prefs = AppPref.localStorage;
                          prefs.setInt(AppConstants.selectedBtn, val);
                          widget.press(widget.index);
                        },
                        toggleable: true,
                      ),
                    ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
