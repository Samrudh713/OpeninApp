//
//  ContentView.swift
//  OpeninApp
//
//  Created by Samrudh S on 18/04/24.
//

import SwiftUI

struct Link: Identifiable, Codable {
    var id: Int
    var title: String
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        if let imageData = try container.decodeIfPresent(Data.self, forKey: .image) {
            image = UIImage(data: imageData)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        if let image = image, let imageData = image.pngData() {
            try container.encode(imageData, forKey: .image)
        }
    }
}

struct DashboardData: Codable {
    var topLinks: [Link]
    var recentLinks: [Link]
}

struct ContentView: View {
    @State private var dashboardData: DashboardData?
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .scaleEffect(2)
            } else {
                GreetingView()
                TabView {
                    List(dashboardData?.topLinks ?? []) { link in
                        Text(link.title)
                    }
                    .tabItem {
                        Label("Top links", systemImage: "star.fill")
                    }
                    
                    List(dashboardData?.recentLinks ?? []) { link in
                        Text(link.title)
                    }
                    .tabItem {
                        Label("Recent links", systemImage: "clock.fill")
                    }
                }
            }
        }
        .onAppear {
            APIService.shared.fetchDashboardData { data in
                self.dashboardData = data
                self.isLoading = false
            }
        }
    }
}


#Preview {
    ContentView()
}
