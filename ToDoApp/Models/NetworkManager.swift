//
//  NetworkManager.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import Foundation

/// Перечисление возможных ошибок при работе с  API
enum ApiError: Error {
    case failedToPostData
    case failedToDelete
}

/// Класс для работы с сетью
final class NetworkManager {
    // MARK: - Properties
    
    // MARK: - Singleton
    static let shared = NetworkManager()
    private init () { }
    
    // MARK: - Private properties
    /// Главная URL
    private var baseURL: URL {
        URL(string: "http:68.183.214.2:8000/todo/")!
    }
    
    /// Объект URLSession
    private let session = URLSession.shared
    
    // MARK: - Methods
    
    // MARK: - Private
    
    /// Метод декодирования данных  из JSON-формата
    private func decode<T: Decodable>(data: Data) throws -> T {
      try JSONDecoder().decode(T.self, from: data)
    }
    
    /// Метод кодирования данных в JSON
    private func encode<T: Encodable>(_ params: [String:T]) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(params)
    }
    
    /// Метод для получения статус -кода для ответа от сервера
    private func getStatusCode(for response: URLResponse) -> Int {
        guard let httpResponse = response as? HTTPURLResponse else { return 0 }
        return httpResponse.statusCode
    }

    // MARK: - Public
    
    /// Метод получения списка задач с API
    public func getTasks() async throws -> Tasks {
        let (data, _) = try await session.data(from: baseURL)
        return try decode(data: data)
    }
    
    /// Метод добавления новой задачи на API
    public func addNewTask(text: String) async throws {
        
        // Создание и настройка запроса
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        let body = ["text":text]
        request.httpBody = try encode(body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Получение ответа от сервера на отправленный запрос
        let (_, response) = try await session.data(for: request)
        
        // Анализ статус-кода ответа
        let statusCode = getStatusCode(for: response)
        guard statusCode == 201 else { throw ApiError.failedToPostData }
    }
    
    /// Метод для удаления определенной задачи с сервера
    public func deleteTask(_ task: UserTask) async throws {
        
        // Создание и настройка запроса
        let url = URL(string: baseURL.absoluteString + "\(task.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        // Получение ответа от сервера на отправленный запрос
        let (_, response) = try await session.data(for: request)
        
        // Анализ статус-кода ответа
        let statusCode = getStatusCode(for: response)
        guard statusCode == 204 else { throw ApiError.failedToDelete }
    }
     
}
