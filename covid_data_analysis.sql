-- SQL script for database setup, data analysis, and visualization of COVID-19 data.

-- Create a table to store COVID-19 deaths data.
CREATE TABLE IF NOT EXISTS public.covid_deaths
(
    iso_code character varying(10),
    continent character varying(50),
    location character varying(100),
    date date,
    population bigint,
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

-- Import COVID-19 deaths data from a CSV file into the "covid_deaths" table.
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

-- Calculates and format the death percentage for Covid-related data in India.
SELECT
    location,
    date,
    total_cases,
    total_deaths,
    ROUND((total_deaths::numeric / total_cases) * 100, 2) AS death_percentage
FROM
    public.covid_deaths
WHERE
    location = 'India'
    AND date = '2023-08-16'
ORDER BY
    1, 2;

-- Calculate the percentage of population infected with COVID-19 in India.
SELECT
    location,
    date,
    population,
    total_cases,
    ROUND((total_cases::numeric / population) * 100, 2) AS percent_population_infected
FROM
    public.covid_deaths
WHERE
    location = 'India'
    AND date = '2023-08-16'
ORDER BY
    1, 2;

-- Calculate the vaccination percentage for India.
SELECT
    v.location AS country,                  
    v.date,                                 
    d.population,                           
    v.people_vaccinated,                    
    ROUND((v.people_vaccinated::numeric / d.population) * 100, 2) AS vaccination_percentage                                           
FROM
    public.covid_vaccinations v             
JOIN
    public.covid_deaths d                   
    ON v.location = d.location              
    AND v.date = d.date
WHERE
    v.location = 'India'              
    AND v.date = '2023-08-16'               
ORDER BY
    1, 2;                                   

-- Retrieve the complete vaccination percentage for India.
SELECT
    v.location AS country,
    v.date,
    d.population,
    v.people_fully_vaccinated,
ROUND((v.people_fully_vaccinated::numeric / d.population) * 100, 2) AS fully_vaccination_percentage
FROM
    public.covid_vaccinations v
JOIN
    public.covid_deaths d ON v.location = d.location AND v.date = d.date
WHERE
    v.location = 'India'
    AND v.date = '2023-08-16'
ORDER BY
    1, 2;

-- Calculate the percentage of the population that is globally infected by COVID-19.
SELECT
    location,
    population,
    ROUND((MAX(total_cases)::numeric / population) * 100, 2) AS percent_population_infected 
FROM
    public.covid_deaths
GROUP BY
    location, population
ORDER BY
    percent_population_infected DESC NULLS LAST;

-- Retrieve the maximum recorded COVID-19 death count for each continent.
SELECT
    continent,
    MAX(total_deaths::numeric) AS total_death_count
FROM
    public.covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY
    continent
ORDER BY
    total_death_count DESC;

-- Examine locations based on their highest recorded COVID-19 death counts.
SELECT
    location,
    COALESCE(MAX(total_deaths), 0) AS max_total_deaths
FROM
    public.covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY
    location
ORDER BY
    max_total_deaths DESC;

-- Calculate the mortality rate of COVID-19 as of today.
SELECT
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    ROUND(SUM(new_deaths::numeric) / SUM(new_cases) * 100, 2) AS mortality_rate
FROM
    public.covid_deaths
WHERE
    continent IS NOT NULL
    AND date <= '2023-08-16'
ORDER BY
    total_cases, total_deaths;

-- Retrieve data of people vaccinated from different income strata on August 16, 2023.
SELECT
    v.location AS category,
    v.date,
    d.population,
    v.people_vaccinated,
    ROUND((v.people_vaccinated::numeric / d.population) * 100, 2) AS vaccination_percentage
FROM
    public.covid_vaccinations v
JOIN
    public.covid_deaths d ON v.location = d.location AND v.date = d.date
WHERE
    v.location ILIKE '%income%'
    AND v.date = '2023-08-16'
ORDER BY
    1, 2;

-- This query retrieves data for the "Low income" strata with its maximum date used.
-- Addresses missing data for the "Low income" category in the last query.
SELECT
    v.location AS category,
    MAX(v.date) AS max_date_used,
    d.population,
    v.people_vaccinated,
    ROUND((v.people_vaccinated::numeric / d.population) * 100, 2) AS vaccination_percentage
FROM
    public.covid_vaccinations v
JOIN
    public.covid_deaths d ON v.location = d.location AND v.date = d.date
WHERE
    v.location = 'Low income'
GROUP BY
    v.location, d.population, v.people_vaccinated
ORDER BY
    max_date_used DESC NULLS LAST;
