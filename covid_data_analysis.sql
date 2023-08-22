---- SQL script for database setup, data analysis, and visualization of COVID-19 data.

-- Create a table to store COVID-19 deaths data.
CREATE TABLE IF NOT EXISTS public."CovidDeaths"
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
