-- DATA CLEANNING

SELECT * FROM layoffs;

-- REMOVE DUP

CREATE TABLE layoffs_staging 
LIKE project_layoff.layoffs;

INSERT layoffs_staging 
SELECT * FROM layoffs;

WITH dup_cte AS 
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging
)
SELECT * FROM dup_cte
WHERE row_num >1
;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
;

SELECT * FROM layoffs_staging2
WHERE row_num > 1
;

DELETE FROM layoffs_staging2
WHERE row_num > 1
;

-- FORMAT FIX

SELECT company, trim(company)
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET company = trim(company)
;

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT * 
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%'
;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'
;


SELECT DISTINCT country
FROM layoffs_staging2
;

SELECT DISTINCT country
FROM layoffs_staging2
WHERE country LIKE 'United States%';

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%'
;

SELECT `date`, str_to_date(`date`, '%m/%d/%Y') 
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y')
;

SELECT `date`
FROM layoffs_staging2
;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE
; 

-- NULL AND BLANK

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''
;

SELECT t1.company, t1.location, t1.industry,t2.company, t2.location, t2.industry 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL
;

UPDATE layoffs_staging2
SET industry = null
WHERE industry = ''
;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL
;

SELECT * FROM layoffs_staging2
WHERE company LIKE "Bally%"
;


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num
;

SELECT * FROM layoffs_staging2
;







