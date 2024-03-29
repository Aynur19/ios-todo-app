//
//  ContentView.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 21.07.2023.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var todoListVM: TodoListViewModel
    //    let todoList = MockData.todoList
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .centerLastTextBaseline) {
                ScrollView(.vertical) {
                    
                    HStack {
                        Text("Выполенено - \(todoListVM.completedCount)")
                            .font(Fonts.subhead)
                            .foregroundColor(Colors.labelTertiary)
                        
                        Spacer(minLength: 16)
                        
                        Text(todoListVM.withCompleted ? "Скрыть" : "Показать")
                            .font(Fonts.subheadBold)
                            .foregroundColor(Colors.blue)
                            .onTapGesture {
                                todoListVM.withCompleted.toggle()
                            }
                    }
                    .padding(.horizontal, 16)
                    
                    LazyVStack(alignment: .leading) {
                        ForEach(todoListVM.shownList, id: \.id) { item in
                            TodoItemCellView(todoItemVM: item)
                            
                            Divider()
                                .foregroundColor(Colors.supportSeparator)
                                .frame(height: 1)
                                .padding(.leading, 52)
                        }
                        
                        TodoItemLastCellView()
                            .frame(minHeight: 56)
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
                
                
                Button(action: {
                    // Действия при нажатии кнопки
                    print("Кнопка нажата!")
                }) {
                    Image("Add Task")
                        .frame(width: 44, height: 44, alignment: .center)
                }
                .padding(.bottom, 20)
            }
            
           
        }
        .background(Colors.backPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        return ContentView(todoListVM: TodoListViewModel(todoItems: Array(MockData.todoList[0..<5])))
    }
}
