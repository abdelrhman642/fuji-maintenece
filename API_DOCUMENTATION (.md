# Fuji Maintenance Backend API Documentation

## Overview
This document provides a comprehensive guide for mobile developers to understand and integrate with the Fuji Maintenance Backend API. The API follows RESTful principles and uses Laravel Sanctum for authentication.

## Base URL
```
https://your-domain.com/api/
```

## Authentication
The API uses Laravel Sanctum for token-based authentication. Include the Bearer token in the Authorization header for protected routes.

```
Authorization: Bearer {your-token}
```

## Response Format
All API responses follow a consistent JSON format:
```json
{
  "success": true/false,
  "message": "Response message",
  "data": {} // Response data
}
```

---

## 📱 Mobile App Integration Routes

### 🔐 Authentication Endpoints

#### 1. Login
- **Endpoint:** `POST /api/login`
- **Access:** Public
- **Description:** Authenticate users (Admin, Client, or Technician)
- **Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password",
  "user_type": "admin|client|technician" // Optional, for role-specific login
}
```
- **Success Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": 1,
      "email": "user@example.com",
      "name": "User Name",
      "role": "admin"
    },
    "token": "sanctum_token_here"
  }
}
```

#### 2. Register Technician
- **Endpoint:** `POST /api/register/technician`
- **Access:** Public
- **Description:** Register a new technician account
- **Request Body:**
```json
{
  "name": "Technician Name",
  "email": "technician@example.com",
  "password": "password",
  "password_confirmation": "password",
  "phone": "1234567890",
  "specialty": "Elevator Maintenance"
}
```

#### 3. Logout
- **Endpoint:** `POST /api/logout`
- **Access:** Authenticated users
- **Headers:** `Authorization: Bearer {token}`
- **Description:** Logout and invalidate current token

---

### 👤 User Profile Management

#### 1. Get User Profile
- **Endpoint:** `GET /api/profile`
- **Access:** Authenticated users
- **Headers:** `Authorization: Bearer {token}`
- **Description:** Get current user profile information

#### 2. Update User Profile
- **Endpoint:** `PUT /api/profile`
- **Access:** Authenticated users
- **Headers:** `Authorization: Bearer {token}`
- **Description:** Update current user profile
- **Request Body:**
```json
{
  "name": "Updated Name",
  "email": "updated@example.com",
  "phone": "0987654321"
}
```

#### 3. Get Current User (Test Route)
- **Endpoint:** `GET /api/user`
- **Access:** Authenticated users
- **Headers:** `Authorization: Bearer {token}`
- **Description:** Test route to get current authenticated user

---

## 🏢 Admin-Only Endpoints

### 👥 User Management

#### 1. Update Technician Status
- **Endpoint:** `POST /api/admin/update-technician-status`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Update technician account status (active/inactive)
- **Request Body:**
```json
{
  "technician_id": 1,
  "status": "active|inactive"
}
```

#### 2. Create Client
- **Endpoint:** `POST /api/admin/create-client`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Create a new client account
- **Request Body:**
```json
{
  "name": "Client Name",
  "email": "client@example.com",
  "company_name": "Company Ltd",
  "phone": "1234567890",
  "address": "Client Address"
}
```

---

### 📋 Maintenance Contract Sections Management

#### 1. Get All Sections
- **Endpoint:** `GET /api/admin/maintenance-contract-sections/get-sections`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Retrieve all maintenance contract sections

#### 2. Get Active Sections
- **Endpoint:** `GET /api/admin/maintenance-contract-sections/get-active-sections`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Retrieve only active maintenance contract sections

#### 3. Create New Section
- **Endpoint:** `POST /api/admin/maintenance-contract-sections/store-section`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Create a new maintenance contract section
- **Request Body:**
```json
{
  "name": "Section Name",
  "description": "Section Description",
  "status": "active|inactive"
}
```

#### 4. Update Section
- **Endpoint:** `POST /api/admin/maintenance-contract-sections/{id}/update-section`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Update an existing maintenance contract section
- **URL Parameters:** `id` - Section ID
- **Request Body:**
```json
{
  "name": "Updated Section Name",
  "description": "Updated Description",
  "status": "active|inactive"
}
```

#### 5. Get Active Section (Single)
- **Endpoint:** `GET /api/admin/maintenance-contract-sections/active-section`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Get currently active section

#### 6. Get Section for Edit
- **Endpoint:** `GET /api/admin/maintenance-contract-sections/{id}/edit-section`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Section ID
- **Description:** Get section details for editing

#### 7. Delete Section
- **Endpoint:** `GET /api/admin/maintenance-contract-sections/{id}/delete`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Section ID
- **Description:** Delete a maintenance contract section

---

### ⏱️ Contract Duration Management

#### 1. Get All Durations
- **Endpoint:** `GET /api/admin/contract-duration/get-durations`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Retrieve all contract durations

#### 2. Get Active Durations
- **Endpoint:** `GET /api/admin/contract-duration/get-active-durations`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Retrieve only active contract durations

#### 3. Create New Duration
- **Endpoint:** `POST /api/admin/contract-duration/store-duration`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Create a new contract duration
- **Request Body:**
```json
{
  "duration": "12 months",
  "duration_in_months": 12,
  "status": "active|inactive"
}
```

#### 4. Update Duration
- **Endpoint:** `POST /api/admin/contract-duration/{id}/update-duration`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Duration ID
- **Description:** Update an existing contract duration

#### 5. Get Active Duration (Single)
- **Endpoint:** `GET /api/admin/contract-duration/active-duration`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Get currently active duration

#### 6. Get Duration for Edit
- **Endpoint:** `GET /api/admin/contract-duration/{id}/edit-duration`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Duration ID

#### 7. Delete Duration
- **Endpoint:** `GET /api/admin/contract-duration/{id}/delete`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Duration ID

---

### 🏗️ Elevator Types Management

#### 1. Get All Types
- **Endpoint:** `GET /api/admin/elevator-types/get-types`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Retrieve all elevator types

#### 2. Get Active Types
- **Endpoint:** `GET /api/admin/elevator-types/get-active-types`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Retrieve only active elevator types

#### 3. Create New Type
- **Endpoint:** `POST /api/admin/elevator-types/store-type`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Create a new elevator type
- **Request Body:**
```json
{
  "name": "Passenger Elevator",
  "description": "Standard passenger elevator",
  "status": "active|inactive"
}
```

#### 4. Update Type
- **Endpoint:** `POST /api/admin/elevator-types/{id}/update-type`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Type ID

#### 5. Get Active Type (Single)
- **Endpoint:** `GET /api/admin/elevator-types/active-type`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`

#### 6. Get Type for Edit
- **Endpoint:** `GET /api/admin/elevator-types/{id}/edit-type`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Type ID

#### 7. Delete Type
- **Endpoint:** `GET /api/admin/elevator-types/{id}/delete`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Type ID

---

### 🏭 Elevator Models Management

#### 1. Get All Models
- **Endpoint:** `GET /api/admin/elevator-models/get-models`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Retrieve all elevator models (with elevator type relationship)

#### 2. Get Active Models
- **Endpoint:** `GET /api/admin/elevator-models/get-active-models`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Retrieve only active elevator models

#### 3. Create New Model
- **Endpoint:** `POST /api/admin/elevator-models/store-model`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **Description:** Create a new elevator model
- **Request Body:**
```json
{
  "name": "Model XYZ-2000",
  "elevator_type_id": 1,
  "manufacturer": "Fuji Elevators",
  "specifications": "Load: 1000kg, Speed: 2m/s",
  "status": "active|inactive"
}
```

#### 4. Update Model
- **Endpoint:** `POST /api/admin/elevator-models/{id}/update-model`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Model ID

#### 5. Get Active Model (Single)
- **Endpoint:** `GET /api/admin/elevator-models/active-model`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`

#### 6. Get Model for Edit
- **Endpoint:** `GET /api/admin/elevator-models/{id}/edit-model`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Model ID

#### 7. Delete Model
- **Endpoint:** `GET /api/admin/elevator-models/{id}/delete`
- **Access:** Admin only
- **Headers:** `Authorization: Bearer {admin-token}`
- **URL Parameters:** `id` - Model ID

---

## 🏢 Client-Only Endpoints
```
Base URL: /api/client/*
```
*Note: Client-specific routes are currently placeholder - to be implemented based on requirements.*

---

## 🔧 Technician-Only Endpoints
```
Base URL: /api/technician/*
```
*Note: Technician-specific routes are currently placeholder - to be implemented based on requirements.*

---

## 🤝 Shared Endpoints (Admin OR Technician Access)
*Note: Shared routes are currently placeholder - to be implemented based on requirements.*

---

## 📱 Mobile Development Guidelines

### 1. Authentication Flow
1. **Login:** Use the `/api/login` endpoint with user credentials
2. **Store Token:** Save the returned token securely (Keychain/SharedPreferences)
3. **Include Token:** Add `Authorization: Bearer {token}` header to all authenticated requests
4. **Handle Expiry:** Implement token refresh or re-login when token expires (401 response)

### 2. Error Handling
- **200-299:** Success responses
- **400:** Bad Request (validation errors)
- **401:** Unauthorized (invalid/expired token)
- **403:** Forbidden (insufficient permissions)
- **404:** Not Found
- **500:** Server Error

### 3. Role-Based UI
Based on user role, show/hide features:
- **Admin:** Full access to all management features
- **Client:** View-only access to their contracts and elevators
- **Technician:** Maintenance-related features and assigned tasks

### 4. Offline Capability
Consider implementing:
- Local storage for frequently accessed data
- Sync mechanism for when connection is restored
- Queue for actions performed offline

### 5. Security Best Practices
- Never store passwords locally
- Use secure storage for tokens
- Implement certificate pinning for production
- Validate SSL certificates
- Implement proper logout (clear all stored data)

### 6. Performance Optimization
- Implement pagination for list endpoints
- Use appropriate caching strategies
- Compress images before upload
- Use appropriate request timeouts

---

## 🔧 Development Notes

### Current API Status
- ✅ Authentication system implemented
- ✅ Admin management endpoints implemented
- ⏳ Client-specific endpoints (to be implemented)
- ⏳ Technician-specific endpoints (to be implemented)
- ⏳ Shared Admin/Technician endpoints (to be implemented)

### Future Enhancements
- File upload endpoints for images/documents
- Real-time notifications (WebSocket/Pusher)
- Maintenance scheduling endpoints
- Reporting and analytics endpoints
- Mobile-specific optimized responses

---

## 📞 Support
For API support and questions:
- Review this documentation
- Check the Laravel logs for detailed error information
- Contact the backend development team

---

*Last Updated: September 28, 2025*