//
//  DSGroupedList.swift
//  DSKitExplorer
//
//  Created by Ivan Borinschi on 13.03.2023.
//

import SwiftUI

/*
## DSGroupedList

`DSGroupedList` is a SwiftUI component designed to display a collection of data in a grouped list format within the DSKit framework. It organizes elements in a vertical stack with dividers between items, suitable for settings where data needs to be sectioned clearly, such as in menus, forms, or any list-based interface.

#### Initialization:
Initializes a `DSGroupedList` with essential parameters for handling data and custom content rendering.
- Parameters:
- `data`: The collection of data items.
- `id`: KeyPath to the unique identifier for each data item.
- `content`: Closure returning a `Content` view for each item in the data collection.
 
#### Usage:
`DSGroupedList` is particularly effective in environments where distinct visual separation of items is beneficial, enhancing both the organization and aesthetics of list presentations.
*/

public struct DSGroupedList<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View, Data.Index == Int {

    private struct GroupedItem: Identifiable {
        let id: ID
        let index: Int
        let element: Data.Element
    }

    let data: Data
    let content: (Data.Element) -> Content
    let id: KeyPath<Data.Element, ID>

    public init(
        data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self.content = content
    }

    public var body: some View {
        DSVStack {
            let items = data.enumerated().map {
                GroupedItem(id: $0.element[keyPath: id], index: $0.offset, element: $0.element)
            }
            let lastIndex = max(0, items.count - 1)

            ForEach(items) { item in
                let index = item.index
                let element = item.element
                self.content(element)
                if index < lastIndex {
                    DSDivider()
                }
            }
        }.dsCardStyle()
    }
}

struct Testable_DSGroupedList: View {

    let artists = [
        "Eminem",
        "Madona",
        "Michael Jakson"
    ]

    var body: some View {
        DSGroupedList(data: artists, id: \.self) { artist in
            DSText(artist)
        }
    }
}

struct DSGroupedList_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSGroupedList()
            }
        }
    }
}
