import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../provider/Images.dart';

class PassPortImageInput extends StatefulWidget {
  @override
  _PassPortImageInput createState() => _PassPortImageInput();
}

class _PassPortImageInput extends State<PassPortImageInput> {
  List<XFile>? imgsFiles;

  void _selectImages() async {
    imgsFiles = Provider.of<ImagesToUpload>(context, listen: false)
        .getImagesForUpload
        .cast<XFile>();
    final ImagePicker _picker = ImagePicker();
    await _picker
        .pickMultiImage(
      maxWidth: 800,
      maxHeight: 600,
    )
        .then((value) {
      setState(() {
        if (value != null) {
          for (var e in value) {
            XFile fileForUpload = XFile(e.path);
            imgsFiles!.add(fileForUpload);
          }
          Provider.of<ImagesToUpload>(context, listen: false)
              .setImages(imgsFiles!);
        }
      });
    });
  }

  void _pickImagesFromCamera() async {
    imgsFiles = Provider.of<ImagesToUpload>(context, listen: false)
        .getImagesForUpload
        .cast<XFile>();
    final ImagePicker _picker = ImagePicker();
    await _picker
        .pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 600,
    )
        .then((value) {
      setState(() {
        if (value != null) {
          XFile fileForUpload = XFile(value.path);
          // List<int> fileInByte = fileForUpload.readAsBytesSync();
          // String fileInBase64 = base64Encode(fileInByte);
          imgsFiles!.add(fileForUpload);
          Provider.of<ImagesToUpload>(context, listen: false)
              .setImages(imgsFiles!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final int length = Provider.of<ImagesToUpload>(context, listen: false)
        .getImagesForUpload
        .length;
    return Column(
      children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: _pickImagesFromCamera,
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                label: Text(
                  '',
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton.icon(
                onPressed: _selectImages,
                icon: Icon(
                  Icons.photo_album_outlined,
                  color: Theme.of(context).primaryColorLight,
                ),
                label: Text(
                  '',
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: !length.isNaN
                ? GridView.builder(
                    itemCount:
                        Provider.of<ImagesToUpload>(context, listen: false)
                            .getImagesForUpload
                            .length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, crossAxisSpacing: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onLongPress: () => {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text('Delete an image ?'),
                                actions: <Widget>[
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.red,
                                      ),
                                    ),
                                    child: const Text(
                                      'NO',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                    child: const Text(
                                      'YES',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () => setState(() {
                                      Provider.of<ImagesToUpload>(context,
                                              listen: false)
                                          .getImagesForUpload
                                          .removeAt(index);
                                      Navigator.pop(context);
                                    }),
                                  ),
                                ],
                              );
                            },
                          )
                        },
                        child: Image.file(
                          Provider.of<ImagesToUpload>(context, listen: false)
                              .getImagesForUpload[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    })
                : Container())
      ],
    );
  }
}
