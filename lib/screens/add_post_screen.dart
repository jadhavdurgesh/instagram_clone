import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_firebase/models/user.dart';
import 'package:instagram_firebase/providers/user_provider.dart';
import 'package:instagram_firebase/resources/firestore_methods.dart';
import 'package:instagram_firebase/utiils/colors.dart';
import 'package:instagram_firebase/utiils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _captionController = TextEditingController();

  void postImage(String uid, String profileImage, String username) async {
    try {
      String res = await FirestoreMethods().uploadPost(
          _captionController.text, uid, _file!, username, profileImage);

      if (res == "success") {
        showSnackBar("Successfully Posted!", context);
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create a post"),
            children: [
              SimpleDialogOption(
                child: Text("Take a photo"),
                padding: EdgeInsets.all(12),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: Text("Choose from gallery"),
                padding: EdgeInsets.all(12),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                padding: EdgeInsets.all(12),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () => _selectImage(context),
                icon: Icon(
                  Icons.file_upload_outlined,
                  size: 36,
                )),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text("Post to"),
              centerTitle: false,
              leading: IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_back_ios_outlined)),
              actions: [
                TextButton(
                    onPressed: () =>
                        postImage(user.uid, user.photoUrl, user.username),
                    child: Text(
                      'Post',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      12.heightBox,
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      12.widthBox,
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        child: TextField(
                          controller: _captionController,
                          decoration: InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none,
                          ),
                          maxLines: 5,
                        ),
                      ),
                      SizedBox(
                        height: 54,
                        width: 54,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(_file!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter)),
                          ),
                        ),
                      ),
                      Divider(
                        color: primaryColor,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
