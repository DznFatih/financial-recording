CREATE DATABASE expenses;

CREATE SCHEMA IF NOT EXISTS pl
    AUTHORIZATION postgres;

Create table if not exists dates (
	 Date date not null
	,Year int not null
	,Month int not null
	,YearMonth int not null
);

ALTER TABLE pl.dates ADD CONSTRAINT dates_dates_dim_id_pk PRIMARY KEY (Date);


INSERT INTO pl.dates
SELECT 
       datum AS Date
	   ,EXTRACT(YEAR FROM datum) AS Year
       ,EXTRACT(MONTH FROM datum) AS Month
	   ,EXTRACT(YEAR FROM datum) * 100 + EXTRACT(MONTH FROM datum) as YearMonth
FROM (SELECT '2022-01-01'::DATE + SEQUENCE.DAY AS datum
      FROM GENERATE_SERIES(0, 29219) AS SEQUENCE (DAY)
      GROUP BY SEQUENCE.DAY) DQ
ORDER BY 1;

CREATE OR REPLACE VIEW pl.vw_dates
 AS
 SELECT dates.date,
    dates.year,
    dates.month,
    dates.yearmonth AS "Year Month",
    EXTRACT(month FROM CURRENT_DATE) AS "Current Month",
    EXTRACT(year FROM CURRENT_DATE) AS "Current Year",
        CASE
            WHEN EXTRACT(month FROM CURRENT_DATE) = 1::numeric THEN 12::numeric
            ELSE EXTRACT(month FROM CURRENT_DATE) - 1::numeric
        END AS "Prior Month",
    EXTRACT(year FROM CURRENT_DATE) - 1::numeric AS "Prior Year",
        CASE
            WHEN dates.month::numeric = EXTRACT(month FROM CURRENT_DATE) AND dates.year::numeric = EXTRACT(year FROM CURRENT_DATE) THEN 'Y'::text
            ELSE 'N'::text
        END AS "Current Month Flag",
        CASE
            WHEN dates.year::numeric = EXTRACT(year FROM CURRENT_DATE) THEN 'Y'::text
            ELSE 'N'::text
        END AS "Current Year Flag",
        CASE
            WHEN dates.date < CURRENT_DATE THEN 'Y'::text
            ELSE 'N'::text
        END AS "Date Passed",
        CASE
            WHEN EXTRACT(month FROM CURRENT_DATE) = 1::numeric THEN EXTRACT(year FROM CURRENT_DATE) - 1::numeric
            ELSE EXTRACT(year FROM CURRENT_DATE)
        END AS "Prior Year Month",
        CASE
            WHEN dates.month::numeric =
            CASE
                WHEN EXTRACT(month FROM CURRENT_DATE) = 1::numeric THEN 12::numeric
                ELSE EXTRACT(month FROM CURRENT_DATE) - 1::numeric
            END AND dates.year::numeric =
            CASE
                WHEN EXTRACT(month FROM CURRENT_DATE) = 1::numeric THEN EXTRACT(year FROM CURRENT_DATE) - 1::numeric
                ELSE EXTRACT(year FROM CURRENT_DATE)
            END THEN 'Y'::text
            ELSE 'N'::text
        END AS "Prior Month Flag",
        CASE
            WHEN dates.date >= (CURRENT_DATE - 365) AND dates.date <= CURRENT_DATE THEN 'Y'::text
            ELSE 'N'::text
        END AS "L12M Flag",
    CURRENT_DATE AS "Today Date",
    ("right"(dates.year::text, 2) || ' '::text) || to_char(dates.date::timestamp with time zone, 'Mon'::text) AS "Year Month Name"
   FROM pl.dates;

ALTER TABLE pl.vw_dates
    OWNER TO postgres;

Create table if not exists pl.expenses (
	 
	"Type" Char(100) not null
	,Dates date not null
	,Amount decimal
);	
	
Select 
	"Type"
	,"dates" 
	,"amount"
from pl.expenses;	
