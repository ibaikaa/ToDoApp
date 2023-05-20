//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import SwiftUI

struct AddTaskView: View {
    enum FocusField: Hashable {
        case field
    }
    
    @State var task = ""
    @State private var errorOccured = false
    @State private var alertMessage = ""
    
    @FocusState private var focusedField: FocusField?
    
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            // Настраиваем поле для ввода
            TextField("Название задачи", text: $task)
                .font(.title2)
                .padding()
                .focused($focusedField, equals: .field)
            
            // Настраиваем кнопку
            Button {
                // При нажатии на кнопку, добавляем новую задачу на сервер
                addNewTask()
            } label: {
                Image(systemName: "arrow.up")
                    .padding()
                    .background(task.isEmpty ? Color("disabledButtonBackground") : Color("btnBackground"))
                    .foregroundColor(.white)
                    .cornerRadius(100)
            }
            
            // Кнопка будет выключена тогда, когда поле для ввода не имеет никакого текста
            .disabled(task.isEmpty)
        }
        .padding()
        .ignoresSafeArea(.keyboard)
        
        .onAppear {
            self.focusedField = .field
        }
        
        .onDisappear {
            self.focusedField = nil
        }
        
        // Настраиваем окно с ошибкой
        .alert(isPresented: $errorOccured) {
            Alert(
                title: Text("Ошибка!"),
                message: Text(alertMessage),
                dismissButton: .default(
                    Text("OK"),
                    action:  {
                        errorOccured = true
                    }
                )
            )
        }
    }
    
    // Код для добавления задачи на сервер
    private func addNewTask() {
        Task {
            do {
                try await NetworkManager.shared.addNewTask(text: task)
                isPresented = false
            } catch {
                alertMessage = error.localizedDescription
                errorOccured = true
                isPresented = true
            }
        }
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let isPresented = Binding.constant(true)
        AddTaskView(isPresented: isPresented).previewLayout(.sizeThatFits)
    }
}
