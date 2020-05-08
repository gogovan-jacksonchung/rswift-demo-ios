//
//  ContentView.swift
//  RSwiftDemo
//
//  Created by Jackson Chung on 12/12/2019.
//  Copyright © 2019 Jackson Chung. All rights reserved.
//

import SwiftUI
import PhraseSDK
import Localize_Swift

struct TextRow: Identifiable {
    var id: String = UUID().uuidString
    
    var title: String
    var key: String
}

struct ContentView: View {
    @State
    var rowList: [TextRow] = []
    
    private var currentLocale = AppLocale.english
    private let locales: [AppLocale] = [.english, .englishSingapore, .traditionalChineseTaiwan, .traditionalChineseHongKong]
    
    @State
    var showUpdateFailAlert = false
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
            .navigationBarItems(leading: Button(action: updateLocale, label: { Text("Update") }),
                                trailing: Button(action: showLocaleSelectionList, label: { Text("Locale") })
                                    .actionSheet(isPresented: $showLocaleActionSheet, content: { self.localeSelectionActionSheet })
            )
        }
        .onAppear( perform: { self.updateLocale(.english) } )
        .alert(isPresented: $showUpdateFailAlert) { () -> Alert in
            Alert(title: Text("Failed to update"), message: nil, dismissButton: .cancel())
        }
    }
    
    private func showLocaleSelectionList() {
        self.showLocaleActionSheet.toggle()
    }
    
    private func updateLocale() {
        try? Phrase.shared.updateTranslations { result in
            switch result {
            case .success(let update):
                print("Is Localiation updated? \(update)")
                self.updateLocale(self.currentLocale)
            case .failure:
                self.showUpdateFailAlert = true
            }
        }
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
