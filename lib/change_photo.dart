import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
// 'flutter pub get' to install the new dependency (shimmer)

class ChangePhotoPage extends StatefulWidget {
  const ChangePhotoPage({super.key});

  @override
  ChangePhotoPageState createState() => ChangePhotoPageState();
}

class ChangePhotoPageState extends State<ChangePhotoPage> {
  bool _isFirstImage = true;

  void _toggleImage() {
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Photo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous page
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello, Flutter User!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _toggleImage();
                print('Button Pressed!');
              },
              child: const Text('Press Me'),
            ),
            const SizedBox(height: 20),
            // Image widget with a loading state
            Image.network(
              _isFirstImage
                  ? 'https://tinyurl.com/bdfd544u' // First image URL
                  : 'https://tinyurl.com/5avhjw6j', // Second image URL
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  // Image is loaded
                  return child; // Show the loaded image
                } else {
                  // Image is still loading
                  return _buildSkeletonLoader();
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                // If the image fails to load, you can show an error widget here
                return const Text('Failed to load image');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the skeleton loader
  Widget _buildSkeletonLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 700, // Adjust the width and height as needed
        height: 400,
        color: Colors.white,
      ),
    );
  }
}
