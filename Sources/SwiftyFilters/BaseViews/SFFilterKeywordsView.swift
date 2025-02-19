//
// SwiftyFilters
//
// Copyright (c) 2025 Michael Skuratau - https://github.com/maydibee
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import SwiftUI


// MARK: - Keywords filter view

struct SFFilterKeywordsView<FilteredItem>: View {
    
    @StateObject var node: SFFilterKeywordsNode<FilteredItem, String>
    @State private var enteredText: String = ""
    
    @Environment(\.enterKeywordString) private var enterKeywordString
    @Environment(\.caseSensitiveImage) private var caseSensitiveImage
    @Environment(\.addString) private var addString
    @Environment(\.noKeywordsString) private var noKeywordsString
    @Environment(\.deleteKeywordButtonImage) private var deleteKeywordButtonImage
    
    private var isEnteredTextEmpty: Bool {
        enteredText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    var body: some View {
        VStack(spacing: 12) {
            List {
                if !node.nestedNodes.isEmpty {
                    ForEach(node.nestedNodes) { child in
                        SFFilterCellView(node: child)
                            .onTapGesture {
                                child.isItemEnabled.toggle()
                            }
                    }
                }
                keywordInputSection
                    .padding(.top)
                    .padding(.bottom, 10)
                listContentSection
            }
            .buttonStyle(BorderlessButtonStyle())
            .animation(.easeInOut, value: node.keywordsModel.words)
            .animation(.easeInOut , value: enteredText)
        }
        .navigationTitle(node.title)
        .task {
            await self.node.loadFilterIfNeeded()
        }
    }
}


// MARK: - UI Components

private extension SFFilterKeywordsView {
    
    @ViewBuilder
    var keywordInputSection: some View {
        HStack {
            HStack {
                TextField(enterKeywordString, text: $enteredText)
                    .textFieldStyle(.plain)
                Button(action: {
                    toggleCaseSensitive()
                }, label: {
                    caseSensitiveImage
                        .foregroundColor(node.keywordsModel.isCaseSensitive ? .blue : .gray)
                        .imageScale(.medium)
                })
            }
            .padding(10)
            .capsuled()
            
            Button(action: addKeyword) {
                Text(addString)
                    .fontWeight(.semibold)
                    .frame(width: 50, height: 40)
                    .background(isEnteredTextEmpty ? Color.gray.opacity(0.3) : Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .disabled(isEnteredTextEmpty)
        }
    }
    
    @ViewBuilder
    var listContentSection: some View {
        if node.keywordsModel.words.isEmpty {
            Text(noKeywordsString)
                .foregroundColor(.gray)
        } else {
            ForEach(node.keywordsModel.words.indices, id: \.self) { index in
                makeKeywordCell(for: index)
                    .transition(.slide)
            }
        }
    }
    
    @ViewBuilder
    func makeKeywordCell(for index: Int) -> some View {
        HStack {
            Text(node.keywordsModel.words[index])
                .font(.body)
            Spacer()
            Button(action: { node.keywordsModel.removeKeyword(at: index) }) {
                deleteKeywordButtonImage
                    .foregroundColor(.red)
                    .imageScale(.medium)
            }
        }
    }
}


// MARK: - Utility methods

private extension SFFilterKeywordsView {
    
    func addKeyword() {
        guard !isEnteredTextEmpty else { return }
        node.keywordsModel.addKeyword(enteredText)
        enteredText = ""
    }
    
    func removeKeywords(at offsets: IndexSet) {
        for index in offsets {
            node.keywordsModel.removeKeyword(at: index)
        }
    }
    
    func toggleCaseSensitive() {
        node.keywordsModel.isCaseSensitive.toggle()
    }
}
