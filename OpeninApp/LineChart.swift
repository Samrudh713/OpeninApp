//
//  LineChart.swift
//  OpeninApp
//
//  Created by Samrudh S on 18/04/24.
//

import SwiftUI

struct LineChart: View {
    var dataPoints: [CGFloat] // Assuming this is the data from the API
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let barWidth = width / CGFloat(dataPoints.count)
                
                for (index, value) in dataPoints.enumerated() {
                    let x = CGFloat(index) * barWidth
                    let y = height - value * height
                    path.move(to: CGPoint(x: x, y: height))
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}


