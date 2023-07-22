//
//  MockData.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 22.07.2023.
//

import Foundation

struct MockData {
    
    static let format = "yyyy/MM/dd HH:mm"
    
    static var todoList = [
        TodoItem(text: "Купить продукты", priority: .medium, deadline: Utilites.date(from: "2023/07/22 10:00", as: format), isDone: false)
        ,TodoItem(text: "Закончить проект", priority: .high, deadline: Utilites.date(from: "2023/07/30 18:00", as: format), isDone: false)
        ,TodoItem(text: "Подготовить презентацию", priority: .medium, deadline: Utilites.date(from: "2023/07/25 14:30", as: format), isDone: true)
        ,TodoItem(text: "Забрать посылку", priority: .low, deadline: Utilites.date(from: "2023/07/29 11:00", as: format), isDone: false)
        ,TodoItem(text: "Позвонить другу", priority: .medium, deadline: Utilites.date(from: "2023/07/23 15:00", as: format), isDone: false)
        ,TodoItem(text: "Отправить письмо", priority: .low, deadline: Utilites.date(from: "2023/08/05 09:30", as: format), isDone: false)
        ,TodoItem(text: "Сходить в спортзал", priority: .medium, deadline: Utilites.date(from: "2023/07/24 16:00", as: format), isDone: false)
        ,TodoItem(text: "Прочитать книгу", priority: .medium, deadline: Utilites.date(from: "2023/08/01 13:00", as: format), isDone: true)
        ,TodoItem(text: "Выпить кофе", priority: .low, deadline: Utilites.date(from: "2023/07/28 10:30", as: format), isDone: false)
        ,TodoItem(text: "Убраться в комнате", priority: .high, deadline: Utilites.date(from: "2023/07/31 17:00", as: format), isDone: false)
        ,TodoItem(text: "Погулять в парке", priority: .medium, deadline: Utilites.date(from: "2023/07/26 12:30", as: format), isDone: false)
        ,TodoItem(text: "Сделать зарядку", priority: .low, deadline: Utilites.date(from: "2023/08/04 08:00", as: format), isDone: false)
        ,TodoItem(text: "Сходить на выставку", priority: .medium, deadline: Utilites.date(from: "2023/07/27 15:30", as: format), isDone: true)
        ,TodoItem(text: "Сделать покупки", priority: .medium, deadline: Utilites.date(from: "2023/08/02 10:00", as: format), isDone: false)
        ,TodoItem(text: "Посмотреть фильм", priority: .low, deadline: Utilites.date(from: "2023/07/23 20:00", as: format), isDone: false)
        ,TodoItem(text: "Записаться на курс", priority: .medium, deadline: Utilites.date(from: "2023/07/29 09:00", as: format), isDone: false)
        ,TodoItem(text: "Отправить отчет", priority: .high, deadline: Utilites.date(from: "2023/07/30 14:00", as: format), isDone: false)
        ,TodoItem(text: "Поехать за город", priority: .medium, deadline: Utilites.date(from: "2023/07/26 08:30", as: format), isDone: false)
        ,TodoItem(text: "Сделать пробежку", priority: .low, deadline: Utilites.date(from: "2023/08/01 07:00", as: format), isDone: false)
        ,TodoItem(text: "Заказать пиццу", priority: .medium, deadline: Utilites.date(from: "2023/07/25 19:00", as: format), isDone: true)
        ,TodoItem(text: "Пройти курс онлайн", priority: .low, deadline: Utilites.date(from: "2023/08/03 11:30", as: format), isDone: false)
        ,TodoItem(text: "Проверить почту", priority: .medium, deadline: Utilites.date(from: "2023/07/28 16:30", as: format), isDone: false)
        ,TodoItem(text: "Провести собрание", priority: .high, deadline: Utilites.date(from: "2023/07/29 13:00", as: format), isDone: false)
        ,TodoItem(text: "Приготовить обед", priority: .medium, deadline: Utilites.date(from: "2023/08/02 12:30", as: format), isDone: false)
        ,TodoItem(text: "Сходить в магазин", priority: .low, deadline: Utilites.date(from: "2023/07/26 11:00", as: format), isDone: false)
        ,TodoItem(text: "Написать код", priority: .medium, deadline: Utilites.date(from: "2023/07/27 18:00", as: format), isDone: false)
        ,TodoItem(text: "Поиграть в игры", priority: .low, deadline: Utilites.date(from: "2023/07/24 21:30", as: format), isDone: true)
        ,TodoItem(text: "Подготовить отчет", priority: .high, deadline: Utilites.date(from: "2023/07/30 10:00", as: format), isDone: false)
        ,TodoItem(text: "Сходить на спектакль", priority: .medium, deadline: Utilites.date(from: "2023/07/25 19:30", as: format), isDone: false)
        ,TodoItem(text: "Позвонить родителям", priority: .low, deadline: Utilites.date(from: "2023/07/23 17:00", as: format), isDone: false)
        ,TodoItem(text: "Закончить учебу", priority: .medium, deadline: Utilites.date(from: "2023/07/29 13:30", as: format), isDone: true)
        ,TodoItem(text: "Отправить сообщение", priority: .low, deadline: Utilites.date(from: "2023/08/05 15:00", as: format), isDone: false)
        ,TodoItem(text: "Сходить на мероприятие", priority: .medium, deadline: Utilites.date(from: "2023/07/22 20:30", as: format), isDone: false)
        ,TodoItem(text: "Заняться спортом", priority: .low, deadline: Utilites.date(from: "2023/07/30 09:00", as: format), isDone: false)
        ,TodoItem(text: "Прокрастинировать", priority: .medium, deadline: Utilites.date(from: "2023/07/24 22:00", as: format), isDone: false)
        ,TodoItem(text: "Заняться творчеством", priority: .low, deadline: Utilites.date(from: "2023/08/04 14:30", as: format), isDone: true)
        ,TodoItem(text: "Прочитать новости", priority: .medium, deadline: Utilites.date(from: "2023/07/28 08:00", as: format), isDone: false)
        ,TodoItem(text: "Улучшить навыки", priority: .high, deadline: Utilites.date(from: "2023/07/29 17:30", as: format), isDone: false)
        ,TodoItem(text: "Сходить в кино", priority: .medium, deadline: Utilites.date(from: "2023/07/23 21:00", as: format), isDone: false)
        ,TodoItem(text: "Разобраться с задачей", priority: .low, deadline: Utilites.date(from: "2023/08/01 14:00", as: format), isDone: true)
        ,TodoItem(text: "Принять участие", priority: .medium, deadline: Utilites.date(from: "2023/07/26 10:30", as: format), isDone: false)
        ,TodoItem(text: "Сделать подарок", priority: .low, deadline: Utilites.date(from: "2023/08/02 15:30", as: format), isDone: false)
        ,TodoItem(text: "Отдохнуть", priority: .medium, deadline: Utilites.date(from: "2023/07/27 11:00", as: format), isDone: true)
        ,TodoItem(text: "Поесть", priority: .low, deadline: Utilites.date(from: "2023/07/25 12:30", as: format), isDone: false)
        ,TodoItem(text: "Записаться на мероприятие", priority: .medium, deadline: Utilites.date(from: "2023/07/29 20:00", as: format), isDone: false)
        ,TodoItem(text: "Пообщаться с друзьями", priority: .low, deadline: Utilites.date(from: "2023/07/23 19:00", as: format), isDone: false)
        ,TodoItem(text: "Провести эксперимент", priority: .medium, deadline: Utilites.date(from: "2023/08/03 09:30", as: format), isDone: false)
        ,TodoItem(text: "Сделать ремонт", priority: .high, deadline: Utilites.date(from: "2023/07/28 17:00", as: format), isDone: false)
        ,TodoItem(text: "Поблагодарить", priority: .medium, deadline: Utilites.date(from: "2023/07/30 08:30", as: format), isDone: true)
        ,TodoItem(text: "Закончить документ", priority: .low, deadline: Utilites.date(from: "2023/07/24 13:00", as: format), isDone: false)
    ]
}
