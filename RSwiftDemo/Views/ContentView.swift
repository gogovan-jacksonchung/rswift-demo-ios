//
//  ContentView.swift
//  RSwiftDemo
//
//  Created by Jackson Chung on 12/12/2019.
//  Copyright © 2019 Jackson Chung. All rights reserved.
//

import SwiftUI
import PhraseSDK

struct TextRow: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var key: String
}

struct ContentView: View {
    @State
    var rowList: [TextRow] = []
    @State
    var currentLocale = LocalizationManager.appLocale
    @State
    var showUpdateFailAlert = false
    @State
    var showLocaleActionSheet = false

    var localeSelectionActionSheet: ActionSheet {
        var buttons: [ActionSheet.Button] = AppLocale.allCases.map { locale in
            return .default(Text(locale.description)) {
                print(locale.description)
                self.currentLocale = locale
                LocalizationManager.appLocale = locale
                self.updateLocale(locale)
            }
        }
        buttons.append(.cancel(Text("Cancel"), action: { self.showLocaleActionSheet = false } ))
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
            .navigationBarTitle(Text(R.string.localizable.app_name()))
            .navigationBarItems(leading: Button(action: updateLocaleOTA, label: { Text("Update") }),
                                trailing: Button(action: showLocaleSelectionList, label: { Text("Locale") })
                                    .actionSheet(isPresented: $showLocaleActionSheet, content: { self.localeSelectionActionSheet })
            )
        }
        .onAppear( perform: { self.updateLocale(self.currentLocale) } )
        .alert(isPresented: $showUpdateFailAlert) { () -> Alert in
            Alert(title: Text("Failed to update"), message: nil, dismissButton: .cancel())
        }
    }
    
    private func showLocaleSelectionList() {
        self.showLocaleActionSheet.toggle()
    }
    
    private func updateLocaleOTA() {
        try? Phrase.shared.updateTranslations { result in
            switch result {
            case .success(let update):
                print("Is Localiation updated? \(update)")
                self.refreshView()
            case .failure:
                self.showUpdateFailAlert = true
            }
        }
    }
    
    private func updateLocale(_ locale: AppLocale) {
        self.refreshView()

        let distributionId = Environment.configuration(keyName: .phraseAppDistributionId)
        let envToken = Environment.configuration(keyName: .phraseAppEnvToken)
        Phrase.shared.setup(distributionID: distributionId, environmentSecret: envToken, timeout: 10, localeOverride: locale.localeString)
    }
    
    private func refreshView() {
        let rowList: [TextRow] = [
            TextRow(title: R.string.localizable.app_name(), key: "app_name (R)"),
            TextRow(title: R.string.localizable.hello(), key: "hello (R)"),
            TextRow(title: R.string.localizable.item_count(localized_format_key: 0), key: "item_count (R)"),
            TextRow(title: R.string.localizable.item_count(localized_format_key: 1), key: "item_count (R)"),
            TextRow(title: R.string.localizable.item_count(localized_format_key: 2), key: "item_count (R)"),
            TextRow(title: NSLocalizedString("hello", comment: ""), key: "hello (NSLocalizedString)")
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
