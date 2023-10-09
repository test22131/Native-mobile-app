//
//  PhoneContent3.swift
//  Native3
//
//  Created by William Berggren on 2023-04-27.
//

import SwiftUI
import CallKit

class CallStatus: ObservableObject {
    @Published var isInCall = false
    let callObserver: CXCallObserver
    var callObserverDelegate: CallObserver?

    init() {
        self.callObserver = CXCallObserver()
        self.callObserverDelegate = CallObserver(callStatus: self)
        self.callObserver.setDelegate(self.callObserverDelegate, queue: nil)
        
        if callObserver.calls.count > 0 {
            self.isInCall = true
        }
    }
}



class CallObserver: NSObject, CXCallObserverDelegate {
    weak var callStatus: CallStatus?

    init(callStatus: CallStatus?) {
        self.callStatus = callStatus
    }

    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.hasEnded == true {
            print("Call has ended")
            callStatus?.isInCall = false
        }

        if call.isOutgoing == true && call.hasConnected == false {
            print("Dialing")
        }

        if call.isOutgoing == false && call.hasConnected == false && call.hasEnded == false {
            print("Incoming")
        }

        if call.isOutgoing == false && call.hasConnected == true && call.hasEnded == false {
            print("In call")
            callStatus?.isInCall = true
        }
    }
}

struct PhoneInCall: View {
    @EnvironmentObject var callStatus: CallStatus

    @State private var selectedTab = 0

    var body: some View {
        GeometryReader { geometry in
            VStack { 
                Spacer()
                HStack {
                    Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: "phone.arrow.up.right")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)

                        Text(callStatus.isInCall ? "The device is in call" : "The device is not in call")
                            .font(.system(size: 24, weight: .semibold, design: .default))
                            .foregroundColor(.gray)
                            
                    }
                    Spacer()
                }
                Spacer()
            }
            .onAppear {
                if callStatus.callObserver.calls.count > 0 {
                    callStatus.isInCall = true
                }
            }
            .onChange(of: callStatus.isInCall) { newIsInCall in
                if newIsInCall == true {
                    selectedTab = 6
                }
            }
        }
    }
}




