# Печкин (flutter)

Приложение для документации REST и socket API.

Предполагается возможность обсуждения изменений, 
выделение отдельных веток под задачи с последующим слиянием,
командная работа. Так же возможность выполнить запросы напрямую из документации.

Хранить документацию предполагается в репозитории git (без обсуждений) или на сервере 
(тогда появляется возможность обсуждений)

## Технологии

- Навигация с помощью нативного роутера
- Выполнение запросов к помощью DIO ?
- Храненение данных с помощью shared preferences ?
- Редактирование MD текста - ?
- Формочки для документирования rest api ?
- Работа с состоянием проекта - cubit ?

## Файловая структура проекта

- screens - экраны
- shared - общие компоненты
- models - классы данных
- api - вызов запросов api
- state - состояние проекта (cubit)

## TODO
- Добавление комментирования
- Работа с заголовками
- Авторизация через токен (автоматическая проверка токена и при необходимости его обновление или перевыпуск)
- Раздел Уведомления
- Раздел Обсуждения
- Раздел Команда
