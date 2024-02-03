create database boxoffice_db;
select * from movie_commercials;
select * from movie_details;


/*1. Show the list of movies released in 2020.*/

alter table movie_details add column R_date date;
desc movie_details;
update movie_details set R_date = str_to_date(release_date,"%d-%b-%y" );
select movie_name, R_date from movie_details where year(R_date) = 2020;



/*2. List the top 5 movies which grossed the highest collections across all years.*/

select movie_name from movie_commercials order by movie_total_worldwide desc limit 5;


                                                                               
/*3. List the name of the producers who has produced comedy movies in 2019. */

select producer from movie_details where (year(R_date) = 2019) and (movie_genre = "comedy");



/*4. Which movie in 2020 had the shortest duration?*/

select movie_name from movie_details where year(R_date) = 2020 order by runtime asc limit 1;



/*5. List the movie with the highest opening weekend. Is this the same movie which had the highest overall collection?*/

SELECT 
    movie_name
FROM
    movie_commercials
WHERE
    movie_opening = (SELECT 
            MAX(movie_opening)
        FROM
            movie_commercials);
            
            select if((select movie_name
            from movie_commercials order by movie_weekend desc limit 1) 
            = (select movie_name from movie_commercials 
            order by movie_total_worldwide desc limit 1), "Yes", "No") as status;



/*6. List the movies which had the weekend collectio same as the first week collection*/

SELECT 
    movie_name
FROM
    movie_commercials
WHERE
    movie_firstweek = movie_weekend;



/*7. List the top 3 movies with the highest foreign collection.*/

SELECT 
    movie_name
FROM
    movie_commercials
ORDER BY movie_total_worldwide DESC
LIMIT 3;



/*8. List the movies that were released on a non-weekend day. */

SELECT 
    movie_name
FROM
    movie_details
WHERE
    WEEKDAY(R_date) NOT IN (5 , 6);




/*9. List the movies by Reliance Entertainment which were non comedy.*/

SELECT 
    movie_name
FROM
    movie_details
WHERE
    movie_genre <> 'Comedy'
        AND banner = 'Reliance Entertainment';




/* 10. List the movies produced in the month of October, November, and December that were released on the weekends.*/

SELECT 
    movie_name
FROM
    movie_details
WHERE
    MONTH(R_date) IN (10 , 11, 12)
        AND WEEKDAY(R_date) IN (5 , 6);

