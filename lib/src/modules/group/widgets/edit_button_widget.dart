import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      icon: const Icon(Icons.edit),
    );
  }
}
