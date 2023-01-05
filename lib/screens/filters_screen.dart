import 'package:flutter/material.dart';
import 'package:travel_app/widgets/app_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const screenRoute = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _summer = false;
  var _winter = false;
  var _family = false;

  @override
  initState() {
    _summer = widget.currentFilters['summer']!;
    _winter = widget.currentFilters['winter']!;
    _family = widget.currentFilters['family']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtering'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'summer': _summer,
                'winter': _winter,
                'family': _family,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
              child: ListView(
            children: [
              SwitchListTile(
                  activeColor: Colors.yellow[700],
                  title: Text('Summer Trips'),
                  subtitle: Text('Show Summer Trips Only'),
                  value: _summer,
                  onChanged: (value) {
                    setState(() {
                      _summer = value;
                    });
                  }),
              SwitchListTile(
                  activeColor: Colors.yellow[700],
                  title: Text(
                    'Winter Trips',
                  ),
                  subtitle: Text('Show Winter Trips Only'),
                  value: _winter,
                  onChanged: (value) {
                    setState(() {
                      _winter = value;
                    });
                  }),
              SwitchListTile(
                  activeColor: Colors.yellow[700],
                  title: Text('Trips For Families'),
                  subtitle: Text('Show Only Trips For Families'),
                  value: _family,
                  onChanged: (value) {
                    setState(() {
                      _family = value;
                    });
                  }),
            ],
          )),
        ],
      ),
    );
  }
}
