//
//  TasksList.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import SwiftUI

struct TasksList: View {
    // MARK: - State
    @State private var tasks: [UserTask] = []
    @State private var errorOccured = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @State private var isRefreshing = false
    
    // MARK: - Content
    var body: some View {
        VStack {
            // Если идет загрузка, показывать анимацию загрузки
            if isLoading {
                Spacer()
                ProgressView()
                    .progressViewStyle(.circular)
                    .foregroundColor(.black)
                    .scaleEffect(2.0)
                Spacer()
            } else {
                // Условие, отслеживающее, если после успешной прогрузки (без появления ошибки) пришли пустые данные.
                let emptyTasksAfterLoadingData = !isLoading && tasks.isEmpty && !errorOccured
                
                // Если пришли пустые данные, показывать соответсвующее сообщение
                if emptyTasksAfterLoadingData {
                    Spacer()
                    NoTasksYetView()
                    Button {
                        getTasks(refreshing: false)
                    } label:  {
                        Text("Если вы уже добавили задачу, нажмите сюда для перезагрузки ↩️")
                            .padding()
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.blue)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    
                // В другом случае, показывать список
                } else {
                    List {
                        ForEach(tasks) { task in
                            TaskRow(text: task.text)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color("backgroundColor"))
                        }
                        .onDelete { deleteTask(at: $0) }
                    }
                    
                    // Настраиваем стиль списка
                    .listStyle(.plain)
                    
                    // При потягивании списка вниз обновлять данные
                    .refreshable { getTasks(refreshing: true) }
                    
                    // В случае, если вышла ошибка после прогрузки, показывать просто серый цвет
                    .overlay {
                        if errorOccured {
                            ZStack() { Color("backgroundColor").ignoresSafeArea()
                            }
                        }
                    }
                }
            }
        }
        .background(Color("backgroundColor")) // Задаем фоновый цвет
        
        // Настраиваем алерт с ошибкой
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
        
        // Перед появлением экрана вызываем метод загрузки задач
        .onAppear { getTasks(refreshing: false) }
    }
    
    // MARK: - Methods
    /// Метод для получения списка задач
    private func getTasks(refreshing: Bool) {
        /* isLoading для ProgressView() определяется так: если метод вызван для обновления списка, то isLoading – false. Если метод вызван не для обновления списка, то isLoading – true.
         */
        isLoading = !refreshing
        Task {
            do {
                tasks = try await NetworkManager.shared.getTasks().data.reversed()
                isLoading = false
            } catch {
                alertMessage = error.localizedDescription
                errorOccured = true
                isLoading = false
            }
        }
    }
    
    ///  Метод удаления задачи по индекс-сету
    private func deleteTask(at indexSet: IndexSet) {
        Task {
            do {
                guard let index = indexSet.first else { return }
                let taskToDelete = tasks[index]
                try await NetworkManager.shared.deleteTask(taskToDelete)
                tasks.remove(at: index)
            } catch {
                alertMessage = error.localizedDescription
                errorOccured = true
            }
        }
    }
    
}

struct TasksList_Previews: PreviewProvider {
    static var previews: some View {
        TasksList()
    }
}
