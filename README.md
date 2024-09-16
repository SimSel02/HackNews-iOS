# HackNews
Hacker News Client for IOS using SwiftUI, MVVM and SwiftData

<img width="1264" alt="Screenshot 2024-09-16 at 10 26 03" src="https://github.com/user-attachments/assets/837e9127-4841-482e-a8ef-67c2f7fc3f73">



## Features
Story List Screen:
- **hostDomain** and **favicon** are shown for each story
- An **animated loading screen** is provided when loading new stories
- **Pull to refresh** waits for it’s animation to finish before refreshing the data (preventing ui glitchs)
- When an error occurs an alert with a **custom** localizedDescription is provided to the user along a refresh button
- **System Disclosure Indicator** is replaced with a custom one better implemented in UI design

Story Detail Screen:
- **Go to website** button is shown only if the story has a url ("ask stories" don't have a url and don't need this button)
- **SafariViewController** used to open website’s urls
- **Comments** and **Replies** are enclosed in a custom ui showing author’s name and date of publication
- Comments are formetted from HTML to Plain Text (code has been found online)

FavouriteListView:
- **ContentUnavailableView** used to avoid to show the user an empty view

NetworkManager:
- Public functions are **documented** providing a description for the **function** itself, its **parameters**, **return** type and **errors** thrown
- Functions not meant to be used outside the class are marked as **private** 
- **withThrowingTaskGroup** is used to fetch multiple stories at once reducing the fetching time of a considerable amount
- Basic **Unit Tests** are performed to ensure functionality

Other:
- **PreviewData** has been created to provide data for Xcode Previews
- **SFSymbol** are used to make UI easy to read
- **SwiftData** manages the favourite list
- Both **Light and Dark** mode are supported and taken in consideration during the development
- **App Icon** and Display name provided
- **OS_Log** is used to display messages in the console

# Creative Process
## Project Brief
Write a simple application that shows lists of hacker news (https://news.ycombinator.com)
news, tops and best stories.

Pay attention to write good code and to solve the problem in the cleanest way possible. You can
use all the libraries you need.
For submission you have to deliver us the full git repository with the project you are working on
(as a .zip file or giving us access to a private github/gitlab repo).

## Requirements
- Show the 3 different lists (news, tops and best stories)
- Has pull to refresh in the list
- Displays all available story data
- Show story on cell selection
- Manage a list of preferred stories

## Getting to know the api
- Base Url: https://hacker-news.firebaseio.com/v0
- List request: /listname.json
- Item request: /item/id.json
- Time is represented using Unix time.
- Comments text is in the HTML format
- Requesting a list return the ids, other request are needed to fetch stories data.

**Story data:**
- by
- descendants (number of comments + replies)
- id
- kids (comments)
- time
- title
- type
- url

**Comment Data**
- by
- id
- kids (replies)
- parent (story or comment)
- text
- time
- type

## User Workflow
<img width="776" alt="Screenshot 2024-09-16 at 10 24 06" src="https://github.com/user-attachments/assets/4e0aeade-8011-45c9-add3-e929865278cd">


## UX Prototype
![UXXPrototype](https://github.com/user-attachments/assets/d9b5720d-26c2-4493-b801-8049b42d58fd)



## UIPrototype
<img width="717" alt="Screenshot 2024-09-16 at 10 24 50" src="https://github.com/user-attachments/assets/273c730b-650d-437b-92f9-d497d893f608">

