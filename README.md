<h1 align="center"> Climate Care 🍀</h1>

Climate Care is a mobile application that aims to provide a solution to climate change. It offers various tools to its users to help them make a positive impact on the environment. In return, users can earn points that can be redeemed for exclusive coupons from different brands.

## App Sections
1. 🌿 Onboarding 
2. 🌿 Login/Signup 
3. 🌿 Home Screen 
4. 🌿 Plant Growth Tracker
5. 🌿 Waste Reduction Tool (Artificial Intelligence)
6. 🌿 Sustainable Shopping Assistant (Artificial Intelligence)
7. 🌿 Progress Screen
8. 🌿 Social Community Page
9. 🌿 Settings

## Prerequisites

To run this app, you need to have Flutter installed on your system. If you don't have Flutter installed, you can follow the [official documentation](https://flutter.dev/docs/get-started/install) to install it.

## How to Run the App

<h4>First of all you'll need to have an API from OpenAI, for that just follow the following steps:</h4>
1. Jump on to [Open AI Platform](https://platform.openai.com) 
![Screenshot (27)](https://user-images.githubusercontent.com/106861398/229074622-f9639949-5ad2-44ec-bb18-ad0a6d48b306.png)
2. Login or Signup using your credientials
3. Tap on Personal on the top right corner and go to "View API Keys"
 ![Screenshot (28)](https://user-images.githubusercontent.com/106861398/229075508-7b9203af-ccf7-4dd3-a87b-1b3da508bfe9.png)
4. Tap on the button that says "+ Creat new secret key" to create your API key
![Screenshot (29)](https://user-images.githubusercontent.com/106861398/229076416-7220a8df-40e9-4143-805a-36266a2a3dd3.png)
5. Copy Your API key
![Screenshot (30)](https://user-images.githubusercontent.com/106861398/229077116-a294fc16-910e-4df1-99fe-b7bd8e57d1b6.png)
6. Paste the key in to the string value of OPEN_AI_KEY variable in the headers.dart file. The address of the file is Climate-Care\lib\Artificial Inteligence\common\headers.dart
![Screenshot (31)](https://user-images.githubusercontent.com/106861398/229078494-37f1a0d1-c8be-4cde-93b8-9b2fd325d508.png)
7. Now run the app :)

<h4>To run this app on your system, follow these steps:</h4>

1. Clone this repository to your local machine.
2. Open the terminal and navigate to the project directory.
3. Run `flutter pub get` to install the required packages.
4. Connect your mobile device or start an emulator.
5. Run `flutter run` to start the app.

That's it! You should now be able to run the Climate Care app on your device.

## Built With

* Flutter ([https://flutter.dev/](https://flutter.dev/)) - The frontend framework used
* Firebase Auth([https://firebase.google.com/docs/auth](https://firebase.google.com/docs/auth)) - The Firebase service used for authenticating users
* Fiirebase Cloud Firestore([https://firebase.google.com/products/firestore](https://firebase.google.com/products/firestore?gclid=CjwKCAjw_YShBhAiEiwAMomsEAJh_XIisUnhrUWi29MhxQDMkGo-VAWPxTUFpdTJXu-yOAQ6bU28ZxoCIKsQAvD_BwE&gclsrc=aw.ds)) - The Firebase service to store data
* Fiirebase Cloud Storage([https://firebase.google.com/docs/storage](https://firebase.google.com/docs/storage)) - The Firebase service used to save image files on cloud
* Google Maps Platform ([https://mapsplatform.google.com/](https://mapsplatform.google.com/)) - The Google Maps platform api used to show places and map in the app


## Facing an issue while running the app

Get in touch with us.
* [abdullahayaz529@gmail.com](mailto:abdullahayaz529@gmail.com)
* [alirazamunir2003@gmail.com](mailto:alirazamunir2003@gmail.com) 

#### Install the apk of the app
[Download APK](https://drive.google.com/file/d/1vBR7XVcAlyb9yAR5f2doZCVuH3cGDTM5/view?usp=share_link)
