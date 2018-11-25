//
//  CodeView.swift
//  NextMovie
//
//  Created by Valmir Junior on 25/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

protocol CodeView {
    func setupComponents()
    func setupConstraints()
    func setupExtraConfiguration()
    func setup()
}

extension CodeView {
    func setup() {
        setupComponents()
        setupConstraints()
        setupExtraConfiguration()
    }
}
