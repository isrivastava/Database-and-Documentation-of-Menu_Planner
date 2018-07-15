--
.echo on
.headers on

.mode list
.separator "  |  "
.output ReportQueries_Output.txt

--SELECT_USER_EMAIL
SELECT User_Email FROM User;

--SELECT_EVENT
SELECT Ev_Name FROM Event;

--SELECT_EVENT_BY_NAME
SELECT * FROM Event WHERE Ev_Name = "Dinner at Roxies";

--UPDATE_EVENT
UPDATE Event SET Ev_Guests = "4", Ev_Date ="2018-08-21"
WHERE Ev_Name = "Dinner at Roxies";

--ADD EVENT FOR TESTING DELETE_EVENT
INSERT INTO Event (Ev_ID, Ev_Name,Ev_Date,User_ID,Ev_Guests,List_ID)
VALUES (99, "Test Event", "2018-04-24",1,30,1);

--DELETE_EVENT
DELETE FROM Event WHERE Ev_ID = 99;

--SELECT_EVENT_MENU
SELECT Rec_Name,Ev_Rec_Servings_Req
FROM Menu,Recipe
WHERE Menu.Rec_ID = Recipe.Rec_ID
AND  Ev_ID = 2 ;

--SELECT_RECIPE
SELECT Rec_Name FROM Recipe;

--SELECT_RECIPE_BY_NAME
SELECT * FROM Recipe WHERE Rec_Name = "Apple Pie";

--ADD EVENT FOR TESTING ADD RECIPE
INSERT INTO Event (Ev_ID, Ev_Name,Ev_Date,User_ID,Ev_Guests,List_ID)
VALUES (99, "Test Event", "2018-04-24",1,30,1);

--ADD_RECIPE_MENU
INSERT INTO Menu (Rec_ID, Ev_ID, Ev_Rec_Servings_Req)
VALUES (1, 99, 16);

--DELETE_RECIPE_FROM_MENU
DELETE FROM Menu WHERE Ev_ID =99 AND Rec_ID = 1;

--SELECT_LIST
SELECT List_Name FROM List;

--SELECT_LIST_BY_NAME
SELECT * FROM List
 WHERE List_Name = "Yan List";

--ADD LIST FOR TESTING
INSERT INTO List (List_ID, List_Name, User_ID)
VALUES (99,"Test List #1",1);
--DELETE_LIST
DELETE FROM List WHERE List_ID=99;

--SELECT_EVENT_LIST
SELECT Ev_Name,Ev_Guests,Ev_Date FROM Event WHERE Event.List_ID = 1;

--ADD_EVENT_TO_LIST
UPDATE Event SET List_ID = 3 WHERE EV_ID = 4;

--DELETE_EVENT_ FROM_LIST
UPDATE Event SET List_ID = NULL WHERE EV_ID = 2;

--DELETE_RECIPE
DELETE FROM Recipe
WHERE Rec_ID= 1;

--UPDATE_RECIPE_SERVINGS
UPDATE Recipe SET Rec_Servings_Made = 72 WHERE Rec_ID = 2;

--SELECT_INGREDIENT
SELECT Ing_Name FROM Ingredient;

--SELECT_RECIPE_INGREDIENT
SELECT * FROM Rec_Ingred WHERE Rec_ID = 2;

--SELECT_RECIPE_INGREDIENT_DETAIL
SELECT Ing_Name,Rec_Ing_Qty,Unit_Name
FROM Rec_Ingred,Ingredient,Unit
WHERE Rec_Ingred.Ing_Id = Ingredient.Ing_Id
AND Rec_Ingred.Unit_Id = Unit.Unit_Id
AND Rec_ID = 2;


--ADD_ING_TO_REC
INSERT INTO Rec_Ingred(Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_id)
VALUES (2, 32, 48, 2);

--UPDATE_REC_ING_QTY_UNIT
UPDATE Rec_Ingred SET Rec_Ing_Qty = 2, Unit_ID = 2
WHERE Rec_ID = 2
AND Ing_ID = 32;

--DEL_ING_FROM_RECIPE
DELETE FROM Rec_Ingred
WHERE Rec_ID= 2
AND Ing_ID = 32;

--SELECT_UNIT
SELECT Unit_Name FROM Unit;

--SELECT_UNIT_BY_NAME
SELECT * FROM Unit WHERE Unit_Name = "pound";

--SELECT_INGREDIENT_BY_NAME
SELECT Ing_Id FROM Ingredient WHERE Ing_Name = "Wasabi Powder";

--CREATE_SHOPPING_LIST
SELECT  Ing.Ing_Name,
SUM(ROUND(
  CASE WHEN UP.Unit_Type_ID = UR.Unit_Type_ID
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*RI.REC_ING_QTY*UR.Unit_Convfactor/UP.Unit_Convfactor)

  WHEN UP.Unit_Type_ID = 1 AND UR.Unit_Type_ID = 3
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*(RI.REC_ING_QTY*UR.Unit_Convfactor*Ing.Ing_Density)/Ing.Ing_Unit_Wt)

  WHEN UP.Unit_Type_ID = 1 AND UR.Unit_Type_ID = 3
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*(RI.REC_ING_QTY*UR.Unit_Convfactor)/Ing.Ing_Unit_Wt)

  WHEN UP.Unit_Type_ID = 2 AND UR.Unit_Type_ID = 1
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*(RI.REC_ING_QTY*Ing.Ing_Unit_Wt/Ing.Ing_Density)/UP.Unit_Convfactor)

  WHEN UP.Unit_Type_ID = 2 AND UR.Unit_Type_ID = 2
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*(RI.REC_ING_QTY*UR.Unit_Convfactor/Ing.Ing_Density)/UP.Unit_Convfactor)

  WHEN UP.Unit_Type_ID = 3 AND UR.Unit_Type_ID = 1
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*RI.REC_ING_QTY*Ing.Ing_Unit_Wt/UP.Unit_Convfactor)

  WHEN UP.Unit_Type_ID = 3 AND UR.Unit_Type_ID = 2
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*(RI.REC_ING_QTY*UR.Unit_Convfactor*Ing.Ing_Density)/UP.Unit_Convfactor)

  ELSE "Bad Code"
  END,2)) AS QtyReqd,
  UP.Unit_Abbrev AS PurchaseUnits
FROM Ingredient AS Ing
JOIN Unit       AS UP ON UP.Unit_ID = Ing.Ing_Purchase_Unit_ID
JOIN Rec_Ingred AS RI ON Ing.Ing_ID = RI.Ing_ID
JOIN Unit       AS UR ON RI.Unit_ID = UR.Unit_ID
JOIN Recipe     AS R  ON RI.Rec_ID =R.Rec_ID
JOIN Menu       AS M  ON R.Rec_ID = M.Rec_ID
JOIN Event      AS E  ON M.Ev_ID = E.Ev_ID
JOIN List       AS L  ON E.List_ID = L.List_ID
WHERE L.List_ID = "1"
 GROUP BY Ing.Ing_ID
 ORDER BY Ing.Cat_ID ASC;
