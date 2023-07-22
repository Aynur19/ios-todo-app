//
//  TodoItemCellView.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 21.07.2023.
//

import SwiftUI

struct TodoItemCellView: View {
    
    @ObservedObject var todoItemVM: TodoItemViewModel
    
    init(todoItemVM: TodoItemViewModel) {
        self.todoItemVM = todoItemVM
    }
    
    var body: some View {
        HStack(spacing: 16) {
            HStack() {
                markButton
                
                VStack(alignment: .leading, spacing: 0) {
                    titleAndPriority
                    deadline
                }
            }
            
            Spacer(minLength: 12)
            
            Image("Arrow. Right")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    var markButton: some View {
        Button(action: {
            todoItemVM.isDone.toggle()
        }) {
            if todoItemVM.isDone {
                Image("Mark. On")
            } else {
                todoItemVM.priority == .high
                    ? Image("Mark. High Priority")
                    : Image("Mark. Off")
            }
        }
    }
    
    var titleAndPriority: some View {
        HStack(spacing: 2) {
            if todoItemVM.priority == .low {
                Image("Priority. Low")
            } else if todoItemVM.priority == .high {
                Image("Priority. High")
            }
            
            Text(todoItemVM.text)
                .lineLimit(3)
                .font(Fonts.body)
                .foregroundColor(todoItemVM.isDone ? Colors.labelTertiary :  Colors.labelPrimary)
                .strikethrough(todoItemVM.isDone, color: Colors.labelTertiary)
        }
    }
    
    var deadline: some View {
        HStack(spacing: 2) {
            if let deadline = todoItemVM.deadline {
                Image("Calendar")
                Text(deadline.toString(format: DatetimeFormats.deadline))
                    .foregroundColor(Colors.labelTertiary)
                    .font(Fonts.subhead)
            }
            
        }
    }
}

struct TodoItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        let todoItemVM = TodoItemViewModel(todoItem: TodoItem(text: "Пройти на второй этап в школе Академии Яндекса", priority: .medium, deadline: Date(), isDone: false))
        TodoItemCellView(todoItemVM: todoItemVM)
    }
}
