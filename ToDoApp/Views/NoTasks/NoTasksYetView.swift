//
//  NoTasksYetView.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import SwiftUI

/// View, которое будет появляться, если у пользователя пока что нет задач
struct NoTasksYetView: View {
    var body: some View {
        VStack(alignment: .center) {
            // Указываем  иконку с дизайна
            Image("list")
            
            // Указываем и настраиваем соответсвующие текста
            Text("Пока ничего нет")
                .font(.system(size: 16))
            
            Text("Добавьте первую задачу")
                .font(.system(size: 16))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color("backgroundColor"))
    }
    
}

struct NoTasksYetView_Previews: PreviewProvider {
    static var previews: some View {
        NoTasksYetView().previewLayout(.sizeThatFits)
    }
}
