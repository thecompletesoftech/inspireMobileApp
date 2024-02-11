# iNSPIRE-Public-Housing
iNSPIRE Mobile App to assist Inspectors to perform Inspections on Public Housing units

# Widgets
all these are comman widget to use every screen
path : project name/lib/commons.

1. **(MyTextView) filename : ̰mytext_widgets.dart** For any Text  use this widget in any screen.

2. **(CommonTextField) filename : textfeild_widgets.dart**  For use any TextBox in screen use this custome widget.

3. **(BaseScreen) filename : base_widgets.dart** In every screen we are using  BaseScreen widget which is Contain Scaffold ,floating button and bottom navigation bar.

4. **(ShadowContainer) filename : shadowcontainer_widgets.dart**  
For use shadow in any container.

5. **(Appbar) filename: common_appbar_widget** For Appbar use this widget.

6. **(Button) filename: button_widget** To create button use this widget.

7. **(Button with Icon) filename: iconbutton_widget** To create button with and icon use this file.

# Constant Files

1. **(String) filename: string.dart** This file contain all strings of an app.

2. **(SvgImage) filename: svgimage.dart** This file contain all svg images of an app.

3. **(Utils) filename: utils.datt** This file contain all validation functions, responsive size functions and device orientation css according to device orientation.

4. **(ImagePath) filename: imagepath.dart** This file contain all images path of an app.

5. **(Color)filename: appcolors.dart** This File contain all the colors code of an app.

6. **(Constants) filename: constants.dart** This File contain base urls and endpoint of an apis.

# StateManagement(GetX)

**For new screen you have to create these files**

1. **Create Screen**
2. **Create controller of that screen** 
3. **(Binding)** Bind the controller of that screen and use that binding file on routes.

**(Routes) filename: app_pages.dart** This file contains all the routes of all screens, when you create any screen you have to add that screen in routes to manage route flow.


**(Project Manage) Branch name: brachreponame_trelloIDno** If in sigle trello board have multiple taske please create each seprate .

**Mention Git Head** please metion git head in trello and branch name To-track branches by given task .

This app use flutter version 3.16.3