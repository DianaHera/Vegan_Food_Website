DROP TYPE IF EXISTS categ_alimente;
DROP TYPE IF EXISTS tipuri_alimente;

CREATE TYPE categ_alimente AS ENUM('aliment','bautura','supliment');
CREATE TYPE tipuri_alimente AS ENUM('bauturi','condimente','dulciuri','gustări','conserve','produse vegane','suplimente alimentare',);


CREATE TABLE IF NOT EXISTS alimente (
   id serial PRIMARY KEY,  --seral = auto increment
   nume VARCHAR(50) UNIQUE NOT NULL,
   descriere TEXT,
   pret NUMERIC(8,2) NOT NULL,
   gramaj INT NOT NULL CHECK (gramaj>=0),   
   tip_aliment tipuri_alimente,  --col:tip_produs, tipul de date al coloanei: tipuri_produse, default:val pe care o ia by default
   calorii INT NOT NULL CHECK (calorii>=0),
   categorie categ_alimente,
   ingrediente VARCHAR [], --pot sa nu fie specificare deci nu punem NOT NULL
   pt_diabetici BOOLEAN NOT NULL DEFAULT FALSE,
   imagine VARCHAR(300),  --decat se memoram fisiere mai bine memoram calea
   data_adaugare TIMESTAMP DEFAULT current_timestamp  --data de expirare cred
);

/**/
INSERT INTO alimente (nume, descriere, pret, gramaj, tip_aliment, calorii, categorie, ingrediente, pt_diabetici, imagine) VALUES
('Apă minerală', 'Apă minerală naturală carbogazoasă', 2.50, 500, 'bauturi', 0, 'bautura', '{"apă minerală"}', FALSE, 'imagini/apa_minerala.jpg'),
('Sare de mare', 'Sare de mare grunjoasă', 5.00, 1000, 'condimente', 0, 'aliment', '{"sare de mare"}', TRUE, 'imagini/sare_mare.jpg'),
('Ciocolată neagră', 'Ciocolată neagră cu 70% cacao', 10.00, 100, 'dulciuri', 500, 'aliment', '{"cacao", "zahăr"}', FALSE, 'imagini/ciocolata_neagra.jpg'),
('Chipsuri', 'Chipsuri din cartofi cu sare', 7.00, 150, 'gustări', 550, 'aliment', '{"cartofi", "ulei", "sare"}', FALSE, 'imagini/chipsuri.jpg'),
('Conservă de ton', 'Conservă de ton în ulei vegetal', 12.00, 185, 'conserve', 250, 'aliment', '{"ton", "ulei vegetal"}', TRUE, 'imagini/conserva_ton.jpg'),
('Lapte de soia', 'Lapte de soia natural', 8.00, 1000, 'produse vegane', 50, 'bautura', '{"apă", "soia"}', TRUE, 'imagini/lapte_soia.jpg'),
('Proteine vegetale', 'Supliment proteic pe bază de mazăre', 75.00, 500, 'suplimente alimentare', 400, 'supliment', '{"mazăre"}', TRUE, 'imagini/proteine_vegetale.jpg'),
('Ceai verde', 'Ceai verde natural', 15.00, 100, 'bauturi', 0, 'bautura', '{"ceai verde"}', TRUE, 'imagini/ceai_verde.jpg'),
('Piper negru', 'Piper negru măcinat', 5.00, 50, 'condimente', 0, 'aliment', '{"piper negru"}', TRUE, 'imagini/piper_negru.jpg'),
('Prăjiturele', 'Prăjiturele cu ovăz și ciocolată', 10.00, 200, 'dulciuri', 600, 'aliment', '{"ovăz", "ciocolată", "zahăr"}', FALSE, 'imagini/prajiturele.jpg'),
('Mix de nuci', 'Mix de nuci și fructe uscate', 25.00, 250, 'gustări', 700, 'aliment', '{"nuci", "fructe uscate"}', TRUE, 'imagini/mix_nuci.jpg'),
('Mazare conservată', 'Mazare verde în apă sărată', 6.00, 400, 'conserve', 100, 'aliment', '{"mazăre", "apă", "sare"}', TRUE, 'imagini/mazare_conservata.jpg'),
('Tofu', 'Tofu natural', 12.00, 300, 'produse vegane', 200, 'aliment', '{"soia"}', TRUE, 'imagini/tofu.jpg'),
('Tofu afumat', 'Tofu natural afumat', 13.00, 300, 'produse vegane', 200, 'aliment', '{"soia"}', TRUE, 'imagini/tofu.jpg'),
('Vitamina C', 'Supliment cu vitamina C 1000mg', 30.00, 100, 'suplimente alimentare', 0, 'supliment', '{"vitamina C"}', TRUE, 'imagini/vitamina_c.jpg'),
('Suc de portocale', 'Suc de portocale natural fără zahăr', 12.00, 1000, 'bauturi', 50, 'bautura', '{"portocale"}', TRUE, 'imagini/suc_portocale.jpg'),
('Scorțișoară', 'Scorțișoară măcinată', 7.00, 50, 'condimente', 0, 'aliment', '{"scorțișoară"}', TRUE, 'imagini/scortisoara.jpg'),
('Biscuiți', 'Biscuiți digestivi', 8.00, 300, 'dulciuri', 450, 'aliment', '{"făină integrală", "zahăr", "unt"}', FALSE, 'imagini/biscuiti.jpg'),
('Popcorn', 'Popcorn sărat', 5.00, 100, 'gustări', 400, 'aliment', '{"porumb", "ulei", "sare"}', FALSE, 'imagini/popcorn.jpg'),
('Conservă de fasole', 'Fasole roșie în sos tomat', 9.00, 400, 'conserve', 150, 'aliment', '{"fasole", "sos tomat"}', TRUE, 'imagini/conserva_fasole.jpg'),
('Omega 3', 'Supliment cu omega 3 din ulei de pește', 50.00, 100, 'suplimente alimentare', 0, 'supliment', '{"ulei de pește"}', TRUE, 'imagini/omega_3.jpg'),
('Boia dulce', 'Boia dulce măcinată', 5.00, 50, 'condimente', 0, 'aliment', '{"boia"}', TRUE, 'imagini/boia_dulce.jpg'),
('Prăjitură vegană', 'Prăjitură vegană cu ciocolată', 15.00, 100, 'dulciuri', 300, 'aliment', '{"ciocolată vegană", "făină", "zahăr"}', FALSE, 'imagini/prajitura_vegana.jpg'),
('Covrigei', 'Covrigei sărați', 4.00, 200, 'gustări', 450, 'aliment', '{"făină", "sare"}', FALSE, 'imagini/covrigei.jpg'),
('Conservă de porumb', 'Porumb dulce în apă sărată', 5.00, 300, 'conserve', 100, 'aliment', '{"porumb", "apă", "sare"}', TRUE, 'imagini/conserva_porumb.jpg'),
('Complex de vitamine', 'Supliment complex de vitamine', 60.00, 100, 'suplimente alimentare', 0, 'supliment', '{"vitamine mix"}', TRUE, 'imagini/complex_vitamine.jpg'),
('Rozmarin', 'Rozmarin uscat', 5.00, 30, 'condimente', 0, 'aliment', '{"rozmarin"}', TRUE, 'imagini/rozmarin.jpg');








/*INSERT into alimente2 (nume, descriere, pret, gramaj, calorii, tip_aliment, categorie, ingrediente, pt_diabetici, imagine) VALUES 
('Naut', 'Naut la conserva', 3.5 , 200, 400, 'aliment', 'vegan', '{"naut","apa","sare","conservant"}', False, 'aproximativ-savarina.jpg'),

('Faina de migdale', 'Faina facuta din migdale', 10 , 250, 400, 'aliment', 'fainoase', '{"migdale"}', True, 'posibil-amandina.jpg'),

('Ulei de masline', 'Ulei de masline', 40 , 750, 2500, 'aliment', 'ulei', '{"masline"}', True,'tort-glazurat.jpg'),

('Za atar', 'Mix de condimente arabesc', 10 , 30, 20, 'aliment', 'condimente', '{"susan", "cimbru", "oregano", "maghiran", "sare"}', True,'dulcelind.jpg');*/

