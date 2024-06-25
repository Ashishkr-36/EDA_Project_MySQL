-- Exploratory Data Analysis --

select *
from  layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
 from layoffs_staging2
 ;
 
 select *
 from layoffs_staging2
 where percentage_laid_off = 1
 ;
 
 select *
 from layoffs_staging2
 where percentage_laid_off = 1
 order by total_laid_off desc
 ;
 
 select country, sum(total_laid_off)
 from layoffs_staging2
 group by country
 order by 2 desc
 ;
 
 
select `date`, sum(total_laid_off)
 from layoffs_staging2
 group by `date`
 order by 1 desc
 ; 
 
 select year(`date`), sum(total_laid_off)
 from layoffs_staging2
 group by year(`date`)
 order by 1 desc
 ;
 
 select stage, sum(total_laid_off)
 from layoffs_staging2
 group by stage
 order by 1 desc
 ;
 
select substring(`date`, 6,2) as `MONTH`
from layoffs_staging2
;

 
select substring(`date`, 1,7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by `MONTH`
order by 1 asc
;
 
 with Rolling_Total as
 (
 select substring(`date`, 1,7) as `MONTH`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by `MONTH`
order by 1 asc
 )
 select `MONTH`, total_off
 ,sum(total_off) over (order by `MONTH`) as rolling_total
 from Rolling_Total
 ;
 
 select company, year(`date`), sum(total_laid_off)
 from layoffs_staging2
 group by company, year(`date`)
 order by 3 desc
 ;
 
 with Company_Year (company, years, total_laid_off) as
 (
  select company, year(`date`), sum(total_laid_off)
 from layoffs_staging2
 group by company, year(`date`)
 )
 select *
 from Company_Year
 ;
 
 
  with Company_Year (company, years, total_laid_off) as
 (
  select company, year(`date`), sum(total_laid_off)
 from layoffs_staging2
 group by company, year(`date`)
 )
 select *, 
 dense_rank() over (partition by years order by total_laid_off desc) as Ranking
 from Company_Year
 where years is not null
 order by Ranking asc
 ;
 
 
 
 
 
 
 