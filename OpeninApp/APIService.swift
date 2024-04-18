//
//  APIService.swift
//  OpeninApp
//
//  Created by Samrudh S on 18/04/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchDashboardData(completion: @escaping (DashboardData?) -> Void) {
        let urlString = "https://api.inopenapp.com/api/v1/dashboardNew"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCk W0ox8t bjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            if let dashboardData = try? decoder.decode(DashboardData.self, from: data) {
                completion(dashboardData)
            } else {
                completion(nil)
            }
        }.resume()
    }
}


