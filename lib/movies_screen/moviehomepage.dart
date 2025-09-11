import 'package:flutter/material.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  bool isWatchListSelected = false;
  int selectedMovieIndex = 1;
  int _currentIndex = 3;


  final List<String> movieImages = [
    'assets/Images/Group 13.png',
    'assets/Images/Group 21.png',
    'assets/Images/Group 22.png',
    'assets/Images/Group 23.png',
    'assets/Images/Group 24.png',
    'assets/Images/Group 25.png',
    'assets/Images/Group 26.png',
    'assets/Images/Group 28.png',
    'assets/Images/Group 30.png',
    'assets/Images/Group 27.png',
    'assets/Images/Group 29.png',
    'assets/Images/Group 31.png',
  ];


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        _showOptionsDialog(context);
        break;
      case 3:
        break;
    }
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Choose Action', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('My List', style: TextStyle(color: Colors.yellow, fontSize: 18)),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Settings', style: TextStyle(color: Colors.yellow, fontSize: 18)),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.grey[900],
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isWatchListSelected = true;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(Icons.list, color: Colors.yellow, size: 50),
                          SizedBox(height: 10),
                          Text(
                            'Watch List',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            height: 3,
                            width: 60,
                            color: isWatchListSelected ? Colors.yellow : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 90),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isWatchListSelected = false;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(Icons.folder, color: !isWatchListSelected ? Colors.yellow : Colors.grey, size: 50),
                          SizedBox(height: 4),
                          Text(
                            'History',
                            style: TextStyle(
                              color: !isWatchListSelected ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            height: 4,
                            width: 60,
                            color: !isWatchListSelected ? Colors.yellow : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  itemCount: movieImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    bool isSelected = selectedMovieIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMovieIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: isSelected ? Border.all(color: Colors.blue, width: 3) : null,
                          color: Colors.grey[800],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                movieImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[700],
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.error, color: Colors.white, size: 30),
                                          SizedBox(height: 5),
                                          Text(
                                            'Image ${index + 1}',
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            movieImages[index].split('/').last,
                                            style: TextStyle(color: Colors.white, fontSize: 10),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 6,
                              left: 6,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Text('7.7', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    SizedBox(width: 4),
                                    Icon(Icons.star, size: 16, color: Colors.yellow),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              color: Color(0xFF222222),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(0),
                    child: Icon(
                        Icons.home,
                        color: _currentIndex == 0 ? Colors.orange : Colors.grey,
                        size: 28
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(1),
                    child: Icon(
                        Icons.search,
                        color: _currentIndex == 1 ? Colors.orange : Colors.grey,
                        size: 28
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(2),
                    child: Icon(
                        Icons.check_box_outline_blank,
                        color: _currentIndex == 2 ? Colors.orange : Colors.grey,
                        size: 28
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(3),
                    child: Icon(
                        Icons.person,
                        color: _currentIndex == 3 ? Colors.orange : Colors.grey,
                        size: 28
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}