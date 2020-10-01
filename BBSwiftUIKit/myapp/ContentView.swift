//
//  ContentView.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//
import SwiftUI
import BBSwiftUIKit

struct ContentView: View {
    @State var list: [Int] = (1...50).map({return $0})
    @State var isRefreshing: Bool = false
    @State var isLoadingMore: Bool = false
    var body: some View {
        BBTableView(self.list) { item in
            Text("数据 \(item)")
                .padding(3)
        }
        .bb_setupRefreshControl({ (control) in
            control.tintColor = .gray
            control.attributedTitle = NSAttributedString(string: "加载中...", attributes: [.foregroundColor: UIColor.gray])
        })
        .bb_pullDownToRefresh(isRefreshing: self.$isRefreshing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("刷新")
                self.list = (1...50).map({return $0})
                self.isRefreshing = false
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            if self.isLoadingMore || self.list.count >= 100 {
                return
            }
            self.isLoadingMore = true
            print("上拉开始")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoadingMore = false
                let more = self.list.count..<self.list.count + 10
                self.list.append(contentsOf: more)
                print("上拉结束")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
