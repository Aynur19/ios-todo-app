//
//  TodoItemLastCellView.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 22.07.2023.
//

import SwiftUI

struct TodoItemLastCellView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Новое")
                .padding(.leading, 36)
                .font(Fonts.body)
                .foregroundColor(Colors.labelTertiary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

struct TodoItemLastCellView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemLastCellView()
    }
}
