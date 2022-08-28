//
//  Orders.swift
//  Project 10
//
//  Created by Gabriel Marmen on 2022-08-28.
//

import Foundation

class Orders : Codable, ObservableObject {
    
    enum CodingKeys: CodingKey {
        case order
    }
    
    @Published var order = Order()
    
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(Order.self, forKey: .order)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
    }
    
    
}
