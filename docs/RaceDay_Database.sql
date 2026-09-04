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


SELECT * FROM Roles;
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;