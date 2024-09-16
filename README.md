# HackNews
Hacker News Client for IOS using SwiftUI, MVVM and SwiftData
 
<img width="1226" alt="Screenshot 2024-09-16 at 10 14 32" src="https://github.com/user-attachments/assets/ed997d43-5798-460f-8776-7897b9e50d10">


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
Base Url: https://hacker-news.firebaseio.com/v0
List request: /listname.json
Item request: /item/id.json
Time is represented using Unix time.
Text is in the HTML format
Requesting a list return the ids, other request are needed to fetch stories data.

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
<img width="775" alt="Screenshot 2024-09-13 at 18 21 25" src="https://github.com/user-attachments/assets/d9d7f35e-6f73-43ea-9e26-771ff2fc79fb">

## UX Prototype
<img width="544" alt="Screenshot 2024-09-13 at 18 21 59" src="https://github.com/user-attachments/assets/840625b1-1d55-447d-8001-f7e63b7335aa">


## UIPrototype
<img width="772" alt="Screenshot 2024-09-13 at 18 23 27" src="https://github.com/user-attachments/assets/9f65e165-af94-432c-b174-93299982e11d">
