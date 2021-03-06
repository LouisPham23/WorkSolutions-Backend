CREATE TABLE DEPARTMENT(
  Department_Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50),
  Location VARCHAR(255),
  Acronym VARCHAR(50)
);

INSERT INTO DEPARTMENT (Name, Location, Acronym) VALUES("Agency of Mainframe Computer Development", "76 Beechwood Dr.
New Haven, CT 06511", "AMCD");

INSERT INTO DEPARTMENT (Name, Location, Acronym) VALUES("Agency of On-Line Mainframe Backup and Connectivity","506 Sleepy Hollow Ave.Jamaica Plain, MA 02130", "OMBC");

INSERT INTO DEPARTMENT (Name, Location, Acronym) VALUES("Branch of Programming Control and Connectivity","257 W. Mechanic Dr.
Rocky Mount, NC 27804", "BPCC");

INSERT INTO DEPARTMENT (Name, Location, Acronym) VALUES("Programming Installation Committee","618 St Louis Street
Tualatin, OR 97062", "OMBC");

INSERT INTO DEPARTMENT (Name, Location, Acronym) VALUES("Multimedia Development Division","653 Church St.
Mountain View, CA 94043", "MDD");

INSERT INTO DEPARTMENT (Name, Location, Acronym) VALUES("Department of Database Troubleshooting and Internet Connectivity","694 Paris Hill St.
Saint Johns, FL 32259", "DDTIC");

CREATE TABLE TEAM(
  Team_Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Team_name VARCHAR(100)
);

INSERT INTO TEAM (Team_name) VALUES("Web Automation");
INSERT INTO TEAM (Team_name) VALUES("Database Administration");
INSERT INTO TEAM (Team_name) VALUES("UI/UX Design");
INSERT INTO TEAM (Team_name) VALUES("Network Operation Control");
INSERT INTO TEAM (Team_name) VALUES("Network Security");
INSERT INTO TEAM (Team_name) VALUES("Research Operation");

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

INSERT INTO EMPLOYEE VALUES ('RC129', 'Tom', 'Doe', 1, 'S', NULL , 'Network Support');
INSERT INTO EMPLOYEE VALUES ('RT123', 'Cienna', 'Phelps', 1, 'S', NULL , 'Help Desk Support');
INSERT INTO EMPLOYEE VALUES ('RV178', 'Keziah', 'Jones', 2, 'S', NULL , 'Network Support');
INSERT INTO EMPLOYEE VALUES ('R45Il', 'Doris', 'Yoder', 2, 'S', NULL , 'Software Support');
INSERT INTO EMPLOYEE VALUES ('RKI90', 'Faiz', 'Oconnor', 3, 'D', 'Android developer', NULL);
INSERT INTO EMPLOYEE VALUES ('U182F', 'Jaydon', 'Marsh', 3, 'D', 'IOS developer', NULL);
INSERT INTO EMPLOYEE VALUES ('JDC34', 'Kristina', 'Odling', 4, 'D', 'WEB developer', NULL);


CREATE TABLE STATUS (
    Status_Id INT PRIMARY KEY NOT NULL,
    Status_name VARCHAR(15)
);

INSERT INTO STATUS VALUES(1, "Work In Progress");
INSERT INTO STATUS VALUES(2, "Open");
INSERT INTO STATUS VALUES(3, "Closed");

CREATE TABLE TEAM_EMPLOYEE(
  Team_Id INT NOT NULL,
  Employee_Id VARCHAR(10) NOT NULL,
  FOREIGN KEY (Team_Id) REFERENCES TEAM(Team_Id),
  FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_Id)
);

INSERT INTO TEAM_EMPLOYEE VALUES (5, 'R45Il');
INSERT INTO TEAM_EMPLOYEE VALUES (4, 'RC129');
INSERT INTO TEAM_EMPLOYEE VALUES (2,'RKI90');
INSERT INTO TEAM_EMPLOYEE VALUES (6, 'RT123');
INSERT INTO TEAM_EMPLOYEE VALUES (5, 'RV178');
INSERT INTO TEAM_EMPLOYEE VALUES (3, 'U182F');


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

/*Materialized View for teams and their employees*/
CREATE TABLE TEAM_VIEW(
  Employee_Id VARCHAR(10),
  First_name VARCHAR(100),
  Last_name VARCHAR(100),
  Specialty VARCHAR(100),
  Levels VARCHAR(100),
  Team_name VARCHAR(100),
  FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_Id) ON DELETE CASCADE
);

INSERT INTO TICKET (Ticket_type, Priority, Status_Id, Title, Created_By, Assigned_To, Assigned_Date, Deadline_Date, Description) VALUES ('I', 1, 1, 'Fix bug on production Sales Watcher App', 'RC129', NULL, NOW(), null, 'Please fix on upload file error on production of sales watcher app. It keeps erroring');

INSERT INTO TICKET (Ticket_type, Priority, Status_Id, Title, Created_By, Assigned_To, Assigned_Date, Deadline_Date, Description) VALUES ('I', 2, 2, 'Create a report for this year total expenses', 'RV178', NULL, NOW(), null, 'Please create a report this year expenses due, make sure to check all details');

INSERT INTO TICKET (Ticket_type, Priority, Status_Id, Title, Created_By, Assigned_To, Assigned_Date, Deadline_Date, Description) VALUES ('R', 3, 3, 'Add a new feature to current paycheck app', 'RT123', NULL, CURRENT_TIMESTAMP(), null, 'Need a short cut to fill out all of the days on timesheet for salary workers');


/* Create a view that sums all tickets grouped by status: LP
  trigger for insert and update EMPLOYEE TYPE: LP */
CREATE VIEW ALL_TICKETS_TYPE_VIEW AS
  SELECT COUNT(A.Status_Id), B.Status_name
  FROM TICKET A JOIN STATUS B ON A.Status_Id = B.Status_Id
  GROUP BY A.Status_Id ;

DELIMITER //
CREATE TRIGGER EMPLOYEE_TYPE_DISJOINT_INSERT 
	BEFORE INSERT ON EMPLOYEE
    FOR EACH ROW 
    BEGIN
		IF 
			NEW.Type = 'D' THEN
			IF NEW.Levels is not null THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Developer can not have a level';
			END IF;
		ELSE IF
			NEW.Type = 'S' THEN
			IF NEW.Specialty is not null THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Support employee can not have a specialty';
			END IF;
        END IF;
        END IF;
	END //;
DELIMITER ;

DELIMITER //
CREATE TRIGGER EMPLOYEE_TYPE_DISJOINT_UPDATE 
	BEFORE UPDATE ON EMPLOYEE
    FOR EACH ROW 
    BEGIN
		IF 
			NEW.Type = 'D' THEN
			IF NEW.Levels is not null THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Developer can not have a level';
			END IF;
		ELSE IF
			NEW.Type = 'S' THEN
			IF NEW.Specialty is not null THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Support employee can not have a specialty';
			END IF;
        END IF;
        END IF;
	END //;
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetTeamsAndMembers()
  BEGIN
    SELECT COUNT(TE.Team_Id) AS Members, Team_name, TE.Team_Id
    FROM 
	    TEAM_EMPLOYEE TE 
      JOIN EMPLOYEE E ON E.Employee_Id = TE.Employee_Id
      JOIN TEAM T ON TE.Team_Id = T.Team_Id
      GROUP BY TE.Team_Id;
  END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER INSERT_TICKET_STATUS_OPEN 
	BEFORE INSERT ON TICKET
    FOR EACH ROW 
    BEGIN
		IF New.Status_Id IS null 
			THEN SET New.Status_Id = 2;
		END IF;
		SET New.Assigned_Date = NOW();
	END //;
DELIMITER ;

DELIMITER //
CREATE TRIGGER INSERT_TEAM_EMPLOYEE_EXIST 
	BEFORE INSERT ON TEAM_EMPLOYEE
    FOR EACH ROW 
    BEGIN
		IF 
			EXISTS(SELECT * FROM TEAM_EMPLOYEE WHERE Employee_Id = NEW.Employee_Id AND Team_Id = New.Team_Id) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error, the employee is already in team.';
        END IF;
	END //;
DELIMITER ;
/*
trigger for EMPLOYEES support level, materialized view: Dat
*/
/* Definition for support levels */
CREATE TABLE SUPPORT_LEVELS{
  SLevel integer,
  SName VARCHAR(20),
  CONSTRAINT PRIMARY KEY(SLevel,SName)
};


INSERT INTO SUPPORT_LEVELS (SLevel,SName) VALUES (1, "Service Desk");
INSERT INTO SUPPORT_LEVELS (SLevel,SName) VALUES (2, "Infrastructure");
INSERT INTO SUPPORT_LEVELS (SLevel,SName) VALUES (3, "Infrastructure");
/* IF support, level cannot be null and Specialty must be null */
DELIMITER //
CREATE TRIGGER EMPLOYEE_SUPPORT_LEVEL
	BEFORE INSERT ON EMPLOYEE
    FOR EACH ROW 
    BEGIN
		IF EMPLOYEE.Type == 'SUPPORT' 
      THEN IF EMPLOYEE.level is null EMPLOYEE.Specialty is NOT NULL
			  THEN  SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Support employee needs to have Level and Specialty must be null.';
		END IF;
		SET New.Assigned_Date = NOW();
	END //;
DELIMITER ;

/* On Insert, add to materialized view. */
DELIMITER //
CREATE TRIGGER EMPLOYEE_SUPPORT_LEVEL
	AFTER INSERT ON EMPLOYEE
    FOR EACH ROW 
    BEGIN
		IF EMPLOYEE.Type == 'SUPPORT' 
      THEN IF EMPLOYEE.level is null EMPLOYEE.Specialty is NOT NULL
			  THEN  SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Support employee needs to have Level and Specialty must be null.';\
		END IF;
		SET New.Assigned_Date = NOW();
	END //;
DELIMITER ;


/*After employee record is inserted, log appropriate info to materialized view*/
DELIMITER //
CREATE TRIGGER TEAM_VIEW_INSERT AFTER INSERT ON dbo.TEAM_EMPLOYEE
  FOR EACH ROW
  BEGIN
    DECLARE newEmployee_Id varchar(10);
    DECLARE newFirst varchar(100);
    DECLARE newLast varchar(100);
    DECLARE newSpecialty VARCHAR(100);
    DECLARE newLevels VARCHAR(100);
    DECLARE newTeam_name VARCHAR(100);

    SELECT E.Employee_Id, E.First_name, E.Last_name, E.Specialty, E.Levels, T.Team_name INTO newEmployee_Id, newFirst, newLast, newSpecialty, newLevels, newTeam_name
      FROM EMPLOYEE AS E JOIN TEAM_EMPLOYEE AS TE 
        ON E.Employee_Id = TE.Employee_Id JOIN TEAM AS T
        ON TE.Team_Id = T.Team_Id
	  WHERE E.Employee_Id = NEW.Employee_Id
		AND TE.Team_Id = NEW.Team_Id;

      INSERT INTO TEAM_VIEW VALUES(newEmployee_Id, newFirst, newLast, newSpecialty, newLevels, newTeam_name);
END //
DELIMITER //