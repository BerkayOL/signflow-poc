import 'package:flutter/material.dart';

import 'sign_keyboard_key.dart';

class SignKeyboard extends StatefulWidget {
  const SignKeyboard({
    super.key,
    required this.onCharacter,
    required this.onBackspace,
    required this.onSpace,
  });

  final ValueChanged<String> onCharacter;
  final VoidCallback onBackspace;
  final VoidCallback onSpace;

  @override
  State<SignKeyboard> createState() => _SignKeyboardState();
}

class _SignKeyboardState extends State<SignKeyboard> {
  var _isNumeric = false;

  static const _rows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'Ğ', 'Ü'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ş', 'İ'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Ö', 'Ç'],
  ];

  static const _numericRows = [
    ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
    ['?', '!', '@', '#', '%', '&', '-', '+', '(', ')'],
  ];

  @override
  Widget build(BuildContext context) {
    if (_isNumeric) return _buildNumericKeyboard();
    return Column(
      children: [
        for (var index = 0; index < _rows.length; index++)
          Row(
            children: [
              if (index == 1) const Spacer(),
              for (final keyLabel in _rows[index])
                SignKeyboardKey(
                  label: keyLabel,
                  onPressed: () => widget.onCharacter(keyLabel),
                ),
              if (index == 2)
                SignKeyboardKey(
                  label: 'Sil',
                  icon: Icons.backspace_outlined,
                  onPressed: widget.onBackspace,
                  flex: 2,
                ),
              if (index == 1) const Spacer(),
            ],
          ),
        Row(
          children: [
            SignKeyboardKey(
              label: '123',
              onPressed: () => setState(() => _isNumeric = true),
              flex: 2,
            ),
            SignKeyboardKey(
              label: 'boşluk',
              onPressed: widget.onSpace,
              flex: 7,
            ),
            SignKeyboardKey(
              label: '.',
              onPressed: () => widget.onCharacter('.'),
              flex: 2,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumericKeyboard() {
    return Column(
      children: [
        for (final row in _numericRows)
          Row(
            children: [
              for (final keyLabel in row)
                SignKeyboardKey(
                  label: keyLabel,
                  onPressed: () => widget.onCharacter(keyLabel),
                ),
            ],
          ),
        Row(
          children: [
            SignKeyboardKey(
              label: 'ABC',
              onPressed: () => setState(() => _isNumeric = false),
              flex: 2,
            ),
            SignKeyboardKey(
              label: 'boşluk',
              onPressed: widget.onSpace,
              flex: 6,
            ),
            SignKeyboardKey(
              label: 'Sil',
              icon: Icons.backspace_outlined,
              onPressed: widget.onBackspace,
              flex: 2,
            ),
          ],
        ),
      ],
    );
  }
}
