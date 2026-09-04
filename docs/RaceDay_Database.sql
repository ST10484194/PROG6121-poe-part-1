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
   SEED DATA
   (added incrementally below as the script develops)
   ============================================================ */

   SELECT * FROM Roles;
SELECT * FROM Users;