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
    var rowList: [TextRow] = []
    
    private let locales: [AppLocale] = [.english, .englishSingapore, .traditionalChineseTaiwan, .traditionalChineseHongKong]
    
    @State
    var showLocaleActionSheet = false
    var localeSelectionActionSheet: ActionSheet {
        var buttons: [ActionSheet.Button] = locales.map { locale in
            return .default(Text(locale.description)) {
                print(locale.description)
                self.updateLocale(locale)
            }
        }
        buttons.append(.cancel(Text(R.string.localizable.cancel()), action: { self.showLocaleActionSheet = false } ))
        return ActionSheet(title: Text("Select Locale"),
                           message: nil,
                           buttons: buttons)
    }
    
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
            .navigationBarItems(trailing: Button(action: showLocaleSelectionList,
                                                 label: { Text("Locale") })
                .actionSheet(isPresented: $showLocaleActionSheet, content: { self.localeSelectionActionSheet} )
            )
        }.onAppear( perform: { self.updateLocale(.english) } )
    }
    
    private func showLocaleSelectionList() {
        self.showLocaleActionSheet.toggle()
    }
    
    func updateLocale(_ locale: AppLocale) {
        Bundle.setLanguage(locale.localeString)
        self.refreshView()
    }
    
    private func refreshView() {
        let rowList: [TextRow] = [TextRow(title: R.string.localizable.address(), key: "address"),
                                  TextRow(title: R.string.localizable.done(), key: "done"),
                                  TextRow(title: R.string.localizable.item_count(localized_format_key: 0), key: "item_count"),
                                  TextRow(title: R.string.localizable.item_count(localized_format_key: 1), key: "item_count"),
                                  TextRow(title: R.string.localizable.item_count(localized_format_key: 2), key: "item_count"),
                                  TextRow(title: R.string.localizable.placeholder_test(1, "cake", 10.99), key: "placeholder_test")
        ]
        self.rowList = rowList
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
