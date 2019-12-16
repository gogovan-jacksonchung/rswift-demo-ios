//
//  ContentView.swift
//  RSwiftDemo
//
//  Created by Jackson Chung on 12/12/2019.
//  Copyright © 2019 Jackson Chung. All rights reserved.
//

import SwiftUI

struct TextRow: Identifiable {
    var id: String = UUID().uuidString
    
    var title: String
    var key: String
}

struct ContentView: View {
    
    @State
    var rowList: [TextRow] = [TextRow(title: R.string.localizable.address(), key: "address"),
                              TextRow(title: R.string.localizable.done(), key: "done"),
                              TextRow(title: R.string.localizable.item_count(localized_format_key: 0), key: "item_count"),
                              TextRow(title: R.string.localizable.item_count(localized_format_key: 1), key: "item_count"),
                              TextRow(title: R.string.localizable.item_count(localized_format_key: 2), key: "item_count"),
                              TextRow(title: R.string.localizable.placeholder_test(1, "cake", 10.99), key: "placeholder_test")
    ]
    
    var body: some View {
        NavigationView {
            List(rowList) { row in
                VStack(alignment: .leading) {
                    Text(row.title)
                    Text("key: \(row.key)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationBarTitle(Text(R.string.localizable.main_title()))
            .navigationBarItems(trailing: Button(action: showLocaleSelectionList, label: { Text("Locale")}))
        }
    }
    
    private func showLocaleSelectionList() {
        
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
