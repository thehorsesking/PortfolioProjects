SELECT * 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

--SELECT * 
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--Select Data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

--Looking at total cases vs total deaths

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%state%'
AND continent IS NOT NULL
ORDER BY 1,2

--looking at the total cases vs population

SELECT Location, date, population, total_cases,  ROUND((total_cases/population)*100,6) AS case_percentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

--looking at countries with highest infection rate compared to population

SELECT Location, population, MAX(total_cases) AS highest_infection_count,  MAX((total_cases/population)*100) AS case_percentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
GROUP BY location , population
ORDER BY 4 DESC;

--showing countries with highest death count per population

SELECT Location, MAX(cast(total_deaths AS INT)) AS highest_death_count
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY location 
ORDER BY highest_death_count DESC;

--showing continents with highest death count per population

SELECT continent, MAX(cast(total_deaths AS INT)) AS highest_death_count
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent IS NULL
GROUP BY continent
ORDER BY highest_death_count DESC;

--global numbers

SELECT date, SUM(new_cases) AS total_cases, SUM(cast(new_deaths AS INT)) AS total_deaths , SUM(cast(new_deaths AS INT))/SUM(new_cases)*100 AS death_percentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%state%'
Where continent IS NOT NULL
GROUP  BY date
ORDER BY death_percentage DESC

--join

SELECT * 
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location=vac.location
	AND dea.date=vac.date

--looking at total population vs vac


SELECT dea.continent, dea.location, dea.date, dea.population , vac.new_vaccinations AS new_vac
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

--looking at total population vs vac


SELECT dea.continent, dea.location, dea.date, dea.population , vac.new_vaccinations AS new_vac
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

--Use CTE

with popvsvac (continent, location, date, population,new_vaccinations, rolling)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population , vac.new_vaccinations AS new_vac
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *,(rolling/population)*100 AS rollperc
FROM popvsvac

--TEMp table

DROP TABLE IF EXISTS #perpopvac
CREATE TABLE #perpopvac
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rolling numeric
)

INSERT INTO #perpopvac
SELECT dea.continent, dea.location, dea.date, dea.population , vac.new_vaccinations AS new_vac
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *,(rolling/population)*100 AS rollperc
FROM #perpopvac

--creating view for visualization

CREATE VIEW percentpopvac AS

SELECT dea.continent, dea.location, dea.date, dea.population , vac.new_vaccinations AS new_vac
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3


SELECT * 
FROM percentpopvac