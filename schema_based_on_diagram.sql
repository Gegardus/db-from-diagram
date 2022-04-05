CREATE DATABASE clinic;

CREATE TABLE patients (
id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name varchar(255),
date_of_birth date
);


CREATE TABLE medical_histories (
id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
admitted_at timestamp,
patient_id int,
status varchar(255),
ADD CONSTRAINT fk_patients
FOREIGN KEY(patient_id) 
REFERENCES patients(id)
ON DELETE CASCADE;
);


CREATE TABLE invoices (
id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
total_amount decimal,
generated_at timestamp,
payed_at timestamp,
medical_history_id int,
ADD CONSTRAINT fk_medical_histories
FOREIGN KEY(medical_history_id) 
REFERENCES medical_histories(id)
ON DELETE CASCADE;
);


CREATE TABLE treatments(
id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
type varchar(255),
name varchar(255)
);


CREATE TABLE invoice_items(
id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
unit_price decimal,
quantity int,
total_price decimal,
invoice_id int,
treatment_id int,
ADD CONSTRAINT fk_invoices
FOREIGN KEY(invoice_id) 
REFERENCES invoices(id)
ON DELETE CASCADE;,
ADD CONSTRAINT fk_treatments
FOREIGN KEY(treatment_id) 
REFERENCES treatments(id)
ON DELETE CASCADE;
);

CREATE TABLE medical_histories_treatments (
med_histories_id int,
treatment_id int,
ADD CONSTRAINT fk_medical_histories
FOREIGN KEY (med_histories_id) 
REFERENCES medical_histories(id)
ON DELETE RESTRICT ON UPDATE CASCADE,,
ADD CONSTRAINT fk_treatments
FOREIGN KEY (treatment_id) 
REFERENCES treatments(id)
ON DELETE RESTRICT ON UPDATE CASCADE,
);

CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON medical_histories_treatments (med_histories_id);
CREATE INDEX ON medical_histories_treatments (treatment_id);

