CREATE TABLE DEPARTMENT(
  Department_Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50),
  Location VARCHAR(255),
  Acronym VARCHAR(50)
);

CREATE TABLE TEAM(
  Team_Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Team_name VARCHAR(100)
);

CREATE TABLE EMPLOYEE(
  Employee_Id VARCHAR(10) PRIMARY KEY NOT NULL,
  First_name VARCHAR(100),
  Last_name VARCHAR(100),
  Department_Id INT,
  Type VARCHAR(100),
  Specialty VARCHAR(100),
  Levels VARCHAR(100),
  FOREIGN KEY (Department_Id) REFERENCES DEPARTMENT(Department_Id)
);

CREATE TABLE STATUS (
    Status_Id INT PRIMARY KEY NOT NULL,
    Status_name VARCHAR(15)
);

CREATE TABLE TEAM_EMPLOYEE(
  Team_Id INT NOT NULL,
  Employee_Id VARCHAR(10) NOT NULL,
  FOREIGN KEY (Team_Id) REFERENCES TEAM(Team_Id),
  FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_Id)
);

CREATE TABLE TICKET(
  Ticket_number INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Ticket_type VARCHAR(50),
  Priority INT,
  Status_Id INT,
  Title VARCHAR(255),
  Created_By VARCHAR(10) NOT NULL,
  Assigned_To VARCHAR(10),
  Assigned_Date DATE,
  Deadline_Date DATE,
  Description TEXT,
  FOREIGN KEY (Created_By)    REFERENCES EMPLOYEE(Employee_Id),
    FOREIGN KEY (Assigned_To) REFERENCES EMPLOYEE(Employee_Id),
      FOREIGN KEY (Status_Id) REFERENCES STATUS(Status_Id)
);

/* Create a view that sums all tickets grouped by status: LP

CREATE VIEW(

);

trigger for insert and update EMPLOYEE TYPE: LP

Delimiter //
Create Trigger

//

trigger for EMPLOYEES support level, materialized view: Dat

Delimiter //
Create Trigger

//

trigger for employees and teams they are apart of, materialized view for web developer, IT, etc: Jared

Delimeter //
Create Trigger

//


DELIMITER //

DELIMITER // 
CREATE PROCEDURE GetTeamsAndMembers()
BEGIN
    SELECT *
    FROM 
	    TEAM T JOIN EMPLOYEE E ON E.Team_Id = T.Team_Id;
END //
DELIMITER ;
