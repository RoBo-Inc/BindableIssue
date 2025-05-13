import ComposableArchitecture
import SwiftUI

@Reducer
struct Settings {
    @ObservableState
    struct State: Equatable {
        var something: Something
        // ...
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.something.flag):
                print("A")
                return .none
            case .binding(\.something):
                print("B")
                return .none
            default:
                return .none
            }
        }
    }
}

struct SettingsView: View {
    @Bindable var store: StoreOf<Settings>
    
    public init(store: StoreOf<Settings>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
            
            Toggle("Flag", isOn: $store.something.flag)
        }
        .padding()
    }
}

struct Something: Equatable {
    var flag = false
}

#Preview {
    SettingsView(
        store: .init(initialState: .init(something: .init(flag: true))) {
            Settings()
        }
    )
}
