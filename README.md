# ayna_task

My Gateway to Ayna AI

## More Details

This a Flutter Web Application I have developed recently to deal with web sockets & local noSQL DBs like Hive.


- [ Application Link ( deployed on Firebase )](https://ayna-assignment-auro.web.app/)
- [ Backup Link ( Github Pages )](https://auro-dev.github.io/)


## Key Points
- The application uses Bloc for managing states and separates business logic from the Presentation layer.
- It uses a local db Hive to perform mock user authentication ( works like indexed DB local to the browser ) & also to store the chats locally/cache type of system. With a simple yet good data model, created 2 collections ( Users & Chats ). Passwords stored are hashed using bcrypt salt. For mongo DB like obj id creation I have used a package bson to generate unique Ids.
- For Routing I have used go_router package ( although I'm a fan of GetX ), but was trying the flutter web first time, so just went with the recommended router package.
- For small minor animations, I've used lottie ( preloaded assets for optimization ).
- Used SharedPreference for storing user session and managing LoggedIn and LoggedOut states.






Login with email & password :



Chat With Web Socket Echo Server:

<video src="https://github.com/anon-000/ayna-task/assets/52295426/ea15106f-0ad7-4ba6-bc39-bdb5353fbbec"></video>







For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
