--ЗАДАНИЕ 1. Соединение таблиц
/*1. Добавить в таблицу «Грузовик» данные о водителе Роне Уинстоне и его грузовике с кодом 95.*/

Insert into Car (CarId, DriverFullName)
Values (95, 'Рон Уинстон');

/*2. Показать названия клиентов, отправлявших грузы в Солт-Лейк-Сити.*/

Select Client.name
From Client,Transportation
Where 
Client.clientid=Transportation.clientid
and
Transportation.city='Солт-Лейк-Сити';

/*3. В какие пункты назначения компании с годовым доходом менее одного миллиона долларов отправляли грузы?*/

Select distinct City
From Transportation 
join Client on Transportation.ClientId = Client.ClientId
Where Yearlyincome < 1000000;

/*4. Показать названия и население городов, получавших грузы со средним весом более 100 кг.*/

Select distinct Transportation.City,City.population
From City
Join Transportation on Transportation.City=city.CityName
Where(Select AVG (weight)From Transportation)>100;*/

/*5. Кто из клиентов с годовым доходом более 10 миллионов долларов 
отправлял грузы весом менее 100 кг или отправлял грузы в Балтимор?*/

Select distinct Client.name
From Transportation
join Client on Transportation.clientid = Client.Clientid
Where Yearlyincome > 10000000
and weight < 100
Or Transportation.City='Балтимор';

/*6. Кто из водителей доставлял грузы для клиентов с годовым доходом более 20 
миллионов долларов в города с населением свыше одного миллиона человек?*/

Select distinct car.driverfullname
From car
Join Transportation on Transportation.carid = Car.carid
Join Client on Client.YearlyIncome > 20000000
Join City on City.population > 1000000
AND Transportation.city = City.cityname;

/*7. Для каждого города с населением свыше 1 миллиона человек выяснить
минимальный вес груза, отправленного в этот город.*/

Select city.cityname, City.population, MIN(Transportation.weight)
From Transportation
Join City on City.Population > 1000000
Group by City.cityname


/*/*8. Вывести фамилию и инициалы всех водителей, а также подробную информацию
о каждом перевезённом ими грузе.*/*/

SELECT 
SUBSTRING (car.driverfullname FROM POSITION (' ' IN car.driverfullname)) || ' '||
(LEFT(SUBSTRING (car.driverfullname FROM 1 FOR POSITION (' ' IN car.driverfullname)),1)) || '.' as FIO, transportationid, transportation.carid, clientid, weight, cost::numeric, transportationdate, city
FROM transportation
JOIN car ON car.carid = transportation.carid 


/*9. Вывести ФИО всех водителей, а также общее количество и суммарный вес
перевезённых ими грузов*/

Select DriverFullName, Count(Transportationid) as Transcount, Sum(weight) as weight_sum
From car
Left Join Transportation on car.carid = Transportation.carid
Group by Driverfullname*/


--ЗАДАНИЕ 3. Обновление данных

/*1. Преобразовать вес каждого груза из килограммов в фунты, умножив его на
2.2026 (при этом может понадобиться увеличить размерность столбца, в
котором хранятся указанные данные).*/
Alter Table Transportation
Alter column weight type decimal;
Update Transportation
Set weight = weight*2.2026;


/*2. Убрать часть «, лтд» в названии клиентов – оптовых продавцов*/
Update Client 
set
name = rtrim (name, 'лтд')
where lower (type) = 'оптовый продавец';

--ЗАДАНИЕ 4. Удаление данных

/*1. Удалить из базы данных все города с населением менее 5000 человек (при этом
учитывая наличие связей с таблицей ПЕРЕВОЗКА).*/
delete from Transportation
Where City in (Select cityname From City Where Population<5000);







