//
//  TaskMasterioSwiftUIApp.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 21.07.2023.
//

import SwiftUI

@main
struct TaskMasterioSwiftUIApp: App {
    var body: some Scene {
        let todoListVM = TodoListViewModel(todoItems: MockData.todoList)
        WindowGroup {
            ContentView(todoListVM: todoListVM)
        }
    }
}
