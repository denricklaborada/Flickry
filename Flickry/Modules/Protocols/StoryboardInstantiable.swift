//
//  StoryboardInstantiable.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit

// for cleaner instantiation of storyboard scenes
protocol StoryboardInstantiable {
    associatedtype Input
    associatedtype Output
    associatedtype ViewController: UIViewController
    static func generateFromStoryboard(input: Input, output: Output) -> ViewController
}
