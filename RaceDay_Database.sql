/* ============================================================
   RaceDay System - Database Creation & Seed Script
   Author: Livhuwani Matsila
   ============================================================ */

USE master;
GO

IF DB_ID('RaceDayDB') IS NOT NULL
BEGIN
    ALTER DATABASE RaceDayDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RaceDayDB;
END
GO

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

/* ============================================================
   TABLES
   ============================================================ */

/* ============================================================
   TABLE: Roles
   Lookup table for the two system roles.
   ============================================================ */
CREATE TABLE Roles (
    RoleID      INT IDENTITY(1,1) PRIMARY KEY,
    RoleName    VARCHAR(20) NOT NULL UNIQUE
);
GO

/* ============================================================
   TABLE: Users
   Stores both Organisers and Participants, distinguished by RoleID.
   ============================================================ */
CREATE TABLE Users (
    UserID              INT IDENTITY(1,1) PRIMARY KEY,
    RoleID              INT NOT NULL,
    FullName            VARCHAR(100) NOT NULL,
    Email               VARCHAR(150) NOT NULL UNIQUE,
    PasswordHash        VARCHAR(255) NOT NULL,
    ContactNumber       VARCHAR(20)  NULL,
    ProfilePictureUrl   VARCHAR(255) NULL,
    CreatedAt           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
GO

/* ============================================================
   TABLE: Events
   Created and managed by an Organiser (Users.UserID).
   ============================================================ */
CREATE TABLE Events (
    EventID         INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID     INT NOT NULL,
    Name            VARCHAR(150) NOT NULL,
    Description     VARCHAR(1000) NULL,
    EventDate       DATETIME NOT NULL,
    Location        VARCHAR(150) NOT NULL,
    DistanceKm      DECIMAL(6,2) NOT NULL,
    EventType       VARCHAR(10) NOT NULL DEFAULT 'Run', -- Run / Walk / Cycle
    BannerImageUrl  VARCHAR(255) NULL,
    CreatedAt       DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Events_Organiser FOREIGN KEY (OrganiserID) REFERENCES Users(UserID),
    CONSTRAINT CK_Events_EventType CHECK (EventType IN ('Run','Walk','Cycle'))
);
GO

/* ============================================================
   TABLE: Categories
   Age or distance categories defined per Event.
   ============================================================ */
CREATE TABLE Categories (
    CategoryID      INT IDENTITY(1,1) PRIMARY KEY,
    EventID         INT NOT NULL,
    CategoryName    VARCHAR(50) NOT NULL,
    MinAge          INT NULL,
    MaxAge          INT NULL,
    DistanceKm      DECIMAL(6,2) NULL,
    CONSTRAINT FK_Categories_Events FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE
);
GO

/* ============================================================
   TABLE: Enrolments
   Links a Participant (Users.UserID) to an Event and a Category.
   ============================================================ */
CREATE TABLE Enrolments (
    EnrolmentID     INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID   INT NOT NULL,
    EventID         INT NOT NULL,
    CategoryID      INT NOT NULL,
    EnrolmentStatus VARCHAR(20) NOT NULL DEFAULT 'Pending', -- Pending / Confirmed
    EnrolmentDate   DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Enrolments_Users FOREIGN KEY (ParticipantID) REFERENCES Users(UserID),
    CONSTRAINT FK_Enrolments_Events FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT FK_Enrolments_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT CK_Enrolments_Status CHECK (EnrolmentStatus IN ('Pending','Confirmed')),
    CONSTRAINT UQ_Enrolments_ParticipantEvent UNIQUE (ParticipantID, EventID)
);
GO

/* ============================================================
   TABLE: Results
   One-to-one with Enrolments; captured by the Organiser after
   the event concludes.
   ============================================================ */
CREATE TABLE Results (
    ResultID            INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID         INT NOT NULL UNIQUE,
    FinishTime          TIME NOT NULL,
    FinishingPosition   INT NOT NULL,
    RecordedAt          DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Results_Enrolments FOREIGN KEY (EnrolmentID) REFERENCES Enrolments(EnrolmentID) ON DELETE CASCADE
);
GO

/* ============================================================
   SEED DATA
   ============================================================ */

-- Roles
INSERT INTO Roles (RoleName) VALUES ('Organiser'), ('Participant');
GO

-- Users: 2 Organisers, 2 Participants
INSERT INTO Users (RoleID, FullName, Email, PasswordHash, ContactNumber, CreatedAt)
VALUES
((SELECT RoleID FROM Roles WHERE RoleName = 'Organiser'),  'Rendani Mulaudzi',     'rendani.mulaudzi@raceday.co.za',     'HASHED_PWD_1', '0821234567', GETDATE()),
((SELECT RoleID FROM Roles WHERE RoleName = 'Organiser'),  'Fhatuwani Ramavhoya',  'fhatuwani.ramavhoya@raceday.co.za',  'HASHED_PWD_2', '0827654321', GETDATE()),
((SELECT RoleID FROM Roles WHERE RoleName = 'Participant'),'Khathutshelo Netshitungulu','khathu.netshitungulu@example.com','HASHED_PWD_3', '0731112222', GETDATE()),
((SELECT RoleID FROM Roles WHERE RoleName = 'Participant'),'Ndivhuwo Tshivhase',   'ndivhuwo.tshivhase@example.com',     'HASHED_PWD_4', '0733334444', GETDATE());
GO

SELECT * FROM Roles;
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM Enrolments;
SELECT * FROM Results;