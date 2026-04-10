# Fuji Maintenance System - Project Context

## Project Overview
The Fuji Maintenance System is a Flutter-based maintenance management application designed with three distinct user interfaces: Admin, Technician, and Client. The system provides comprehensive maintenance management capabilities including work order management, scheduling, reporting, and user management.

**Project Name:** fuji_maintenance_system  
**Description:** A Flutter maintenance system with three user interfaces: maintenance man, admin, and user  
**Version:** 1.0.0+1  
**SDK:** Dart 3.7.0+ (compatible up to <4.0.0)

## API Integration Status
The project is currently in the process of integrating with the Fuji Maintenance Backend API. The API documentation is available in `API_DOCUMENTATION (.md` and includes:

### Implemented API Features
- ✅ Authentication system with Laravel Sanctum
- ✅ Login for all user types (Admin, Technician, Client)
- ✅ Technician registration
- ✅ User profile management
- ✅ Token-based authentication with automatic header injection
- ✅ Comprehensive error handling (NetworkFailure, AuthFailure, ServerFailure, etc.)
- ✅ Repository pattern with Either types for error handling
- ✅ Riverpod state management for authentication
- ✅ Admin management endpoints (contract sections, durations, elevator types/models)

### Pending API Integration
- ⏳ Client-specific endpoints
- ⏳ Technician-specific endpoints  
- ⏳ Shared Admin/Technician endpoints
- ⏳ File upload endpoints
- ⏳ Real-time notifications
- ⏳ Maintenance scheduling endpoints
- ⏳ Reporting and analytics endpoints

### API Base Configuration
- **Base URL:** `https://maintenance.fujijapanelevators.com/` (configured in `lib/config/api_path.dart`)
- **Authentication:** Bearer token (Laravel Sanctum)
- **Response Format:** Consistent JSON with `success`, `message`, and `data` fields
- **Error Handling:** Comprehensive error handling with specific failure types

## Directory Structure
```
fuji_maintenance_system/
├── .dart_tool/                # Dart build tools directory
├── android/                   # Android platform-specific files
├── assets/                    # Application assets
│   └── base/
├── build/                     # Build output directory
├── ios/                       # iOS platform-specific files
├── lib/                       # Main application source code
│   ├── config/                # App configuration
│   ├── core/                  # Core application logic
│   ├── shared/                # Shared components and features
│   ├── helper/                # Helper functions
│   ├── interfaces/            # Interface-specific code (new structure)
│   ├── models/                # Data models
│   ├── modules/               # Feature modules
│   ├── packages/              # Reusable packages
│   ├── providers/             # State management providers
│   ├── shared/                # Shared components
│   ├── ui/                    # Legacy UI components
│   ├── main.dart              # Application entry point
│   └── setup_services.dart    # Service initialization
├── linux/                     # Linux platform-specific files
├── macos/                     # macOS platform-specific files
├── test/                      # Test files
├── web/                       # Web platform-specific files
├── windows/                   # Windows platform-specific files
├── ARCHITECTURE.md           # Architecture documentation
├── README.md                 # Basic project documentation
├── analysis_options.yaml     # Dart/Flutter analysis options
├── devtools_options.yaml     # DevTools configuration
├── flutter_01.log           # Flutter log file
├── fuji_maintenance_system.iml # IntelliJ IDEA module file
├── pubspec.yaml             # Project dependencies and configuration
└── .gitignore               # Git ignore rules
```

## Key Dependencies and Technologies

### State Management & Architecture
- `flutter_riverpod: ^2.6.1` - Modern state management solution
- `get: ^4.7.2` - Dependency injection and navigation
- `get_it: ^8.0.2` - Service locator
- `provider: ^6.1.5` - Inherited Widget replacement
- `fpdart: 1.1.1` - Functional programming utilities for Either types

### UI & Responsive Design
- `flutter_screenutil: 5.9.3` - Screen adaptation utilities
- `flex_color_scheme: ^8.2.0` - Material color theming
- `google_fonts: 6.2.1` - Google Fonts integration
- `flutter_svg: ^2.0.17` - SVG image support

### Networking & API
- `dio: ^5.7.0` - HTTP client with advanced features (primary API client)
- `http: ^1.3.0` - Basic HTTP client (backup)
- `connectivity_plus: ^6.1.3` - Network connectivity detection
- `logger: 2.5.0` - Logging solution for API calls and debugging

### Local Storage
- `hive: ^2.2.3` - NoSQL database solution
- `hive_flutter: ^1.1.0` - Hive Flutter extensions
- `get_storage: 2.1.1` - Simple key-value storage

### UI Components & Animations
- `go_router: ^14.3.0` - Navigation solution
- `lottie: ^3.3.0` - Lottie animations
- `carousel_slider: 5.0.0` - Carousel widget

### Forms & Validation
- `reactive_forms: ^18.0.0` - Reactive forms implementation

### Other Libraries
- `intl: ^0.20.2` - Internationalization support
- `image_picker: ^1.0.7` - Image selection from gallery/camera
- `image_cropper: ^8.0.2` - Image cropping functionality
- `path_provider: ^2.1.2` - File system path utilities

## Architecture & Design Patterns

### Multi-Interface Architecture
The application separates code into distinct interfaces for each user type:

1. **Admin Interface** (`/interfaces/admin/`)
   - Purpose: Administrative control and system management
   - Key Features: User management, system reports, work order oversight, technician management
   - Route Prefix: `/admin/`

2. **Technician Interface** (`/interfaces/technician/`)
   - Purpose: Field work and task management
   - Key Features: Work order management, schedule viewing, task reporting, equipment tracking
   - Route Prefix: `/technician/`

3. **Client Interface** (`/interfaces/client/`)
   - Purpose: Service requests and status tracking
   - Key Features: Maintenance request creation, request status tracking, service history, support communication
   - Route Prefix: `/client/`

### Core Architecture Components

#### Core Directory Structure
- `core/enum/` - Application enums (Language, UserType)
- `core/errors/` - Error handling (Failure types, ServerFailure, NetworkFailure, etc.)
- `core/extensions/` - Dart extensions (AsyncValueUI, UserType extensions)
- `core/guards/` - Route guards and middleware (AuthGuard for route protection)
- `core/router/` - Navigation and routing (GoRouter configuration)
- `core/service/` - Core services (ApiService, AuthService, LocalDataManager, etc.)
- `core/use_cases/` - Business logic use cases (Clean Architecture pattern)
- `core/routing/` - Route definitions and configuration

#### Shared Components
- `shared/models/` - Data models (User, WorkOrderItem, MaintenanceRequest, Equipment, Technician)
- `shared/services/` - Shared business services (AuthService, AdminService)
- `shared/widgets/` - Reusable UI components (CustomDashboardAppBar, DashboardCard, WorkOrderCard, RequestCard)
- `shared/utils/` - Utility functions
- `shared/constants/` - App constants
- `shared/features/` - Shared features (authentication, etc.)

#### Configuration
- `config/` - App configuration, assets, colors, themes, etc.

## Key Files and Components

### Application Entry Point (`lib/main.dart`)
- Initializes services using GetIt dependency injection container
- Sets up Riverpod provider container
- Configures MaterialApp with routing and theming
- Implements offline connectivity handling
- Uses FlexColorScheme for theming with Cairo font

### Service Setup (`lib/setup_services.dart`)
- Database initialization (Hive with multiple boxes for different data types)
- Network service (ApiService with Dio) initialization
- Localization service setup with language support
- Image picker service registration with cropping capabilities
- Local data manager (GetStorage) for key-value storage
- Service locator pattern using GetIt for dependency injection

### Routing System (`lib/core/routing/`)
- Uses GoRouter for navigation
- Implements authentication guards
- Role-based route protection
- Interface-specific routing with ShellRoute for each user type

### Authentication System
- **AuthService:** Manages user authentication state with API integration
- **AuthRepository:** Clean architecture repository for authentication operations
- **AuthRepositoryImpl:** Implementation using DioHelper and API endpoints
- **LoginController:** Riverpod state management for login flow
- **AuthGuard:** Protects routes based on authentication and user type
- **AppRoutes:** Contains all route definitions with interface-specific prefixes
- **LocalDataManager:** Handles token storage and user data persistence
- **Splash Screen:** Validates token on app start and redirects appropriately
- Supports three user types: admin, technician, client
- Token-based authentication with Laravel Sanctum integration
- Automatic token validation and session management

### Data Models
- **User:** Authentication and profile management (with JSON serialization)
- **WorkOrderItem:** Technician work orders (with status, priority, assignment)
- **MaintenanceRequest:** Client requests (with images, technician assignment)
- **Equipment:** Equipment management (with maintenance scheduling)
- **Technician:** Technician profiles (with specialties and availability)
- **UserEntity:** Clean architecture entity for authentication domain
- **AuthResponseEntity:** API response wrapper for authentication

## User Types and Permissions

### UserType Enum
```dart
enum UserType {
  admin('admin', 'مدير'),
  technician('technician', 'فني'),
  client('client', 'عميل');
}
```

### Permission System
- **Admin:** Has all permissions
- **Technician:** Permissions include view_work_orders, update_work_orders, view_schedule, update_profile
- **Client:** Permissions include create_requests, view_requests, view_history, update_profile

## Key Features

### Admin Features
- Dashboard with statistics and quick actions
- User management
- Work order oversight
- Technician management
- Reporting system

### Technician Features
- Work order management
- Schedule viewing
- Task reporting
- Equipment tracking
- Profile management

### Client Features
- Maintenance request creation
- Request status tracking
- Service history
- Support communication
- Profile management

## Configuration Files

### pubspec.yaml
- Defines project dependencies and assets
- Configures app name, version, and description
- Sets up custom fonts (Cairo font family)
- Defines app icon assets

### analysis_options.yaml
- Uses flutter_lints for code quality
- Custom analyzer settings
- Lint rules configuration

### ARCHITECTURE.md
- Detailed architecture documentation
- Migration strategy from old to new structure
- Development guidelines and conventions
- File naming conventions

## Development Guidelines

### File Naming Conventions
- Use snake_case for file names
- Suffix screen files with `_screen.dart`
- Suffix controller files with `_controller.dart`
- Suffix model files with `_model.dart`

### Import Organization
1. Flutter imports
2. Third-party imports
3. Local imports

### Code Organization Pattern
1. Constructor and properties
2. Build method and UI
3. Helper methods (private)
4. Event handlers
5. Utility methods

## Current Status
The project has successfully migrated from a legacy feature-based structure to a clean interface-based architecture that separates code by user type. The structure consolidation is complete, with all files properly organized in their respective interface directories.

### Development Phases
1. **Phase 1: Foundation** ✅ Completed
   - Project structure setup
   - Core services implementation
   - Basic authentication system
   - Interface separation architecture

2. **Phase 2: Structure Consolidation** ✅ Completed
   - Migrated from legacy features/ to interfaces/ structure
   - Consolidated authentication to shared/features/auth/
   - Moved customer screens to interfaces/client/
   - Moved technician screens to interfaces/technician/
   - Updated routing and imports

3. **Phase 3: API Integration** ✅ Completed
   - ✅ Backend API integration with DioHelper
   - ✅ Authentication API (Login for all user types)
   - ✅ Data model alignment with API (UserModel, AuthResponseModel)
   - ✅ Service layer implementation (AuthService, AuthRepository)
   - ✅ Error handling and response mapping (Either types with fpdart)
   - ✅ Login controller with Riverpod state management

4. **Phase 4: Interface Implementation** ⏳ Pending
   - Admin interface features
   - Technician interface features
   - Client interface features
   - Real-time updates and notifications

5. **Phase 5: Advanced Features** ⏳ Pending
   - File upload and management
   - Offline capabilities
   - Advanced reporting
   - Performance optimization

## Testing
The project includes a basic widget test (`test/widget_test.dart`) that verifies the counter functionality.

## Internationalization
The application supports internationalization with locale handling and uses Arabic as one of the languages, with the Cairo font family configured for Arabic text support.

## API Integration Details

### Current API Service Implementation
The project uses a comprehensive API service built on Dio with the following features:

#### ApiService (`lib/core/service/webservice/dio_helper.dart`)
- **HTTP Methods:** GET, POST, PUT, PATCH, DELETE, DOWNLOAD
- **Authentication:** Automatic Bearer token injection
- **Error Handling:** Comprehensive error handling with specific failure types
- **Timeout Management:** Configurable connection, send, and receive timeouts
- **Logging:** Request/response logging for debugging
- **File Upload:** Support for file uploads with progress tracking
- **Response Processing:** Automatic JSON parsing with data extraction

#### Error Handling System
- **ServerFailure:** HTTP server errors (4xx, 5xx)
- **NetworkFailure:** Network connectivity issues
- **AuthFailure:** Authentication and authorization errors
- **TimeoutFailure:** Request timeout errors
- **ValidationFailure:** Input validation errors
- **CacheFailure:** Local storage errors
- **UnknownFailure:** Unhandled errors

#### API Configuration
- **Base URL:** `https://maintenance.fujijapanelevators.com/` (configured in `lib/config/api_path.dart`)
- **Headers:** Automatic language, content-type, and authorization headers
- **Interceptors:** Request/response interceptors for logging and error handling
- **Certificate Handling:** SSL certificate validation (configurable for development)

### API Endpoints Structure
Based on the API documentation, the following endpoint categories are available:

#### Authentication Endpoints
- `POST /api/login` - User authentication
- `POST /api/register/technician` - Technician registration
- `POST /api/logout` - User logout
- `GET /api/profile` - Get user profile
- `PUT /api/profile` - Update user profile

#### Admin Management Endpoints
- **Contract Sections:** CRUD operations for maintenance contract sections
- **Contract Durations:** CRUD operations for contract duration management
- **Elevator Types:** CRUD operations for elevator type management
- **Elevator Models:** CRUD operations for elevator model management
- **User Management:** Client creation, technician status updates

#### Data Models for API Integration
The following models need to be aligned with API responses:

```dart
// API Response Wrapper
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
}

// User Model (API aligned)
class ApiUser {
  final int id;
  final String email;
  final String name;
  final String role;
  final String? phone;
  final String? profilePicture;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLogin;
}

// Contract Section Model
class ContractSection {
  final int id;
  final String name;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
}

// Contract Duration Model
class ContractDuration {
  final int id;
  final String duration;
  final int durationInMonths;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### Integration Strategy
1. **Model Alignment:** Update existing models to match API response structure
2. **Service Layer:** Implement repository pattern for API calls
3. **Error Handling:** Map API errors to application-specific failures
4. **Caching:** Implement local caching for offline support
5. **State Management:** Use Riverpod for API state management
6. **Testing:** Implement unit and integration tests for API services

### Next Steps for API Integration
1. Update `ApiPath` constants to match API documentation
2. Implement repository interfaces and implementations
3. Create API-specific data models
4. Update existing services to use real API calls
5. Implement proper error handling and user feedback
6. Add loading states and progress indicators
7. Implement offline data synchronization
8. Add comprehensive logging and debugging tools