//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import SwiftUI

let screen = UIScreen.main.bounds

@main
struct ToDoAppApp: App {
    var body: some Scene {
        WindowGroup {
            TaskManagerView()
        }
    }
}
