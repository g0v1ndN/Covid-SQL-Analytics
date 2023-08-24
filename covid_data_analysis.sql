-- SQL script for database setup, data analysis, and visualization of COVID-19 data.

-- Create a table to store COVID-19 deaths data.
CREATE TABLE IF NOT EXISTS public.covid_deaths
(
    iso_code character varying(10),
    continent character varying(50),
    location character varying(100),
    date date,
    population_density numeric,
    total_cases bigint,
    new_cases bigint,
    new_cases_smoothed numeric,
    total_deaths bigint,
    new_deaths bigint,
    new_deaths_smoothed numeric,
    total_cases_per_million numeric,
    new_cases_per_million numeric,
    new_cases_smoothed_per_million numeric,
    total_deaths_per_million numeric,
    new_deaths_per_million numeric,
    new_deaths_smoothed_per_million numeric
);

-- Import COVID-19 deaths data from a CSV file into the "CovidDeaths" table.
COPY public.covid_deaths FROM 'C:\Users\Govind\Documents\CovidData\CovidDeaths.csv' DELIMITER ',' CSV HEADER;

-- Create a table to store COVID-19 vaccination data.
CREATE TABLE IF NOT EXISTS public.covid_vaccinations (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    total_vaccinations BIGINT,
    people_vaccinated BIGINT,
    people_fully_vaccinated BIGINT,
    new_vaccinations BIGINT,
    new_vaccinations_smoothed BIGINT
);

-- Import COVID-19 vaccination data from a CSV file into the "covid_vaccinations" table.
COPY public.covid_vaccinations FROM 'C:\Users\Govind\Documents\CovidData\CovidVaccinations.csv' DELIMITER ',' CSV HEADER;

-- Retrieve and compare the starting and ending dates of COVID-19 data from both tables to ensure data consistency.
SELECT
    (SELECT MIN(date) FROM public.covid_deaths) AS covid_deaths_start_date,
    (SELECT MAX(date) FROM public.covid_deaths) AS covid_deaths_end_date,
    (SELECT MIN(date) FROM public.covid_vaccinations) AS covid_vaccinations_start_date,
    (SELECT MAX(date) FROM public.covid_vaccinations) AS covid_vaccinations_end_date;
