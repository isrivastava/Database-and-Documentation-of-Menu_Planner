INSERT INTO List (List_ID, List_Name, User_ID)
VALUES (1,"Admin List",1);

INSERT INTO List (List_ID, List_Name, User_ID)
VALUES (2,"Yan List",2);

INSERT INTO List (List_ID, List_Name, User_ID)
VALUES (3,"Roxie List",3);

INSERT INTO List (List_ID, List_Name, User_ID)
VALUES (4,"Isha List",4);

INSERT INTO List (List_ID, List_Name, User_ID)
VALUES (5,"Scott List",5);


INSERT INTO Event (Ev_ID, Ev_Name,Ev_Date,User_ID,Ev_Guests,List_ID)
VALUES (1, "Company Launch Party", "2018-04-24",1,30,1);

INSERT INTO Event (Ev_ID, Ev_Name,Ev_Date,User_ID,Ev_Guests,List_ID)
VALUES (2, "Brunch at Yans", "2018-04-21",2,4,2);

INSERT INTO Event (Ev_ID, Ev_Name,Ev_Date,User_ID,Ev_Guests,List_ID)
VALUES (3, "Dinner at Roxies", "2018-04-21",3,4,3);

INSERT INTO Event (Ev_ID, Ev_Name,Ev_Date,User_ID,Ev_Guests,List_ID)
VALUES (4, "Drinks at Ishas", "2018-04-21",4,4,4);

INSERT INTO Event (Ev_ID, Ev_Name,Ev_Date,User_ID,Ev_Guests,List_ID)
VALUES (5, "Dessert at Scotts", "2018-04-21",5,4,5);


INSERT INTO Recipe (Rec_ID, Rec_Name, Rec_Servings_Made, User_ID)
VALUES (1, "Scrambled Eggs", 2, 1);

INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (1,71,4,1);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (1,102,2,7);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (1,22,1,7);


INSERT INTO Recipe (Rec_ID, Rec_Name, Rec_Servings_Made, User_ID)
VALUES (2, "Quiche", 8, 3);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (2,71,12,1);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (2,102,1,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (2,22,8,7);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (2,105,2,9);

INSERT INTO Recipe (Rec_ID, Rec_Name, Rec_Servings_Made, User_ID)
VALUES (3, "Pancakes", 4, 2);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (3,71,3,1);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (3,75,2,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (3,167,3,7);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (3,102,1,9);

INSERT INTO Recipe (Rec_ID, Rec_Name, Rec_Servings_Made, User_ID)
VALUES (4, "Chocolate Cake", 10, 2);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (4,71,6,1);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (4,75,8,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (4,167,2,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (4,55,1,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (4,102,1,9);

INSERT INTO Recipe (Rec_ID, Rec_Name, Rec_Servings_Made, User_ID)
VALUES (5, "Apple Pie", 6, 5);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (5,4,6,1);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (5,75,2,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (5,167,3,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (5,22,1,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (5,165,1,9);

INSERT INTO Recipe (Rec_ID, Rec_Name, Rec_Servings_Made, User_ID)
VALUES (6, "Noodle Kugel", 12, 5);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (6,165,2,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (6,167,2,9);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (6,22,1,14);
INSERT INTO Rec_Ingred (Rec_ID, Ing_ID, Rec_Ing_Qty, Unit_ID)
VALUES (6,110,2,14);


INSERT INTO Menu (Rec_ID, Ev_ID, Ev_Rec_Servings_Req)
VALUES (4,1,30);

INSERT INTO Menu (Rec_ID, Ev_ID, Ev_Rec_Servings_Req)
VALUES (1,2,4);

INSERT INTO Menu (Rec_ID, Ev_ID, Ev_Rec_Servings_Req)
VALUES (2,2,4);

INSERT INTO Menu (Rec_ID, Ev_ID, Ev_Rec_Servings_Req)
VALUES (3,2,2);

INSERT INTO Menu (Rec_ID, Ev_ID, Ev_Rec_Servings_Req)
VALUES (5,5,2);

INSERT INTO Menu (Rec_ID, Ev_ID, Ev_Rec_Servings_Req)
VALUES (6,5,2);
