//
//  Task.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import Foundation

// MARK: - Tasks
struct Tasks: Codable {
    let status: String
    let total: Int
    let data: [UserTask]
}

// MARK: - Task
struct UserTask: Codable, Identifiable, Hashable {
    let id: Int
    let text: String
}
