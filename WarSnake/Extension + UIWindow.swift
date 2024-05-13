//
//  Extension + UIWindow.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 13.05.2024.
//

import UIKit

extension UIWindow {
    static var bounds: CGRect {
        return UIApplication.shared.connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first?
            .windowScene?
            .screen
            .bounds ?? .zero
    }
}
