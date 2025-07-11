# VH Interface

A Flutter package that provides common interfaces and utilities to avoid dependency conflicts across different packages.

## Purpose

This library serves as a shared interface layer that helps prevent dependency conflicts when using multiple packages that might have overlapping functionality. By defining common interfaces, different implementations can coexist without conflicts.

## Features

- **NetworkException**: Common interface for network error handling
- **Result**: Functional error handling pattern for consistent API responses
- **Dependency Isolation**: Prevents conflicts between different network/utility packages
- **Type Safety**: Strongly typed interfaces for better development experience

## Getting started

Add this to your package's `pubspec.yaml`:

```yaml
dependencies:
  vh_interface: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Usage

### Result Pattern
Use the Result type for functional error handling:

```dart
import 'package:vh_interface/vh_interface.dart';

// Function that returns a Result
Result<String, NetworkException> fetchData() {
  try {
    // Your network call here
    return Result.success("Data fetched successfully");
  } catch (e) {
    return Result.failure(NetworkException.connectionError());
  }
}

// Using the result
final result = fetchData();
result.when(
  success: (data) => print("Success: $data"),
  failure: (error) => print("Error: ${error.message}"),
);
```

### Network Exception Handling
Handle network errors consistently:

```dart
import 'package:vh_interface/vh_interface.dart';

try {
  // Your network operation
} catch (e) {
  final networkError = NetworkException.fromException(e);
  
  switch (networkError.type) {
    case NetworkExceptionType.connectionTimeout:
      // Handle timeout
      break;
    case NetworkExceptionType.noInternet:
      // Handle no internet
      break;
    // ... other cases
  }
}
```

## Architecture Benefits

- **Clean Dependencies**: Other packages can depend on this interface without importing heavy implementations
- **Interoperability**: Different HTTP clients (dio, http, etc.) can implement the same interfaces
- **Testing**: Easy to mock interfaces for unit testing
- **Maintainability**: Changes to implementations don't affect interface consumers

## Additional information

This package is designed to be lightweight and focused on interface definitions. For complete implementations, check out companion packages that implement these interfaces.

**Contributing**: Issues and pull requests are welcome on [GitHub](https://github.com/your-repo/vh_interface).

**License**: MIT
