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
    var currentLocale = AppLocale.english
    private let locales: [AppLocale] = [.english, .englishSingapore, .traditionalChineseTaiwan, .traditionalChineseHongKong, .vietnamese]
    
    @State
    var showUpdateFailAlert = false
    @State
    var showLocaleActionSheet = false
    var localeSelectionActionSheet: ActionSheet {
        var buttons: [ActionSheet.Button] = locales.map { locale in
            return .default(Text(locale.description)) {
                print(locale.description)
                self.currentLocale = locale
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
        Bundle.setLanguage(locale.localeString)
        self.refreshView()

        let distributionId = Environment.configuration(keyName: .phraseAppDistributionId)
        let envToken = Environment.configuration(keyName: .phraseAppEnvToken)
        Phrase.shared.setup(distributionID: distributionId, environmentSecret: envToken, timeout: 10, localeOverride: locale.localeString)
    }
    
    private func refreshView() {
        let rowList: [TextRow] = [
            TextRow(title: R.string.localizable.app_name(), key: "app_name"),
            TextRow(title: R.string.localizable.hello(), key: "hello"),
            TextRow(title: Phrase.shared.localizedString(forKey: "app_name", value: nil, table: nil), key: "app_name"),
            TextRow(title: Phrase.shared.localizedString(forKey: "hello", value: nil, table: nil), key: "hello")
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
