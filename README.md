# Мини-сайт гороскопов

##Задание
Создать мини-сайт гороскопов, функционал:
- Парсинг гороскопов на каждый день с существующих сайтов, на свой выбор, с сохранением в БД по дням;
- Регистрация (с указанием даты рождения, проверка введеных данных);
- Авторизация (после которой человеку сразу показывается его гороскоп);
- Возможноcть посмотреть свой гороскоп за любой день, который есть в базе; возможность посмотреть гороскопы других пользователей;
- При реализации желательно показать знания jQuery + Ajax; и патерна MVC.
- Использовать HAML, SASS.

##Реализация
- Для разработки был использован ryby-фреймворк Sinatra.
- Использовался паттерн MVC
- Для парсинга данных был использован гем whenever, который позволяет описывать cron комманды с помощью ruby. Каждый понедельник запускается файл Grabber.rb, котрый вытягивает данные из http://widgets.fabulously40.com/horoscope.json
- Данные пользователей и гороскопы лежат в базе данных
- Используется авторизация на сессиях
- Использовано SASS и HAML
- Использовал jQuery и jQuery UI; AJAX
- Сделана клиентская и серверная валидация данных форм
- После авторизации пользователь может посмотреть свой гороскоп за сегодня, вчера и завтра, а также гороскопы других знаков зодиака

#Установка
Стяните файлы себе на компьютер, выполнти в этой папке комманды "whenever . && whenever --update" и "rackup"

#Граббинг
Данные тянутся каждый день в 00:00, но т.к. API не проверенное, врозможны накладки(хотя за Октябрь 2013 есть данные за все дни всех знаков)
Если базы данных нету, данные тянутся автоматически начиная с текущего дня

#P.S.
Первый сайтик на Руби. Вышло, вроде бы, не так уж плохо; на нормальный дизайн не хватило времени, ибо выходные ушли на рассчетку по электротехнике

#Deploy
http://162.243.95.47/ - готовое приложение