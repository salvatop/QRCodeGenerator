import SwiftUI

struct ContentView: View {
    let pippo = QRCodeDatasetMaker()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(pippo.dataset?.version["4"]?.values.first?.numeric ?? -1)" )
        }
        .padding()
    }
}
