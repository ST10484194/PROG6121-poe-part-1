# RaceDay API - Endpoint Plan (Part 1)

This document lists every API endpoint the RaceDay system will expose, to be implemented exactly as planned in Part 2.

## Authentication

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| POST | /api/auth/register | Registers a new user as either an Organiser or a Participant. | None (public) | { fullName, email, password, role, contactNumber } | 201 Created - user record (no password) returned. 400 Bad Request - validation failed or email already registered. |
| POST | /api/auth/login | Authenticates a user and starts a session storing their UserID and Role. | None (public) | { email, password } | 200 OK - login success with role and session established. 401 Unauthorized - invalid credentials. |
| POST | /api/auth/logout | Ends the current user's session. | Any (logged in) | None | 200 OK - session cleared.

## User Profile

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| GET | /api/users/me | Returns the logged-in user's own profile information. | Any (logged in) | None | 200 OK - user profile object. 401 Unauthorized - no active session. |
| PUT | /api/users/me | Updates the logged-in user's own profile information. | Any (logged in) | { fullName, contactNumber, profilePictureUrl } | 200 OK - updated profile returned. 400 Bad Request - validation failed. |

## Events

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| GET | /api/events | Returns a list of all upcoming events, viewable by both roles. | Any (logged in) | None | 200 OK - array of events. |
| GET | /api/events/{id} | Returns full detail for a single event, including its categories. | Any (logged in) | None | 200 OK - event detail object. 404 Not Found - event does not exist. |
| POST | /api/events | Creates a new event owned by the logged-in Organiser. | Organiser | { name, description, eventDate, location, distanceKm, eventType } | 201 Created - new event record. 400 Bad Request - validation failed. |
| PUT | /api/events/{id} | Updates an existing event owned by the logged-in Organiser. | Organiser | { name, description, eventDate, location, distanceKm, eventType } | 200 OK - updated event. 403 Forbidden - not the owning Organiser. 404 Not Found. |
| DELETE | /api/events/{id} | Deletes an event owned by the logged-in Organiser. | Organiser | None | 204 No Content. 403 Forbidden - not the owning Organiser. 404 Not Found. |
| POST | /api/events/{id}/banner | Uploads/replaces the banner image for an event (stored via Azure Blob in Part 3). | Organiser | multipart/form-data image file | 200 OK - banner URL returned. 400 Bad Request - invalid file type. |
## Categories

## Event Enrolments

## Results
