Cheval : 
date_naissance            DATE;
numero_enregistrement     VARCHAR(10) PRIMARY KEY;
mére_cheval               VARCHAR(30);
race_cheval               VARCHAR(10);
couleur_cheval            VARCHAR(15);
sexe_cheval               VARCHAR(1);
ville_naissance_cheval    VARCHAR(50);
date_achat_cheval                DATE; 
date_entrainement_cheval         DATE; 
date_derniere_vaccinaiton        DATE;
date_prochaine_vaccination       DATE;


Proprio 
numero_proprio           VARCHAR(10) PRIMARY KEY; 
code_postal_proprio      VARCHAR(6);
ville_proprio            VARCHAR(30);
rue_proprio              VARCHAR(30);

