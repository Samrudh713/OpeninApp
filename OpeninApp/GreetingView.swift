//
//  GreetingView.swift
//  OpeninApp
//
//  Created by Samrudh S on 18/04/24.
//

import SwiftUI

struct GreetingView: View {
    var body: some View {
        Text(greetingMessage())
            .font(.largeTitle)
            .padding()
    }
    
    func greetingMessage() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let hour = Int(dateFormatter.string(from: Date()))!
        
        switch hour {
        case 6...11:
            return "Good morning!"
        case 12...15:
            return "Good afternoon!"
        case 16...19:
            return "Good evening!"
        case 20...24:
            return "Good night!"
        default:
            return "Hello!"
        }
    }
}

#Preview {
    GreetingView()
}
