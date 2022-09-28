USE Groupe_Hotel;

INSERT INTO station(numero_station , nom_station) VALUES (1 , 'Station_1'), (2 ,'Station_Mohamed') , (3 ,'Station_Lea') ;

INSERT INTO Hotel(capacite_hotel , categorie_hotel , nom_hotel , adresse_hotel , num_hotel) VALUES ( 5 , 'Luxe' , 'Hotel_Flot_Bleu' , '30 rue du chat' , '1'  ) , ( 60 , 'detente' , 'Hotel_Jsaispas' , '10 rue des arabes' , '2') ,
(15 , 'sportif' , 'hotel_15' , '20 rue de lea' , '3') ; 

INSERT INTO Chambre( capacite_chambre ,   degre_confort , exposition   , type_chambre , numero_hotel) 
VALUES (4 , 'tres confort' , 'sud' , 'luxe' , '1' ) , (4 , 'tres confort' ,'sud' , 'luxe' , '1' ) , (4 , 'tres confort' , 'sud' , 'luxe' , '1'   ) , 
(  4 , 'tres confort' , 'sud' , 'luxe' , '2' ) , (  4 , 'tres confort' , 'sud' , 'luxe', '2'  ) , (4 , 'tres confort' , 'sud' , 'luxe' , '2'  ) ,
(  4 , 'tres confort' , 'sud' , 'luxe' , '3'  ) , (  4 , 'tres confort' , 'sud' , 'luxe' , '3' ) , (4 , 'tres confort' , 'sud' , 'luxe' , '3'  );