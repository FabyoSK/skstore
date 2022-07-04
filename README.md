## Overview
This app is build using Flutter, it uses Flutter's built in State Manager

The folder structure of this app is divided in two main parts.
- `modules` - All pages
- `shared` - All shared widgets, controllers, styles, typography, etc


I used Flutter's built in State to keep the application simple and light, some pages has controllers to manage API requests. User info and shopping cart are shared globally in the app, shopping cart is store on SharedPreferences as well, to keep the user cart between sessions


Features:

- Filter products
- Login
- Register
- Add to Shopping Cart
- Orders page

## Run the App
To run the App you must simply run the following command
```bash
flutter run -d chrome --web-renderer html
``` 