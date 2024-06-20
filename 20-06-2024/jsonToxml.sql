
CREATE DATABASE chitralu

use DATABASE chitralu

create table actor
(
    actorID int IDENTITY (1,1) primary key,
    actorName varchar(20) not null
);

create table director
(
    directorID int IDENTITY (1,1) primary key,
    directorName varchar(20) not null
)

create table movies
(
    movieID int IDENTITY (1,1) primary key,
    movietitle varchar(20) unique,
    releaseYear date not null,
    directorID int,
    foreign key(directorID) references director(directorID)
)

create table movieActors
(
    movieID int,
    actorID int,
    primary key(movieID,actorID),
    foreign key(movieID) references movies(movieID),
    foreign key(actorID) references actor(actorID)
)



insert into actor
values
    ('pavan'),
    ('nithin'),
    ('Lohith'),
    ('Nikhil'),
    ('Guna')

insert into director
values
    ('Raju') ,
    ('Varun'),
    ('phani'),
    ('srujan'),
    ('Tej')

insert into movies
values
    ('Devara', '2024-05-20', 1),
    ('Kalki', '2024-05-21', 2),
    ('OG', '2024-05-22', 3),
    ('Pushpa-3', '2024-05-23', 4),
    ('Shivayya', '2024-05-24', 5)

insert into movieActors
values
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5)

select *
from actor
select *
from director
select *
from movies
select *
from movieActors



-- xml auto
-- xml path

select *
from movies
for xml path

    select
        movieId,
        movietitle,
        [releaseYear],
        directorID
    from movies
    for xml path('Movie'), Root('Movies')

select
    movieId as [@movieId], -- attribute
    movietitle as [MovieInfo/Title], -- nesting xml
    [releaseYear] as [MovieInfo/Year],
    directorID
from movies
for xml path('Movie'), Root('Movies')

select *
from movies
for json auto

select *
from movies
for json path,root('Movies')

select
    movieId as [Id], -- renaming the key
    movietitle as 'MovieInfo.movietitle', -- nesting json
    [releaseYear] as 'MovieInfo.releaseYear', -- nesting json
    directorID
from movies
for json path, Root('Movies')



select 
		m.movieID as [@movieID], 
		movietitle as [MovieInfo/movietitle], 
		releaseYear as [MovieInfo/releaseYear], 
		d.directorName, 
		actorName
FROM movies m
    JOIN director d ON d.directorID = m.directorId
    JOIN movieActors ma ON m.movieID = ma.movieID
    JOIN actor a ON a.actorID = ma.actorID
FOR XML Path ('Movie'), Root('Movies')


select 
		m.movieID as [ID], 
		movietitle as 'MovieInfo.movietitle', 
		[releaseYear] as 'MovieInfo.releaseYear', 
		d.directorName, 
		actorName
FROM movies m
    JOIN director d ON d.directorID = m.directorId
    JOIN movieActors ma ON m.movieID = ma.movieID
    JOIN actor a ON a.actorID = ma.actorID
FOR JSON Path, Root('Movies')



select 
		
		movietitle as 'Movie.movietitle', 
		[releaseYear] as 'Movie.releaseYear', 
		m.movieID as 'Movie.MovieID', 
		d.directorID as'Director.dierctorID',
		d.directorName as'Director.dierctorName', 
		a.actorID as 'Actor.actorID',
		actorName as 'Actor.actorName'
FROM movies m
    JOIN director d ON d.directorID = m.directorId
    JOIN movieActors ma ON m.movieID = ma.movieID
    JOIN actor a ON a.actorID = ma.actorID
FOR JSON Path, Root('Movies')

select 
		movietitle as [Movie/movietitle], 
		[releaseYear] as [Movie/releaseYear], 
		m.movieID as [Movie/movieID], 
		d.directorID as [Director/directorID],
		d.directorName as[Director/directorName], 
		a.actorID as [Actor/actorID],
		actorName as [Actor/actorName]
FROM movies m
    JOIN director d ON d.directorID = m.directorId
    JOIN movieActors ma ON m.movieID = ma.movieID
    JOIN actor a ON a.actorID = ma.actorID
FOR XML Path ('Movies'), Root('Root')

