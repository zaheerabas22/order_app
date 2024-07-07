
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NoteImageModal extends StatelessWidget {
  final TextEditingController noteController;
  final Function(String note, String? imagePath) onSave;

  NoteImageModal({
    required this.noteController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                String? imagePath = pickedFile?.path;
                onSave(noteController.text, imagePath);
                Navigator.of(context).pop();
              },
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSave(noteController.text, null);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
