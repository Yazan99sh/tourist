import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_settings/model/settings_module.dart';
import 'package:tourists/module_settings/state_manager/settings_state_manager.dart';

@provide
class SettingsScreen extends StatefulWidget {
  final SettingsStateManager _stateManager;

  SettingsScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => __SettingsScreenState();
}

class __SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(S.of(context).settings),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: widget._stateManager.getSettings(),
        builder: (BuildContext context, AsyncSnapshot<SettingsModel> snapshot) {
          if (snapshot.hasData) {
            return _getSettingsScreen(snapshot.data);
          }
          return Container();
        },
      ),
    );
  }

  Widget _getSettingsScreen(SettingsModel settingsModel) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text(S.of(context).language),
            trailing: DropdownButton(
              value: settingsModel.lang ?? 'en',
              onChanged: (value) {
                widget._stateManager.changeLanguage(value);
                setState(() {});
              },
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(S.of(context).language_english),
                ),
                DropdownMenuItem(
                  value: 'ar',
                  child: Text(S.of(context).language_arabic),
                )
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('${S.of(context).loginStatus}'),
            leading: Icon(Icons.person),
            trailing: settingsModel.currentUserRole == null
                ? Text('${S.of(context).notLoggedIn}')
                : settingsModel.currentUserRole == UserRole.ROLE_GUIDE
                    ? Text('${S.of(context).guide}')
                    : Text('${S.of(context).tourist}'),
          ),
        ),
        settingsModel.currentUserRole == null
            ? Container()
            : Card(
                child: ListTile(
                  title: Text('${S.of(context).logout}'),
                  leading: Icon(Icons.person),
                  trailing: IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      widget._stateManager.logout(context);
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
