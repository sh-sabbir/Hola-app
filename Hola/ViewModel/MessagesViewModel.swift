//
//  MessagesViewModel.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import Foundation
import Foundation

class MessagesViewModel: ObservableObject {
    @Published var messages = [Message]()
    
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
}
