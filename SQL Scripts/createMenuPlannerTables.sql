--Script to Create Project Menu Planner Database
--Isha Srivastava  Mar 07 2018

--.open Menu_Planner.db

.echo ON

.mode list

.separator "  |  "

.output createMenuPlannerTables.txt

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS List;
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Rec_Ingred;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Unit;
DROP TABLE IF EXISTS Unit_Type;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS View_List_Ingred;



-- Create sequenced so that tables that are references
-- as FK are created before table that uses FK

CREATE TABLE User
(User_ID INTEGER,
User_Name VARCHAR(35) NOT NULL,
User_Email VARCHAR(50) NOT NULL,
User_Password VARCHAR(50) NOT NULL,
CONSTRAINT User_User_ID_PK PRIMARY KEY (User_ID));

CREATE TABLE Category
(Cat_ID INTEGER,
Cat_Main VARCHAR(15) NOT NULL,
Cat_Descr VARCHAR(50) NOT NULL,
CONSTRAINT Category_Cat_ID_PK PRIMARY KEY (Cat_ID));

--Std Unit ID can be Null to allow Unit and Unit Type to be created
CREATE TABLE Unit_Type
(Unit_Type_ID INTEGER,
Unit_Type VARCHAR(10) NOT NULL,
CONSTRAINT Unit_Type_Ut_ID_PK PRIMARY KEY (Unit_Type_ID));

CREATE TABLE Unit
(Unit_ID INTEGER,
Unit_Type_ID INTEGER NOT NULL,
Unit_Name VARCHAR(15) NOT NULL,
Unit_Abbrev CHAR(3) NOT NULL,
Unit_Convfactor REAL NOT NULL,
CONSTRAINT Unit_Unit_ID_PK PRIMARY KEY (Unit_ID),
CONSTRAINT Unit_Unittype_ID_FK FOREIGN KEY (Unit_Type_ID) REFERENCES Unit_Type(Unit_Type_ID));

CREATE TABLE List
(List_ID INTEGER,
List_Name VARCHAR(35) NOT NULL,
User_ID INTEGER NOT NULL,
CONSTRAINT List_List_ID_PK PRIMARY KEY (List_ID),
CONSTRAINT List_User_ID_FK FOREIGN KEY (User_ID) REFERENCES User(User_ID));


CREATE TABLE Event
(Ev_ID INTEGER,
Ev_Name VARCHAR(35) NOT NULL,
Ev_Date DATE,
User_ID INTEGER NOT NULL,
Ev_Guests INTEGER NOT NULL DEFAULT(0),
List_ID INTEGER,
CONSTRAINT Event_Ev_ID_PK PRIMARY KEY (Ev_ID),
CONSTRAINT Event_User_ID_FK FOREIGN KEY (User_ID) REFERENCES User(User_ID),
CONSTRAINT Event_List_ID_FK FOREIGN KEY (List_ID) REFERENCES List(List_ID)
ON DELETE SET NULL);


CREATE TABLE Recipe
(Rec_ID INTEGER,
Rec_Name VARCHAR(50) NOT NULL,
Rec_Servings_Made INTEGER NOT NULL DEFAULT(0),
User_ID INTEGER NOT NULL,
CONSTRAINT Recipe_Rec_ID_PK PRIMARY KEY (Rec_ID),
CONSTRAINT Recipe_User_ID_FK FOREIGN KEY (User_ID) REFERENCES User(User_ID));


CREATE TABLE Menu
(Rec_ID INTEGER,
Ev_ID INTEGER,
Ev_Rec_Servings_Req INTEGER NOT NULL DEFAULT(0),
CONSTRAINT Menu_Rec_ID_FK FOREIGN KEY (Rec_ID) REFERENCES Recipe(Rec_ID) ON DELETE CASCADE,
CONSTRAINT Menu_Ev_ID_FK FOREIGN KEY (Ev_ID) REFERENCES Event(Ev_ID) ON DELETE CASCADE,
CONSTRAINT Menu_Rec_Ev_ID_PK PRIMARY KEY (Rec_ID, Ev_ID));


CREATE TABLE Rec_Ingred
(Rec_ID INTEGER,
Ing_ID INTEGER,
Rec_Ing_Qty REAL NOT NULL,
Unit_ID INTEGER NOT NULL,
CONSTRAINT Rec_Ingred_Rec_ID_FK FOREIGN KEY (Rec_ID) REFERENCES Recipe(Rec_ID) ON DELETE CASCADE,
CONSTRAINT Rec_Ingred_Ing_ID_FK FOREIGN KEY (Ing_ID) REFERENCES Ingredient(Ing_ID) ON DELETE CASCADE,
CONSTRAINT Rec_Ingred_Unit_ID_FK FOREIGN KEY (Unit_ID) REFERENCES Unit(Unit_ID),
CONSTRAINT Rec_Ingred_Rec_Ing_ID_PK PRIMARY KEY (Rec_ID, Ing_ID));



-- Ingredient table density and unit weight values default to 0 (an error code)
-- Yield defaults to 100%
-- Ing_Unit_Type is a transitive dependency with Ing_Purchase_Unit_ID
CREATE TABLE Ingredient
(Ing_ID INTEGER,
Ing_Name VARCHAR(35) NOT NULL,
Cat_ID INTEGER NOT NULL,
Ing_Density REAL NOT NULL DEFAULT(0),
Ing_Unit_Wt REAL NOT NULL DEFAULT(0),
Ing_Purchase_Unit_ID INTEGER NOT NULL,
Ing_Yield REAL NOT NULL DEFAULT(1),
CONSTRAINT Ingredient_Ing_ID_PK PRIMARY KEY (Ing_ID),
CONSTRAINT Ingredient_Ingcat_ID_FK FOREIGN KEY (Cat_ID) REFERENCES Category(Cat_ID),
CONSTRAINT Ingredient_Ingpur_Unit_ID_FK FOREIGN KEY (Ing_Purchase_Unit_ID) REFERENCES Unit(Unit_ID));



-- View_List_Ingred is virtual table, created from a series of joins across
-- List, Event, Menu, Recipe, Rec_Ingred, Ingredient and Unit

-- CREATE TABLE View_List_Ingred
-- (List_ID INTEGER,
-- Ing_ID INTEGER,
-- Ing_Name VARCHAR(35),
-- List_Ing_Qty INTEGER,
-- Unit_Name VARCHAR(15),
-- CONSTRAINT View_List_Ingred_List_ID_FK FOREIGN KEY (List_ID) REFERENCES List(List_ID),
-- CONSTRAINT View_List_Ingred_Ing_ID_FK FOREIGN KEY (Ing_ID) REFERENCES Ingredient(Ing_ID),
-- CONSTRAINT View_List_Ingred_Listing_PK PRIMARY KEY (List_ID, Ing_ID));

.read InsertCategory.sql
.read InsertUnitType.sql
.read InsertUnit.sql
.read InsertIngredient.sql
.read InsertUser.sql
.read InsertListEventRecipEtc.sql
.read createIndexes.sql

.output stdout

.echo OFF
