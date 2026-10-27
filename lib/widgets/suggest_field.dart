import 'package:flutter/material.dart';

/// A text field that offers suggestions while typing. The text stays free: a suggestion only fills it in.
///
/// [options] gets what is typed so far and returns the matching suggestions (build it with
/// `filterSuggestions`). Use this for every text field that has a catalogue or a history of values.
class SuggestField extends StatefulWidget {
  const SuggestField({
    super.key,
    required this.controller,
    required this.label,
    required this.options,
    this.autofocus = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final List<String> Function(String query) options;
  final bool autofocus;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<SuggestField> createState() => _SuggestFieldState();
}

class _SuggestFieldState extends State<SuggestField> {
  final _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RawAutocomplete<String>(
        textEditingController: widget.controller,
        focusNode: _focus,
        optionsBuilder: (v) => widget.options(v.text),
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) => TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          decoration: InputDecoration(labelText: widget.label),
          onFieldSubmitted: (v) {
            onFieldSubmitted();
            widget.onSubmitted?.call(v);
          },
        ),
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240, maxWidth: 360),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  for (final o in options) ListTile(dense: true, title: Text(o), onTap: () => onSelected(o)),
                ],
              ),
            ),
          ),
        ),
      );
}
