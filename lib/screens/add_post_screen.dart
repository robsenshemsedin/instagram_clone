import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/resources_export.dart';
import 'package:instagram_clone/utils/utils_export.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  AddPostScreenState createState() => AddPostScreenState();
}

class AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  late final user = Provider.of<UserProvider>(context).getUser;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  Future<void> addPost() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final res = await FirestoreMethos().uploadPost(
        _descriptionController.text,
        _file!,
        user,
      );
      if (res == 'success') {
        _isLoading = false;
        if (!context.mounted) return;
        showSnackBar(context, 'Posted!');
        clearImage();
      } else {
        _isLoading = false;
        if (!context.mounted) return;
        showSnackBar(context, res);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () async {
                  final file = await pickProfileImage(context);
                  setState(() {
                    _file = file;
                  });
                },
                icon: const Icon(Icons.upload_file)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text(
                'Post to',
              ),
              centerTitle: false,
              actions: <Widget>[
                TextButton(
                  onPressed: addPost,
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: LinearProgressIndicator(
                          color: blueColor,
                        ),
                      )
                    : const SizedBox(),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                                hintText: "Write a caption...",
                                border: InputBorder.none),
                            maxLines: 5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45.0,
                        width: 45.0,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              image: MemoryImage(_file!),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          );
  }
}
