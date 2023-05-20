//
//  TaskRow.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import SwiftUI

struct TaskRow: View {
    @State var text: String
    
    var body: some View {
        
        // Настраиваем текст для задачки
        Text(text)
            .font(.system(size: 20))
            .lineLimit(nil)
            .padding()
    }
    
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(text: "Заметки на сегодня что бы сделать дела по задачам")
            .previewLayout(.sizeThatFits)
    }
}
