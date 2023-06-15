import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passportpal/provider/user_provider.dart';
import 'package:passportpal/resources/FirestoreMethod.dart';
import 'package:passportpal/utlis/colors.dart';
import 'package:passportpal/utlis/utlis.dart';
import 'package:passportpal/widgets/postCard.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedCountry = 'All';

  final List<Color> gridItemColors = [
    const Color.fromRGBO(247, 141, 16, 1),
    const Color.fromRGBO(124, 17, 245, 1),
    const Color.fromRGBO(81, 240, 67, 1),
    const Color.fromRGBO(240, 103, 67, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.add_a_photo),
          color: Colors.blue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Material(child: AddPostScreen())),
            );
          },
        ),
        title: const Center(
          child: Text(
            'PassportPal',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: const TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                onPressed: () {
                  // Handle the search button click event
                },
                icon: const Icon(Icons.search, color: Colors.white),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.blue,
            ),
            style: const TextStyle(color: Colors.white),
            onSubmitted: (String value) {
              // Perform search operation with the submitted value
              // You can update the UI or trigger a search function here
              setState(() {
                // Update the search results
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              0,
              60,
              0,
              0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCountry = 'All';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedCountry == 'All' ? Colors.blue : Colors.grey,
                    fixedSize: const Size(30, 30),
                  ),
                  child: const Text('All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCountry = 'USA';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCountry == 'USA'
                        ? const Color.fromRGBO(154, 150, 252, 1)
                        : Colors.grey,
                    fixedSize: const Size(30, 30),
                  ),
                  child: const Text('USA'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCountry = 'CAN';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCountry == 'CAN'
                        ? const Color.fromRGBO(154, 150, 252, 1)
                        : Colors.grey,
                    fixedSize: const Size(30, 30),
                  ),
                  child: const Text('CAN'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCountry = 'Jap';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCountry == 'Jap'
                        ? const Color.fromRGBO(154, 150, 252, 1)
                        : Colors.grey,
                    fixedSize: const Size(30, 30),
                  ),
                  child: const Text('Jap'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCountry = 'Aus';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCountry == 'Aus'
                        ? const Color.fromRGBO(154, 150, 252, 1)
                        : Colors.grey,
                    fixedSize: const Size(30, 30),
                  ),
                  child: const Text('Aus'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('description',
                      isEqualTo:
                          selectedCountry != 'All' ? selectedCountry : null)
                  .where('description', isGreaterThanOrEqualTo: selectedCountry)
                  .snapshots(),
              builder: (
                context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: Colors.amber,
                    ),
                  );
                }

                if (snapshot.hasData) {
                  // Check if snapshot has data before accessing it
                  final filteredPosts = snapshot.data!.docs
                      .where((doc) => doc['username']
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) => PostCard(
                      snap: filteredPosts[index].data(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isloading = false;

  void PostImage(
    String uid,
    String username,
    String profImages,
  ) async {
    setState(() {
      _isloading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, uid, username, _file!, profImages);

      if (res == "success") {
        setState(() {
          _isloading = false;
        });
        clearImage();
        showSnackBar("Posted", context);
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectimage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take A photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              )
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectimage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () =>
                      PostImage(user.uid, user.username, user.photoUrl),
                  child: _isloading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                        )
                      : const Text(
                          "Post",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                )
              ],
            ),
            body: Column(children: [
              _isloading
                  ? const Center(
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    )
                  : const Padding(padding: EdgeInsets.only(top: 0)),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'write Caption...',
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
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
                  const Divider()
                ],
              )
            ]),
          );
  }
}
