import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dropdown with Search and Custom Option',
//       home: DropdownWithSearchAndCustomOption(),
//     );
//   }
// }

class DropdownWithSearchAndCustomOption extends StatefulWidget {
  @override
  _DropdownWithSearchAndCustomOptionState createState() =>
      _DropdownWithSearchAndCustomOptionState();
}

class _DropdownWithSearchAndCustomOptionState
    extends State<DropdownWithSearchAndCustomOption> {
  final List<String> _options = [
    'About',
    'Base',
    'Blog',
    'Contact',
    'Custom',
    'Support',
    'Tools',
  ];
  List<String> _filteredOptions = [];
  String _selectedOption = '';
  bool _isDropdownOpen = false;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _customOptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredOptions = _options;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown with Search and Custom Option'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isDropdownOpen = !_isDropdownOpen;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedOption.isNotEmpty
                        ? _selectedOption
                        : 'Dropdown'),
                    Icon(_isDropdownOpen
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            if (_isDropdownOpen)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _filteredOptions = _options
                                .where((option) => option
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                            if (value.isNotEmpty &&
                                !_filteredOptions.contains('Custom: $value')) {
                              _filteredOptions.add('Custom: $value');
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredOptions.length,
                        itemBuilder: (context, index) {
                          final option = _filteredOptions[index];
                          return GestureDetector(
                            onTap: () {
                              if (option.startsWith('Custom: ')) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Add Custom Option'),
                                    content: TextField(
                                      controller: _customOptionController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter custom option',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _options.add(
                                                _customOptionController.text);
                                            _selectedOption =
                                                _customOptionController.text;
                                            _isDropdownOpen = false;
                                            _searchController.clear();
                                            _customOptionController.clear();
                                            _filteredOptions = _options;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Add'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                setState(() {
                                  _selectedOption = option;
                                  _isDropdownOpen = false;
                                  _searchController.clear();
                                  _filteredOptions = _options;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              child: Text(option),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
