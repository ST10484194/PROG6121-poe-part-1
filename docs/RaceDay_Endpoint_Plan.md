# RaceDay API - Endpoint Plan (Part 1)

This document lists every API endpoint the RaceDay system will expose, to be implemented exactly as planned in Part 2.

## Authentication

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| POST | /api/auth/register | Registers a new user as either an Organiser or a Participant. | None (public) | { fullName, email, password, role, contactNumber } | 201 Created - user record (no password) returned. 400 Bad Request - validation failed or email already registered. |
| POST | /api/auth/login | Authenticates a user and starts a session storing their UserID and Role. | None (public) | { email, password } | 200 OK - login success with role and session established. 401 Unauthorized - invalid credentials. |
| POST | /api/auth/logout | Ends the current user's session. | Any (logged in) | None | 200 OK - session cleared.

## User Profile

## Events

## Categories

## Event Enrolments

## Results
