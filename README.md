# NewsFeed SwiftUI

A news application built using **SwiftUI** with the **MVVM architecture**. The app fetches news articles from a REST API, displays them in a scrollable news feed, supports article search, and loads article images asynchronously.

## Features

- Fetches news articles from a REST API
- Displays articles using SwiftUI
- Search articles by title
- Asynchronous networking using `async/await`
- Asynchronous image loading using `AsyncImage`
- MVVM architecture
- Protocol-based dependency injection
- Observable ViewModel using `@Observable`
- SwiftUI Environment for sharing the ViewModel
- Reusable news cell components
- Placeholder image handling for missing or failed images

## Architecture

The project follows the **MVVM architecture** to separate UI, business logic, and networking responsibilities.

```text
View
  ↓
ViewModel
  ↓
Network Manager
  ↓
REST API
```

The ViewModel conforms to `NewsViewModelProtocol`, allowing the UI and business logic to remain loosely coupled.

## SwiftUI Concepts Used

- `@Observable`
- `@State`
- `@Binding`
- `@Environment`
- `.task`
- `.onChange`
- `AsyncImage`
- `ForEach`
- `Identifiable`

## Search

Search logic is handled by the ViewModel. As the search text changes, articles are filtered by title using case-insensitive matching.

## Tech Stack

- Swift
- SwiftUI
- Swift Concurrency
- REST API
- MVVM
- Xcode
