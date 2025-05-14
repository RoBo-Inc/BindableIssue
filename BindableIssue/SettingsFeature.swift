import ComposableArchitecture
import SwiftUI

@Reducer
struct Settings {
    @ObservableState
    struct State: Equatable {
        var something: Something
        // ...
        
        struct Something: Equatable {
            var flag = false
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer().onChange(of: \.something.flag) { oldValue, newValue in
            Reduce { state, action in
                print("Changed from \(oldValue) to \(newValue)")
                return .none
            }
        }
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
        Toggle("Flag", isOn: $store.something.flag)
            .padding()
    }
}

#Preview {
    SettingsView(
        store: .init(initialState: .init(something: .init(flag: true))) {
            Settings()
        }
    )
}
