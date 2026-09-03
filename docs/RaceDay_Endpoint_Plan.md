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
| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| GET | /api/events/{eventId}/categories | Returns all categories available for a specific event. | Any (logged in) | None | 200 OK - array of categories. 404 Not Found - event does not exist. |
| POST | /api/events/{eventId}/categories | Adds a new age/distance category to an event. | Organiser | { categoryName, minAge, maxAge, distanceKm } | 201 Created - new category record. 403 Forbidden - not the owning Organiser. |
| PUT | /api/categories/{id} | Updates an existing category. | Organiser | { categoryName, minAge, maxAge, distanceKm } | 200 OK - updated category. 403 Forbidden. 404 Not Found. |
| DELETE | /api/categories/{id} | Removes a category from an event. | Organiser | None | 204 No Content. 403 Forbidden. 404 Not Found. |

## Event Enrolments
| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| POST | /api/events/{eventId}/enrolments | Enrols the logged-in Participant into an event under a chosen category. | Participant | { categoryId } | 201 Created - enrolment record with status Pending. 404 Not Found - event/category invalid. 409 Conflict - already enrolled. |
| GET | /api/users/me/enrolments | Returns all of the logged-in Participant's own enrolments. | Participant | None | 200 OK - array of enrolments. |
| GET | /api/events/{eventId}/enrolments | Returns all Participants enrolled in a specific event, for the owning Organiser. | Organiser | None | 200 OK - array of enrolments with participant details. 403 Forbidden - not the owning Organiser. |

## Results
| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| POST | /api/enrolments/{enrolmentId}/result | Captures the finish time and finishing position for a Participant's enrolment. | Organiser | { finishTime, finishingPosition } | 201 Created - result record. 403 Forbidden - not the owning Organiser. 404 Not Found - enrolment does not exist. |
| GET | /api/users/me/results | Returns the logged-in Participant's full personal race history. | Participant | None | 200 OK - array of results joined with event/category info. |
| GET | /api/events/{eventId}/results | Returns all results for a specific event (e.g. for publishing a results list). | Any (logged in) | None | 200 OK - array of results. 404 Not Found - event does not exist. |
