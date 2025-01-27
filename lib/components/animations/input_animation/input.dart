import 'package:flutter/material.dart';

// https://21st.dev/originui/input/input-with-start-select

class InputWithProtocolSelect extends StatefulWidget {
  final Function(String)? onProtocolChanged;
  final Function(String)? onInputChanged;
  final String? initialProtocol;
  final String? initialInput;

  const InputWithProtocolSelect({
    Key? key,
    this.onProtocolChanged,
    this.onInputChanged,
    this.initialProtocol,
    this.initialInput,
  }) : super(key: key);

  @override
  _InputWithProtocolSelectState createState() => _InputWithProtocolSelectState();
}

class _InputWithProtocolSelectState extends State<InputWithProtocolSelect> {
  late String selectedProtocol;
  final protocols = [
    'https://',
    'http://',
    'ftp://',
    'sftp://',
    'ws://',
    'wss://',
  ];
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _selectFocusNode = FocusNode();
  final FocusNode _inputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedProtocol = widget.initialProtocol ?? protocols[0];
    _inputController.text = widget.initialInput ?? '';
  }

  @override
  void dispose() {
    _inputController.dispose();
    _selectFocusNode.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Input with start select',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        // Input Container
        IntrinsicHeight(
          child: Row(
            children: [
              // Protocol Selector
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(8),
                  ),
                ),
                child: Focus(
                  focusNode: _selectFocusNode,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: selectedProtocol,
                        items: protocols.map((String protocol) {
                          return DropdownMenuItem<String>(
                            value: protocol,
                            child: Text(
                              protocol,
                              style: TextStyle(
                                fontSize: 14,
                                color: _selectFocusNode.hasFocus
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.shade600,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedProtocol = newValue;
                            });
                            widget.onProtocolChanged?.call(newValue);
                          }
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        focusColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              // Text Input
              Expanded(
                child: TextField(
                  controller: _inputController,
                  focusNode: _inputFocusNode,
                  decoration: InputDecoration(
                    hintText: '192.168.1.1',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(8),
                      ),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  onChanged: widget.onInputChanged,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}