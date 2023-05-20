//
//  TaskManagerView.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import SwiftUI

struct TaskManagerView: View {
    var body: some View {
        VStack {
            TopView()
            TasksList()
            Spacer()
            AddTaskButton()
        }
        .background(Color("backgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagerView()
    }
}
