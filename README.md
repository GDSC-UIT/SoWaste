# Sowaste

```
Using
    - MVVM Architecture
    - GetX for state management
```

# FILE STRUCTURE

**assets : contains all the static assets that are used in the application**

- logo
- icons
- images
- fonts

**lib**

- core
  - themes : eg- define TextTheme, TextStyle...
  - utils : static method
  - values :
    - app_assets: contains paths for different images, icons.
    - app_string: contains strings used across entire application .
    - app_colors: initialize the different color variations.
  - data
    - models : saves the data and associated logic.
    - services : eg- contains api services : authentication , fetch data...
  - global_widgets
- **modules**
  - <module_name>
    - _<module_name>\_binding.dart_ : provide dependencies - controller...
    - _<module_name>\_controller.dart_ : executes the commands and data linked to the View(s)
    - widgets: local widgets
    - screens
- routes
  - _app_pages.dart_
  - _app_routes.dart_
- **_main.dart_**
