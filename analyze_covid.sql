/* 
SQL script for database setup, data analysis, and visualization of COVID-19 data.
Showcases SQL skills in database management, data import, aggregation, table joins, calculation, subqueries, filtering, result ordering, and data analysis.
*/


-- Initial Setup Queries:

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

-- End of Initial Setup Queries.


-- Data Analysis Queries for India:

-- Calculate the date when Covid was first reported in India.
SELECT
    location,
    MIN(date) AS first_reported_date
FROM
    public.covid_deaths
WHERE
    location = 'India'
    AND total_cases > 0
GROUP BY
    location;

-- Calculate and format the percentage of population infected with COVID-19 in India.
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

-- Calculates monthly new cases in India, sorted by highest counts.
SELECT
    DATE_TRUNC('month', date) AS month,
    SUM(new_cases) AS total_new_cases
FROM
    public.covid_deaths
WHERE
    location = 'India'
GROUP BY
    month
ORDER BY
    total_new_cases DESC;

-- Calculates and format the mortality rate for Covid-related data in India.
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

-- Calculate total deaths and death percentage for India.
SELECT
    SUM(new_deaths) AS total_deaths,
    ROUND(SUM(new_deaths)::numeric / (SELECT population FROM public.covid_deaths WHERE location = 'India' LIMIT 1) * 100, 2) AS death_percentage
FROM
    public.covid_deaths
WHERE
    location = 'India'
    AND new_cases > 0;

-- End of Data Analysis Queries for India.


-- Global COVID-19 Data Analysis Queries:

-- Find the location and date of the first reported COVID-19 case globally.
SELECT
    location,
    MIN(date) AS first_reported_date
FROM
    public.covid_deaths
WHERE
    continent IS NOT NULL
    AND total_cases > 0
GROUP BY
    location
ORDER BY
    first_reported_date
LIMIT 1;

-- Calculate the infection rate of COVID-19 as of today.
SELECT
    SUM(new_cases) AS total_cases,
    population,
    ROUND(SUM(new_cases::numeric) / population * 100, 2) AS infection_rate
FROM
    public.covid_deaths
WHERE
    location = 'World'
    AND date <= '2023-08-16'
GROUP BY
    population;

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

-- Calculates monthly new cases globally, sorted by highest counts.
SELECT
    DATE_TRUNC('month', date) AS month,
    SUM(new_cases) AS total_new_cases
FROM
    public.covid_deaths
WHERE
    location = 'World'
GROUP BY
    month
ORDER BY
    total_new_cases DESC;

-- Retrieve vaccination data and calculate global vaccination percentage.
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
    v.location = 'World'              
    AND v.date = '2023-08-16'               
ORDER BY
    1, 2; 

-- Retrieves the latest COVID-19 vaccination percentages for countries based on population.
SELECT
    v.location AS country,
    MAX(v.date) AS date,
    d.population,
    MAX(v.people_vaccinated) AS people_vaccinated,
    ROUND((MAX(v.people_vaccinated)::numeric / d.population) * 100, 2) AS vaccination_percentage
FROM
    public.covid_vaccinations v
JOIN
    public.covid_deaths d ON v.location = d.location AND v.date = d.date
WHERE
    v.continent IS NOT NULL
    AND v.date <= '2023-08-16'
    AND v.people_vaccinated IS NOT NULL
GROUP BY
    v.location, d.population
ORDER BY
    vaccination_percentage DESC;

-- Retrieve data of people vaccinated from different income strata.
SELECT DISTINCT ON (v.location)
    v.location AS category,
    MAX(v.date) AS max_vaccination_date,
    d.population,
    v.people_vaccinated,
    ROUND(v.people_vaccinated::numeric / d.population * 100, 2) AS vaccination_percentage
FROM
    public.covid_vaccinations v
JOIN
    public.covid_deaths d ON v.location = d.location AND v.date = d.date
WHERE
    v.location ILIKE '%income%'
GROUP BY
    v.location, d.population, v.people_vaccinated
ORDER BY
    v.location, max_vaccination_date DESC;

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
    max_date_used DESC;

-- Calculate the death percentage of the population based on COVID-19 data.
SELECT
    location,
    population,
    ROUND((MAX(total_deaths)::numeric / population) * 100, 2) AS death_percentage 
FROM
    public.covid_deaths
GROUP BY
    location, population
ORDER BY
    death_percentage DESC NULLS LAST;

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

-- Examine countries based on their highest recorded COVID-19 death counts.
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

-- End of Global COVID-19 Data Analysis Queries.
