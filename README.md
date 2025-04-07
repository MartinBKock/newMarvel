#  setup

1.  When setting up the project, import the packages that are needed.
    for most project that would be from the list below

- KingFisher - https://github.com/onevcat/Kingfisher

2.  After that change the name of the project to whatever it should be

3.  If Firebase is to be used, setup in app like this:

    ```
    uncomment Firebase.configure in AppDelegate
    ```
    and import the google plist file that you will create at the firebase website
    
4. If Firebase Messeging is to be used.
    ```
    uncomment it in AppDelegate
    ```

5. In terminal run the command: git flow init -d 
    this is to initialize git flow for the project

6. Setup Fastlane - Go to Appfile & Fastfile to updatae bundleID and xcodeProj name