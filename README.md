# RaceDay - Event Management System (Part 1: Planning & Database)

**RaceDay** is a full-stack web-based event management system built for the South African road running, walking, and cycling community. It allows Event Organisers to create and manage events, categories, and participant results, while Participants can browse events, enter them, and track their personal race history.

This repository contains **Part 1** of a three-part Portfolio of Evidence: system planning, including an Entity Relationship Diagram (ERD), a full API endpoint plan, and a SQL database script.

## Roles

- **Organiser** - can create, edit, and delete events, manage event categories, capture participant results, and view all event enrolments.
- **Participant** - can create an account, browse events, enter an event by selecting a category, view their own enrolments, and track their personal results.

## Repository Structure

    docs/
    ├── RaceDay_ERD.png              # Entity Relationship Diagram
    ├── RaceDay_Endpoint_Plan.md     # Full API endpoint plan
    └── RaceDay_Database.sql         # Database creation & seed script
    .github/workflows/
    └── part1-validate.yml           # CI/CD workflow validating repo structure


## CI/CD

A GitHub Actions workflow automatically validates that this repository contains all required Part 1 files (`/docs` folder with ERD, endpoint plan, and SQL script, plus a README) on every push.

**Latest build status:** ✅ Passing

<img width="1431" height="450" alt="Screenshot 2026-09-04 134646" src="https://github.com/user-attachments/assets/afc33081-7a55-49b4-9430-7f6d7f7d93bc" />

## Video Walkthrough

[Watch the Part 1 walkthrough on YouTube](https://youtu.be/PVn1d24QPz0)

In this video I walk through the ERD design decisions, the endpoint plan choices, and run the SQL script live in SSMS.
