//
//  HostingController.swift
//  RSwiftDemo
//
//  Created by Jackson Chung on 16/12/2019.
//  Copyright © 2019 Jackson Chung. All rights reserved.
//

import UIKit
import SwiftUI

class HostingController: UIHostingController<ContentView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: ContentView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
