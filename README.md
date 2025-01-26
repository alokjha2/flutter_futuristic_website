# Flutter Futuristic Website Components

## Table of Contents

1. [Flutter History and Levels](#flutter-history-and-levels)
2. [Story Behind This Project](#story-behind-this-project)
3. [Getting Started](#getting-started)
4. [Prerequisites](#prerequisites)
5. [Steps to Run the Project](#steps-to-run-the-project)
6. [Components](#components)
7. [Ending Note](#ending-note)

## Table of Contents (of Components)
1. [Component Demo Video]()
2. [How to Use]()
3. [Inspiration]()

### Flutter history and Levels 
Taking flutter to the next level. Flutter levels till now: 
- Level first - when google launched flutter. Packages like splash screen, widgets related came into existence
- Level two - Provider, riverpod, dio related packages which helped developers in state management and making flutter app work with external tools 
- Level three - basic animations packages came into existence
- Level four - we are leading this level by building futuristic animations in flutter. 



### Story behind this project 
So I saw few websites and I was stunned to look them. But then I found out none of them was made in flutter. 
Some was made in framer, some was in react and other but not in flutter. Reason its easy to build in those frameworks. 
So I thought lets build a library or github repo of all the components that developers can use in their project so this was the begining of flutter_futuristic_website

Checkout this website - https://www.jack-lee.xyz/

First thing that came into my mind was Wow! what a great website. Animation, design, feel. It's a lit. So I thought let's make something that people can use and say same when they see flutter website made using flutter futuristic components. 



## Getting Started

To get started with this project, follow the instructions below:


### Prerequisites:
- Flutter installed on your system.
- A code editor (VS Code, etc.).
- A web browser for viewing the application.

### Steps to Run the Project:

1. Clone the repository:
   ```bash
   git clone https://github.com/alokjha2/flutter_futuristic_website


### Components:


1. Globe Animation
- Component demo usage Video:

https://github.com/user-attachments/assets/b86f7dde-a3c8-47c6-899e-5741861261a8

- How to Use: 
Replace body of main.dart with the code given below

```bash
 body: SafeArea(
   child: _globeController.buildGlobe()),
```

- Inspiration: 
https://www.webglearth.com/#ll=22.54467,166.52333;alt=16971451;h=-0.003


2. Full Screen Mode
- Component demo usage Video:

https://github.com/user-attachments/assets/07ad1123-8a16-4306-818d-00c031dc3c93

- How to Use: 
Replace body of main.dart with the code given below 

```bash
  body: SafeArea(
   child: FullScreenIcon()),
```

- Inspiration: 
https://www.fyxer.com/

3. Scroll Progress Indicator
- Component demo usage Video:

https://github.com/user-attachments/assets/5b210fab-9e15-4477-bd18-2c8227849e60

- How to Use: 
Replace body of main.dart with the code given below 

```bash
    SafeArea(
      child: ScrollProgressIndicator()),
```

- Inspiration: 



4. Custom Cursor with ToolTip
- Component demo usage Video:

https://github.com/user-attachments/assets/09b6b95c-7638-41b4-8bd4-3d61296b38c3

- How to Use: 
Replace body of main.dart with the code given below 

```bash
   body: SafeArea(
      child: CustomCursorContainer()),
```

- Inspiration: 
https://www.tempolabs.ai/



### Ending Note:

# Project related information
1. If you want to add or suggest new component then follow this procedure - 
- Open component branch 
- Go to components folder => animations & then create a folder in it
- Follow snake_case format
- Once component is added in local folder. Open readme and create component in component section. Use this format

``` bash
4. Custom Cursor with ToolTip
- Component demo usage Video:

https://github.com/user-attachments/assets/09b6b95c-7638-41b4-8bd4-3d61296b38c3

- How to Use: 
Replace body of main.dart with the code given below 

   ``` bash
   body: SafeArea(
      child: CustomCursorContainer()),
      ```


- Inspiration: 
https://www.tempolabs.ai/

```
- Once done. Open pull request in component branch. Take reference from other pull requests

2. Commit statements guideline : 
- Bug Fixes
Commit Statement: fix: resolve issue with user login

- Feature Added
Commit Statement: feat: add user profile page

- Refactoring Existing Code
Commit Statement: refactor: simplify user authentication logic

- Updating Documentation
Commit Statement: docs: update README with installation instructions

- Performance Improvements
Commit Statement: perf: optimize image loading for faster rendering

- Chore (Non-Feature Changes)
Commit Statement: chore: update dependencies to latest versions


# Personal Information
1. Check out - https://pub.dev/packages/peckish_animated_hand_tutorial  
2. Check out - [peckishhuman.com](https://peckishhuman.com/)
3. Follow peckishhuman across all social media (especially on X) - https://x.com/peckishhuman















