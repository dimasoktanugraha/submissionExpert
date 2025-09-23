//
//  api-key.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//
import Foundation

public struct APIConfig {
    public static let apiKey: String = {
        guard let filePath = Bundle.main.path(forResource: "RAWG-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'RAWG-Info.plist'.")
        }

        guard let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'RAWG-Info.plist'.")
        }
        
        return value
    }()
}
