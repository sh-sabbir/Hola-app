//
//  MessagesViewModel.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import Foundation

class MessagesViewModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var selectedMessageDetail: Message?
    
    func fetchMessages() {
        let url = URL(string: "http://localhost:8025/api/v1/messages")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch messages: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode(MessageResponse.self, from: data)
                let messages = decodedData.messages
                
                DispatchQueue.main.async {
                    self.messages = messages
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func fetchMessageDetail(for messageID: String) {
        // Construct the URL for the API endpoint
        let urlString = "http://localhost:8025/api/v1/message/\(messageID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create a URL request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Perform the API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error fetching message detail: \(error)")
                return
            }
            
            // Check if data is received
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                // Decode the JSON response
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let messageDetail = try decoder.decode(Message.self, from: data)
                
                // Update selectedMessageDetail
                DispatchQueue.main.async {
                    self.selectedMessageDetail = messageDetail
                }
            } catch {
                print("Error decoding message detail: \(error)")
            }
        }.resume()
    }
}
