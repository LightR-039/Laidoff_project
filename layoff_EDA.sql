-- DATA EXPLORATION 

SELECT * FROM layoffs_staging2
ORDER BY company ASC;

SELECT MAX(total_laid_off), MIN(total_laid_off), AVG(percentage_laid_off), MAX(funds_raised_millions),
AVG(funds_raised_millions)
FROM layoffs_staging2
;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC
;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC
;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC
;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC
;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC
;

-- ROLLING total_laid_off

SELECT SUBSTRING(`date`,1,7) mth, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY mth
ORDER BY 1 ASC
;

WITH roll_total AS
(
SELECT SUBSTRING(`date`,1,7) mth, SUM(total_laid_off) total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY mth
ORDER BY 1 ASC
)
SELECT mth, total_off,
SUM(total_off) OVER(ORDER BY mth) as rolling_total
FROM roll_total
;

-- company by year

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
;

WITH company_year (company,years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY company, YEAR(`date`)
), company_ranking as
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) ranking
FROM company_year
)
SELECT * FROM company_ranking
WHERE ranking < 6
;















