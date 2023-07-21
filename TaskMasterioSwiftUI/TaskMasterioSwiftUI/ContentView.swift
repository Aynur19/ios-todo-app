//
//  ContentView.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 21.07.2023.
//

import SwiftUI



struct ContentView: View {
    let todoList = MockData.todoList
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    ForEach(todoList, id: \.id) { item in
                        TodoItemCellView(todoItemVM: TodoItemViewModel(todoItem: item))
                        Divider()
                            .foregroundColor(Colors.supportSeparator)
                            .frame(height: 1)
                    }
                }
                .background(Colors.backSecondary)
                .cornerRadius(16)
                .frame(maxWidth: .infinity)
            }
            
            .cornerRadius(16)
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Colors.backPrimary)
            .navigationTitle("Мои дела")
        }
        .background(Colors.backPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        return ContentView()
    }
}
