//
//  NotAuthorizedAccountView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct NotAuthorizedAccountView: View {
    var body: some View {
        Text("Please authorise with Google in account tab.")
            .bold()
            .font(.system(size: 25))
            .multilineTextAlignment(.center)
    }
}

struct NotAuthorizedAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NotAuthorizedAccountView()
    }
}
