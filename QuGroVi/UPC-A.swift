//
//  UPC-A.swift
//  QuGroVi
//
//  Created by Lance Townsend on 4/12/22.
//

import SwiftUI

struct UPCA: Shape, View {
    let barCode: String
    
    func path(in rect: CGRect) -> Path {
        
        let sideAnchor = [1,0,1]
        let middleAnchor = [0,1,0,1,0]
        
        var row = 0
        
        let leftSideNumbers = [
            0: [0,0,0,1,1,0,1],
            1: [0,0,1,1,0,0,1],
            2: [0,0,1,0,0,1,1],
            3: [0,1,1,1,1,0,1],
            4: [0,1,0,0,0,1,1],
            5: [0,1,1,0,0,0,1],
            6: [0,1,0,1,1,1,1],
            7: [0,1,1,1,0,1,1],
            8: [0,1,1,0,1,1,1],
            9: [0,0,0,1,0,1,1]
        ]
        let rightSideNumbers = [
            0: [1,1,1,0,0,1,0],
            1: [1,1,0,0,1,1,0],
            2: [1,1,0,1,1,0,0],
            3: [1,0,0,0,0,1,0],
            4: [1,0,1,1,1,0,0],
            5: [1,0,0,1,1,1,0],
            6: [1,0,1,0,0,0,0],
            7: [1,0,0,0,1,0,0],
            8: [1,0,0,1,0,0,0],
            9: [1,1,1,0,1,0,0]
        ]
        
        var path = Path()
        
        if barCode.count != 12 {
            print("Error")
            return Path()
        }
        
        
        for i in sideAnchor {
            if i == 1 {
                path.move(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.maxY))
                path.addLine(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.minY))
            }
            
            row += 1
        }
        
        for i in 0...5 {
            let num = Int(barCode[i])
            let numbers = leftSideNumbers[num ?? 0]
            
            for j in (numbers ?? [0]) {
                if j == 1 {
                    path.move(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.maxY))
                    path.addLine(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.minY))
                }
                
                row += 1
            }
        }
        
        for i in middleAnchor {
            if i == 1 {
                path.move(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.maxY))
                path.addLine(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.minY))
            }
            
            row += 1
        }
        
        for i in 6...11 {
            let num = Int(barCode[i])
            let numbers = rightSideNumbers[num ?? 0]
            
            for j in (numbers ?? [0]) {
                if j == 1 {
                    path.move(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.maxY))
                    path.addLine(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.minY))
                }
                
                row += 1
            }
        }
        
        for i in sideAnchor {
            if i == 1 {
                path.move(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.maxY))
                path.addLine(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.minY))
            }
            
            row += 1
        }
        
        return path
    }
}

struct UPCE: Shape, View {
    let barCode: String
    
    func path(in rect: CGRect) -> Path {
        
        let sideAnchor = [1,0,1]
        let middleAnchor = [0,1,0,1,0]
        
        var row = 0
        
        let leftSideNumbers = [
            0: [0,0,0,1,1,0,1],
            1: [0,0,1,1,0,0,1],
            2: [0,0,1,0,0,1,1],
            3: [0,1,1,1,1,0,1],
            4: [0,1,0,0,0,1,1],
            5: [0,1,1,0,0,0,1],
            6: [0,1,0,1,1,1,1],
            7: [0,1,1,1,0,1,1],
            8: [0,1,1,0,1,1,1],
            9: [0,0,0,1,0,1,1]
        ]
        
        var path = Path()
        
        if barCode.count != 7 {
            print("Error")
            return Path()
        }
        
        
        for i in sideAnchor {
            if i == 1 {
                path.move(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.maxY))
                path.addLine(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.minY))
            }
            
            row += 1
        }
        
        for i in 0...5 {
            let num = Int(barCode[i])
            let numbers = leftSideNumbers[num ?? 0]
            
            for j in (numbers ?? [0]) {
                if j == 1 {
                    path.move(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.maxY))
                    path.addLine(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.minY))
                }
                
                row += 1
            }
        }
        
        for i in middleAnchor {
            if i == 1 {
                path.move(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.maxY))
                path.addLine(to: CGPoint(x: (rect.minX + CGFloat((row))), y: rect.minY))
            }
            
            row += 1
        }
        
        return path
    }
}
