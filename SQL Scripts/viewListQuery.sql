--viewListQuery.sql

.headers on
--.mode csv
--.output viewListQuery_Output.csv

.mode list
.separator "  |  "
.output viewListQuery_Output.txt



SELECT  Ing.Ing_Name,

  SUM(ROUND(
  CASE
  -- Case 1-1, 2-2, 3-3, Same UnitType for Rec_Ingred and Purchase Units
  WHEN UP.Unit_Type_ID = UR.Unit_Type_ID
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*RI.REC_ING_QTY*UR.Unit_Convfactor/UP.Unit_Convfactor)

  -- Case 1-2 Purchase Unit Type = Count && Rec_Ingred Unit Type = VOL
  WHEN UP.Unit_Type_ID = 1 AND UR.Unit_Type_ID = 3
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*
  (RI.REC_ING_QTY*UR.Unit_Convfactor*Ing.Ing_Density)/Ing.Ing_Unit_Wt)

  -- Case 1-3 Purchase Unit Type = Count && Rec_Ingred Unit Type = WEIGHT
  WHEN UP.Unit_Type_ID = 1 AND UR.Unit_Type_ID = 3
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*RI.REC_ING_QTY*UR.Unit_Convfactor)/Ing.Ing_Unit_Wt

  -- Case 2-1 - Purchase Unit Type = Volume, Rec_ingred Unit type = Count
  WHEN UP.Unit_Type_ID = 2 AND UR.Unit_Type_ID = 1
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*
  (RI.REC_ING_QTY*Ing.Ing_Unit_Wt/Ing.Ing_Density)/UP.Unit_Convfactor)

  -- Case 2-3 - Purchase Unit Type = Volume, Rec-Ingred Unit Type = Weight
  WHEN UP.Unit_Type_ID = 2 AND UR.Unit_Type_ID = 2
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*
  (RI.REC_ING_QTY*UR.Unit_Convfactor/Ing.Ing_Density)/UP.Unit_Convfactor)

  -- Case 3-1 - Purchase Unit Type = Wt, Rec_ingred Unit type = Count
  WHEN UP.Unit_Type_ID = 3 AND UR.Unit_Type_ID = 1
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*RI.REC_ING_QTY*Ing.Ing_Unit_Wt/UP.Unit_Convfactor)

  -- Case 3-2 - Purchase Unit Type = Wt, Rec_ingred Unit type = Volume
  WHEN UP.Unit_Type_ID = 3 AND UR.Unit_Type_ID = 2
  THEN (ROUND(.4999+CAST(M.Ev_Rec_Servings_Req AS REAL)/CAST(R.Rec_Servings_Made AS REAL),0)*(RI.REC_ING_QTY*UR.Unit_Convfactor*Ing.Ing_Density)/UP.Unit_Convfactor)
    ELSE "Bad Code"

  END,2)) AS QtyReqd, UP.Unit_Abbrev AS PurchaseUnits

  FROM Ingredient AS Ing
  JOIN Unit       AS UP ON UP.Unit_ID = Ing.Ing_Purchase_Unit_ID
  JOIN Rec_Ingred AS RI ON Ing.Ing_ID = RI.Ing_ID
  JOIN Unit       AS UR ON RI.Unit_ID = UR.Unit_ID
  JOIN Recipe     AS R  ON RI.Rec_ID =R.Rec_ID
  JOIN Menu       AS M  ON R.Rec_ID = M.Rec_ID
  JOIN Event      AS E  ON M.Ev_ID = E.Ev_ID
  JOIN List       AS L  ON E.List_ID = L.List_ID
  WHERE L.List_ID = 5
  GROUP BY Ing.Ing_ID
  ORDER BY Ing.Cat_ID ASC
  ;
