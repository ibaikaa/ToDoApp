//
//  AddTaskButton.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import SwiftUI

/// Кнопка, при нажатии на которую будет появляться View для добавления задачи
struct AddTaskButton: View {
    @State private var presentAddTaskView: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            
            // Настраиваем кнопку
            Button {
                
                // При нажатии на кнопку, указываем, что будет появляться всплывающее окно для добавления новой задачи
                presentAddTaskView = true
            } label: {
                // Задаем картинку для нашей кнопки (плюсик)
                Image(systemName: "plus")
                    .foregroundColor(.white)
            }
            .padding()
            
            // Настраиваем кнопке фоновый цвет
            .background(Color("btnBackground"))
            
            // Задаем скругление углов
            .cornerRadius(10)
            
            // Задаем тень
            .shadow(radius: 10)
            
            // Задаем появление окна для добавления новой задачи
            .sheet(isPresented: $presentAddTaskView) {
                AddTaskView(isPresented: $presentAddTaskView)
                    .presentationDetents([.height(screen.height / 16)])
            }
        }
        .padding()
    }
}

struct AddTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButton().previewLayout(.sizeThatFits)
    }
}
