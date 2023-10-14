# Covid-SQL-Analytics
<div align="left">
   <a href="https://opensource.org/osd">
      <img src="https://img.shields.io/badge/Open%20Source-%2328a745" alt="open-source"/>
   </a>
   <a href="https://opensource.org/license/mit/">
      <img src="https://img.shields.io/badge/License-MIT-green" alt="mit-license"/>
   </a>
  <a href="https://www.postgresql.org/">
    <img src="https://img.shields.io/badge/PostgreSQL-%23007ACC?logo=postgresql&logoColor=white" alt="PostgreSQL"/>
  </a>
   </div>

## About:
Embarking on my first data science project, this repository documents my progression as I explore SQL-based data analysis using PostgreSQL, with a specific focus on understanding the complexities of Covid-19 data. It hosts my <a href="https://github.com/g0v1ndN/Covid-SQL-Analytics/blob/main/analyze_covid.sql">code</a>, <a href="https://github.com/g0v1ndN/Covid-SQL-Analytics/tree/main/covid_data">curated data</a>, and <a href="https://github.com/g0v1ndN/Covid-SQL-Analytics#observations--findings">observations</a> drawn from detailed query analysis. While I'm on a mission to learn, I'm excited to share this journey openly, creating a resource for anyone eager to learn alongside me.

## Usage Instructions:

### Prerequisites:
- SQL and PostgreSQL Knowledge: A fundamental understanding of SQL concepts and experience with PostgreSQL will be beneficial as you navigate through the queries and analysis presented here.
- Development Environment: Set up a development environment with PostgreSQL installed. You can download PostgreSQL from its <a href="https://www.postgresql.org/">official website</a> and follow the installation instructions provided.
- Basic Data Analysis Skills: Familiarity with data analysis concepts will help you better understand the insights derived from the queries and observations shared in this repository.

### Downloading or Cloning the Repository:
1. Click on the "Code" button on the top right corner of this repository page.
2. Click on "Download ZIP" to download a compressed zip file of the repository.
3. Extract the contents of the zip file to a folder on your computer.

<p align="center"><b> OR </b></p>

1. Open your terminal or command prompt and navigate to the directory where you want to clone the repository.
2. Run the command `git clone https://github.com/g0v1ndN/Covid-SQL-Analytics` to clone the repository to your local machine.
> [!NOTE]
> You need to have Git installed on your computer. If you don't have it installed, please download and install Git from the [official website](https://git-scm.com).

### Exploring the Code: 
If you want to dive deep into the what this repository brings to the table, familiarize yourself with the main analysis code located in the analyze_covid.sql file. This code is split into three key parts:

1. Initial Setup Queries: These queries establish the foundation by creating the necessary database, tables, and importing the Covid-19 data.
2. Data Analysis Queries for India: This section contains SQL queries tailored to analyzing Covid-19 data specific to India. 
3. Global COVID-19 Data Analysis Queries: This segment comprises SQL queries aimed at dissecting and analyzing the global COVID-19 data landscape. It provides insight to cross-country comparisons and trends in the pandemic's data.

## Observations & Findings:

### Understanding the COVID-19 Situation in India
- COVID-19 was first reported in India on <b>January 30, 2020</b>.
- As of the latest data, the infection percentage in India is <b>3.18%</b>, indicating a relatively <b>moderate spread</b> of COVID-19 within the population.
- The peak of new COVID-19 cases was recorded on <b>May 2021</b>, with a notable count of <b>9,284,558</b> new cases.
- Currently, the mortality rate in India stands at <b>1.18%</b>, indicating a comparatively low fatality rate among confirmed cases.
- <b>72.50%</b> of the population in India has received at least one dose of the Covid-19 vaccine, and <b>67.17%</b> are fully vaccinated.
- India has reported a significant number of COVID-19 deaths, totaling <b>531,922</b>, which corresponds to <b>0.04%</b> of its population.

### Global COVID-19 Landscape

#### COVID-19 Outbreak and Global Data:
- The COVID-19 outbreak, which originated in <b>China</b>, was officially reported on <b>January 4, 2020</b>.
- The latest data reveals a COVID-19 infection rate of approximately <b>9.65%</b>.
- It also discloses a mortality rate of <b>0.90%</b>, reflecting a relatively low fatality rate among confirmed cases.

#### Infection Statistics:  
- As of the current data, the <b>top 5 hotspots</b> with the highest infection percentages are Cyprus (73.76%), San Marino (72.37%), Brunei (69.09%), Austria (68.03%), and South Korea (65.42%).
- In contrast, North Korea and Turkmenistan have <b>zero cases</b>, while Yemen, Niger, and Chad share the lowest infection rate of <b>0.04%</b>.
- The highest number of new COVID-19 cases globally occurred on <b>January 2022</b>, with a total of <b>91,806,015</b> new cases reported.

#### Vaccination Statistics:
- Notably, vaccinations have been administered to more than <b>5.6 billion people</b>, accounting for <b>70.48%</b> of the population.
- Gibraltar, Tokelau, United Arab Emirates, Qatar, Nauru, Brunei, and Pitcairn have successfully attained vaccination percentages exceeding <b>99%</b>.
- Vaccination rates vary across <b>income categories</b>, with 32.54% of low-income, 79.86% of high-income, 66.28% of lower-middle-income, and 83.42% of upper-middle-income individuals having been vaccinated at least once.

#### Regional Deaths and COVID-19 Toll:
- Peru, Bulgaria, Bosnia and Herzegovina, Hungary, and North Macedonia exhibit higher death percentages, with rates ranging from <b>0.47% to 0.65%</b>.
- North America leads with the highest death count (1,127,152), followed by South America (704,659), Asia (531,922), Europe (399,938), Africa (102,595) and Oceania (22,618) on a <b>continental basis</b>.
- The <b>countries</b> with the highest COVID-19 death toll are as follows: United States (1,127,152 deaths), Brazil (704,659 deaths), India (531,922 deaths), Russia (399,938 deaths), and Mexico (334,336 deaths).

<b>Note:</b> The data used in this project covers the period from January 1, 2020 to August 16, 2023. Please note that the source website's data might have been updated since the start of this project.

## External Resources:

### Data Inclusion
- **Data Source:** Our World in Data
- **Citation:** Edouard Mathieu, Hannah Ritchie, Lucas Rodés-Guirao, Cameron Appel, Charlie Giattino, Joe Hasell, Bobbie Macdonald, Saloni Dattani, Diana Beltekian, Esteban Ortiz-Ospina, and Max Roser (2020) - "Coronavirus Pandemic (COVID-19)". Published online at <a href="https://ourworldindata.org">OurWorldInData.org</a>.
- **License:** CC-BY-4.0 License

The Creative Commons Attribution (CC-BY) License is an open-source license that permits usage, modification, and distribution of the content, provided you attribute the original creator.

## MIT License: 
Hello! If you're interested in using my code, I'm happy to share it with you under the <a href="https://github.com/g0v1ndN/Covid-SQL-Analytics/blob/main/LICENSE">MIT License</a>. This license is fairly permissive, which means that you can use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of my code without restriction, as long as you include the original copyright notice and disclaimer in your own code. Additionally, I provide no warranties or guarantees for my code, so you use it at your own risk. I hope this helps, and happy coding!
