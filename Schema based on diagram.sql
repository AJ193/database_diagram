/* Database schema to keep the structure of entire database. */
CREATE TABLE "patients" (
  "id" int,
  "name" varchar,
  "date_of_birth" date,
  PRIMARY KEY ("id")
);

CREATE TABLE "medical_histories" (
  "id" int,
  "admitted_at" timestamp,
  "patient_id" int REFERENCES patients("id"), -- Specify the referenced column
  "status" varchar,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_medical_histories_patient_id" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") -- Corrected constraint name and syntax
);

CREATE INDEX ON "medical_histories" (patient_id);

CREATE TABLE "treatments" (
  "id" int,
  "type" varchar,
  "name" varchar,
  PRIMARY KEY ("id")
);

CREATE TABLE "invoices" (
  "id" int,
  "total_amount" decimal,
  "generated_at" timestamp,
  "payed_at" timestamp,
  "medical_history_id" int REFERENCES "medical_histories"(id),
  PRIMARY KEY ("id")
);

CREATE INDEX ON "invoices" (medical_history_id);

CREATE TABLE "invoice_items" (
  "id" int,
  "unit_price" decimal,
  "quantity" int,
  "total_price" decimal,
  "invoice_id" int REFERENCES "invoices"(id),
  "treatment_id" int REFERENCES "treatments"(id),
  PRIMARY KEY (id),
  CONSTRAINT "FK_invoice_items_invoice_id" FOREIGN KEY (invoice_id) REFERENCES "invoices"(id)
);


CREATE INDEX ON "invoice_items" (invoice_id);
CREATE INDEX ON "treatments" (id);

CREATE TABLE "diagnosis" (
    treatment_id int REFERENCES treatments NOT NULL,
    history_id int REFERENCES medical_histories NOT NULL,
    PRIMARY KEY(treatment_id,  history_id)
);

CREATE INDEX ON "diagnosis" (treatment_id);

CREATE INDEX ON "diagnosis" (history_id);