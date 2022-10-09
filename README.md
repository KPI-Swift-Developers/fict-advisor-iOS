# fictadvisor-iOS

## design

use Apple-like iOS apps style. figma file link: https://www.figma.com/file/jkZ7kJ5UVTZx3rEULkGBDJ/fictadvisor-iOS?node-id=17%3A4

## api 
use official fictadvisor public api 

https://github.com/fictadvisor/documentation/tree/master/postman

https://github.com/fictadvisor/fictadvisor-api

telegram auth 
https://core.telegram.org/widgets/login

## techical stack 
- iOS 15 target 
- UIKit (in code) + SwiftUI (in lightweight tasks)
- SnapKit, Alamofire
- for design use standard -> icons, colors
- Apple MVC + MVP (for heavy parts)
- moduled system for all parts of programm 
- table interface mostly 
- iPadOS support 

## programm parts 
(j) - jeyery (s) - sashka

- main page
- settings 
- teachers (s) -> oneTeacher (s) -> teacherReview (s) + teacherContacts (s)
- subjects (j) -> oneSubject (j) -> course (j)
- superheroes
- help
- telegram auth
- firebase tools 
- api 

# telegram auth research 
https://core.telegram.org/widgets/login

Подгрузить саму страницу через вебвью - очень изи позволяет авторизироваться даже. Проблема на данный момент это получить ивент того, что юзер авторизировался с его данными от телеграма. Из того что накопал по этой проблеме - надо как-то передать вебвью что есть колбек в джеесе, а из него дернуть функу из свифта (пососал, не понятно как передать это через хтмл + вебвью не позволяет открыть всплывающие окна, подгрузить кнопку которая открывает виджет нельзя, только сразу окно). Воторой варик редирект, вроде более рабочий, надо разобраться с редиректом. Дальше можно будет работать с авторизацией самой апишки (по идее телега даст токен, который подгрузиться на сервак + будет юзаться для некоторых запросов)  
