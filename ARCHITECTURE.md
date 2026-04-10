# Fuji Maintenance System - Project Architecture

## Overview
This document outlines the improved file structure and architecture for the Fuji Maintenance System, designed to support three distinct user interfaces: Admin, Technician, and Client.

## Directory Structure

```
lib/
├── core/                          # Core application logic
│   ├── routing/                   # Navigation and routing
│   │   ├── app_routes.dart       # Route definitions
│   │   └── app_router_config.dart # Router configuration
│   ├── guards/                    # Route guards and middleware
│   │   └── auth_guard.dart       # Authentication guard
│   ├── service/                   # Core services
│   ├── extensions/                # Dart extensions
│   └── enum/                      # Application enums
│
├── interfaces/                    # Interface-specific code
│   ├── admin/                     # Administrator interface
│   │   ├── screens/              # Admin screens
│   │   ├── widgets/              # Admin-specific widgets
│   │   ├── controllers/          # Admin controllers
│   │   └── features/             # Admin-specific features
│   ├── technician/               # Technician interface
│   │   ├── screens/              # Technician screens
│   │   ├── widgets/              # Technician-specific widgets
│   │   ├── controllers/          # Technician controllers
│   │   └── features/             # Technician-specific features
│   └── client/                   # Client interface
│       ├── screens/              # Client screens
│       ├── widgets/              # Client-specific widgets
│       ├── controllers/          # Client controllers
│       └── features/             # Client-specific features
│
├── shared/                        # Shared components across interfaces
│   ├── widgets/                   # Reusable widgets
│   ├── models/                    # Data models
│   ├── services/                  # Shared services
│   ├── utils/                     # Utility functions
│   ├── constants/                 # App constants
│   └── features/                  # Shared features (auth, etc.)
│
├── features/                      # Feature modules (legacy - being migrated)
│   └── auth/                      # Authentication feature
│
├── config/                        # App configuration
├── helper/                        # Helper functions
├── ui/                           # Legacy UI components
└── main.dart                     # Application entry point
```

## Architecture Principles

### 1. Interface Separation
Each user type (Admin, Technician, Client) has its own dedicated directory structure:
- **Screens**: UI screens specific to that interface
- **Widgets**: Reusable widgets specific to that interface
- **Controllers**: Business logic and state management
- **Features**: Complex features specific to that interface

### 2. Shared Components
Common functionality is placed in the `shared/` directory:
- **Widgets**: UI components used across multiple interfaces
- **Models**: Data models shared across the application
- **Services**: Business services (auth, API, etc.)
- **Utils**: Helper functions and utilities

### 3. Core System
The `core/` directory contains fundamental application logic:
- **Routing**: Navigation system with role-based access
- **Guards**: Authentication and authorization
- **Services**: System-level services
- **Extensions**: Dart language extensions

## User Interfaces

### Admin Interface
**Path**: `/interfaces/admin/`
**Purpose**: Administrative control and system management

**Key Features**:
- User management
- System reports and analytics
- Work order oversight
- Technician management
- System configuration

**Route Prefix**: `/admin/`

### Technician Interface
**Path**: `/interfaces/technician/`
**Purpose**: Field work and task management

**Key Features**:
- Work order management
- Schedule viewing
- Task reporting
- Profile management
- Equipment tracking

**Route Prefix**: `/technician/`

### Client Interface
**Path**: `/interfaces/client/`
**Purpose**: Service requests and status tracking

**Key Features**:
- Maintenance request creation
- Request status tracking
- Service history
- Support and communication
- Profile management

**Route Prefix**: `/client/`

## Authentication & Security

### Route Guards
- **AuthGuard**: Ensures user authentication
- **Role-based access**: Routes are protected based on user type
- **Automatic redirection**: Unauthorized users are redirected appropriately

### User Types
```dart
enum UserType {
  admin('admin', 'مدير'),
  technician('technician', 'فني'),
  client('client', 'عميل');
}
```

## State Management

### Riverpod Providers
- Interface-specific controllers use AsyncNotifier
- Shared services use Provider
- Authentication state managed globally

### Example Controller Structure
```dart
class AdminDashboardController extends AsyncNotifier<AdminDashboardData> {
  @override
  Future<AdminDashboardData> build() async {
    return _loadDashboardData();
  }
}
```

## Widget Conventions

### Custom AppBar
Consistent header across all interfaces with:
- Interface-specific colors
- User menu with role-appropriate options
- Notification system
- Logout functionality

### Dashboard Cards
Standardized card components for navigation and statistics:
- `DashboardCard`: Navigation cards
- `StatsCard`: Numeric display cards

## Data Models

### Core Models
- **User**: Authentication and profile data
- **WorkOrderItem**: Technician work orders
- **MaintenanceRequest**: Client requests
- **Equipment**: Equipment management
- **Technician**: Technician profiles

## Migration Strategy

### Phase 1: Structure Setup ✅
- Create new directory structure
- Set up routing with guards
- Create base components

### Phase 2: Interface Implementation
- Implement admin interface screens
- Implement technician interface screens
- Implement client interface screens

### Phase 3: Feature Migration
- Move existing features to new structure
- Update imports and dependencies
- Remove legacy code

### Phase 4: Optimization
- Performance optimization
- Testing implementation
- Documentation completion

## Development Guidelines

### File Naming
- Use snake_case for file names
- Suffix screen files with `_screen.dart`
- Suffix controller files with `_controller.dart`
- Suffix model files with `_model.dart`

### Import Organization
```dart
// Flutter imports
import 'package:flutter/material.dart';

// Third-party imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Local imports
import '../../../core/routing/app_routes.dart';
import '../../../shared/widgets/custom_app_bar.dart';
```

### Code Organization
1. Constructor and properties
2. Build method and UI
3. Helper methods (private)
4. Event handlers
5. Utility methods

## Benefits of This Structure

### 1. Scalability
- Easy to add new interfaces
- Clear separation of concerns
- Modular architecture

### 2. Maintainability
- Interface-specific code is isolated
- Shared components reduce duplication
- Clear dependency management

### 3. Team Development
- Multiple developers can work on different interfaces
- Reduced merge conflicts
- Clear ownership of code sections

### 4. Testing
- Interface-specific testing
- Shared component testing
- Easy mocking and isolation

## Getting Started

### For New Features
1. Identify which interface the feature belongs to
2. Create files in the appropriate interface directory
3. Use shared components where possible
4. Follow the established patterns

### For Shared Components
1. Create in the `shared/` directory
2. Make components generic and reusable
3. Document parameters and usage
4. Add to the appropriate barrel export

### For Core Functionality
1. Add to the `core/` directory
2. Ensure it's truly core functionality
3. Update guards and routing as needed
4. Document any breaking changes

This architecture provides a solid foundation for the multi-interface maintenance system, ensuring maintainability, scalability, and clear separation of concerns.
