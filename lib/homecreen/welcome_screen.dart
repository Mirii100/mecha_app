import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> welcomeData = [
    {
      "title": "Welcome to mecha App",
      "description": "Explore the best services we offer.",
      "image": "images/my_image.jpg"
    },
    {
      "title": "Connect with  Mecha-app Experts",
      "description": "Find professionals to help with your needs.",
      "image": "images/my_image.jpg"



    },


    {
      "title": "Stay Updated",
      "description": "Get real-time updates and notifications.",
      "image": "images/my_image2.jpg"
    },
    {
      "title": "feed",
      "description": "do not ever feel furious when letting us know  your concerns   .this is a platform where everyone is "
          "someone",
      "image": "images/my_image2.jpg"
    },
    {
      "title": "Stay Updated with our contents at Mecha_app",
      "description": "Get real-time updates and notifications.",
      "image": "images/my_image2.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemCount: welcomeData.length,
        itemBuilder: (context, index) => WelcomeSlide(
          title: welcomeData[index]["title"]!,
          description: welcomeData[index]["description"]!,
          image: welcomeData[index]["image"]!,
        ),
      ),
      bottomSheet: _currentPage == welcomeData.length - 1
          ? TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/LoginScreen');
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          minimumSize: Size(double.infinity, 60),
        ),
        child: Text(
          "Get Started",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : Container(
        padding: EdgeInsets.all(16.0),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            ),
            TextButton(
              onPressed: () {
                _pageController.animateToPage(
                  welcomeData.length - 1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              child: Text("Skip"),
            ),
            Row(
              children: List.generate(
                welcomeData.length,
                    (index) => buildDot(index: index),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class WelcomeSlide extends StatelessWidget {
  final String title, description, image;

  const WelcomeSlide({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300), // Ensure the images are in assets
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
