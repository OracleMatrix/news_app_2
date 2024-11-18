News App 2
A Flutter-based news application that fetches the latest news articles from various categories. This app utilizes multiple packages to provide features like caching images, adaptive themes, internet connectivity checking, and file handling.

Features
Fetch Latest News: Automatically fetches the latest news articles from a specified source.
Category-based Filtering: Browse news articles by different categories like business, sports, technology, etc.
Pull to Refresh: Refresh news articles with a swipe-down gesture.
Offline Image Caching: Uses cached images for faster loading and offline viewing.
File Handling: Supports opening image and video files directly from the app.
Adaptive Theme: Automatically switches between light and dark themes based on the system preference.
Internet Connectivity Check: Alerts the user when there is no internet connection.
Technologies Used
Flutter: The app is built using Flutter framework.
Provider: State management is handled using the Provider package.
Dart: The app is written in Dart language.
Dependencies
Here are some of the key dependencies used in this project:

Dependency	Version
adaptive_theme	3.6.0
cached_network_image	3.4.1
connectivity_plus	6.1.0
dio	5.7.0
flutter_cache_manager	3.4.1
open_filex	4.5.0
path_provider	2.1.5
provider	6.1.2
pull_to_refresh	2.0.0
share_plus	10.1.2
timeago	3.7.0
url_launcher	6.3.1
Getting Started
Prerequisites
Flutter SDK version 3.24.3 or later
Dart SDK version 3.5.3 or later
Installation
Clone the repository:

bash
Copy code
git clone https://github.com/your-username/news_app_2.git
cd news_app_2
Install the dependencies:

bash
Copy code
flutter pub get
Run the application:

bash
Copy code
flutter run
Folder Structure
plaintext
Copy code
lib/
├── Constants/
├── Models/
├── Pages/
├── Providers/
└── main.dart
Constants: Contains app-wide constants.
Models: Defines the data models used in the app.
Pages: UI pages like HomePage, NewsDetailPage, etc.
Providers: Contains the state management logic using the Provider package.
Usage
Pull Down to Refresh: Swipe down on the home screen to refresh the news articles.
Category Filter: Use the horizontal scroll list to filter articles by categories.
Open File: Tap on an image to view it or play a video.
How to Contribute
Feel free to fork this project and submit pull requests. For major changes, please open an issue first to discuss what you would like to change.

License
This project is licensed under the MIT License - see the LICENSE file for details.
