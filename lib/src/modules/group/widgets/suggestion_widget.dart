import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'suggestion_filed_widget.dart';

class Suggestion extends StatelessWidget {
  Suggestion({
    super.key,
    required this.suggestionFieldList,
    required this.addNewField,
    required this.removeField,
    required this.onEditingComplete,
  });

  List<TextEditingController> suggestionFieldList;
  void Function() addNewField;
  void Function(int hashCode) removeField;
  final void Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            Text(
              'Sugestão de Presentes',
              style: GoogleFonts.itim().copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: addNewField,
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: onEditingComplete,
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...suggestionFieldList
            .map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: mediaQuery.size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: mediaQuery.size.width * 0.7,
                        height: 60,
                        child: SuggestionField(
                          controller: e,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.15,
                        height: 60,
                        child: Center(
                          child: IconButton(
                            onPressed: () => removeField(e.hashCode),
                            icon: const Icon(Icons.remove),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }
}
