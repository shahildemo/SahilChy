# Futsal Finder - Blueprint

## Overview

Futsal Finder is a Flutter application that helps users find and book futsal courts.

## Implemented Features

### Core

*   **Firebase Integration:**
    *   Initialized Firebase for the project.
    *   Configured for Android and Web platforms.
    *   Integrated `firebase_core` for Firebase services.
*   **State Management:**
    *   Uses `provider` for state management.

### User Authentication

*   **Authentication Service:**
    *   An `AuthService` handles user sign-up, sign-in, and sign-out using Firebase Authentication.
*   **Login & Signup Screens:**
    *   Dedicated screens for user login and registration.
    *   Signup includes role selection (User, Futsal Owner).
*   **Auth Wrapper:**
    *   An `AuthWrapper` directs users to the appropriate screen based on their authentication state and role (User, Futsal Owner, Admin).
*   **Logout:**
    *   Users can log out from the main futsal list screen.

### UI

*   **Futsal Field List:**
    *   Displays a list of futsal fields.
    *   Includes a search bar to filter fields by name.
*   **Detail Screen:**
    *   Shows detailed information about a selected futsal field.
*   **Booking (Mocked):**
    *   Allows users to select a date and time for booking.
    *   Shows a confirmation dialog upon booking.
*   **Styling:**
    *   Uses a blue primary swatch for the theme.

## Current Plan

The current goal is to build out the dashboards for the 'Futsal Owner' and 'Admin' user roles.

### Steps

1.  **Futsal Owner Dashboard:**
    *   Create a dashboard for futsal owners to manage their fields and view bookings.
2.  **Admin Dashboard:**
    *   Create a dashboard for administrators to manage users and futsal fields.
