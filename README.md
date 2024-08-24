# Rick and Morty Characters iOS App
Project Description
This iOS application interacts with the Rick and Morty API to fetch and display a paginated list of characters, with 20 characters loaded per page. Users can filter the characters by status (Alive, Dead, Unknown) and view detailed information about each character. The app uses UIKit for the table view and SwiftUI for smaller views, demonstrating modern design patterns and good coding practices.

**Requirements**

**Screen 1: Character List**
Displays a list of characters with pagination (20 characters per page).
Each character cell includes:
Name
Image
Species
Users can filter the list by character status: Alive, Dead, or Unknown.


**Screen 2: Character Details**


Displays detailed information for a selected character:
Name
Image
Species
Status
Gender

**Installation Instructions**
Prerequisites
- Ensure you have Xcode 12.0 or later installed.
- Steps to Build and Run the Application
- Clone the repository:
bash
- Copy code
- git clone <[repository_url](https://github.com/Arusey/Rick-and-Morty-App)>

***Open the project in Xcode:*
**
- Navigate to the project directory and open the .xcodeproj file.
- Build the project:
- Select a simulator or a connected device and press the build button in Xcode.
- Run the application:
- After building, click run to start the app on the chosen simulator or device.

  
**Assumptions and Decisions**

- Pagination: Loads 20 characters at a time to optimize performance and reduce memory usage.
- Error Handling: Implemented to manage potential network issues or empty API responses.


**Challenges Encountered and Solutions**

- Pagination Implementation: Implementing smooth pagination required careful tracking of the table view's scroll position. This was solved by pre-loading the next set of characters before reaching the end of the current list.
- UIKit and SwiftUI Integration: Balancing UIKit and SwiftUI within the same project presented data flow challenges. By using the MVVM architecture, data was efficiently shared between the two frameworks.

**Testing**

- Unit Tests: Tests are included for the ViewModel, which handles data retrieval and parsing, ensuring that API responses are processed and filtered correctly.
Submission
- The complete source code is available on the public GitHub repository. Feel free to explore and evaluate the solution.

Good luck and thank you for your time!
