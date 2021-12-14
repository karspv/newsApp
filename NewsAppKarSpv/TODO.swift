/*
    [ETA]

     [REFACTOR 1 - SOLO - Separate Branch]
        - Refactor the Articledetails screen to use a tableview with section logic
 */

/*
 - Coding advice: "Review your code thinking the person coming after you is a psychopath who knows where you live"
 - THIS INCLUDES YOUR COMMIT HISTORY.
        - ONLY ONE FEATURE SHOULD BE WORKED ON IN ONE COMMIT

 - When tackling a problem or feature, consider more than one possible solutions, don't stare blindly at your existing path
 - Don't be afraid to revisit your original solution if new functionality is added on top
 - Don't get caught in coupled naming. Treat every element that you create as it's own thing and be critical what it's actually used for
    (eg a tableViewCell that displays any title is a TitleTableViewCell, with no link to business)

 Principles to keep in mind
 - [DRY] Do not repeate yourself: both literal code and functionality
 - [KISS] Keep It Stupid and Simple. More complicated code also means harder to read and understand for other coders
 - [SOLID]
        - S - Single Responsibility - There should never be more than one reason for a class to change
        - O - Open - Closed principle - Entities should be open to extension, but closed for modification
        - L - Liskov Substitution - Behaviour of base classes should be valid for all overriding classes
        - I - Interface segregation - Interfaces should be specific to who uses them, not one giant generic interface
        - D - Dependency Inversion - Depend on interfaces, not on other classes directly
 */

/*
    How to go about creating a new feature:
    - Identify what is business logic and what is display logic (UX vs UI)
    - What is the data that is used vs just UI elements (title vs map Pins, articles, etc...)
    - Which data entities can you create out of the needed data.
    - How to get that data into the controller
 */

/*
 [FUTURE TASKS]
 [REFACTOR 2 - SOLO - Separate Branch]
    - Refactor your application so it works with Storyboards

 [LECTURES - COOP]
    - Using XCode instruments to debug and track down memory leaks
    - Commonly used tools for iOS development
    - Device Settings to help debug live scenarios
    - How to do estimations and what to look out for
    - General professional behaviour in projects

 [RxSwift - SOLO/COOP]

 [THE END]
 */
