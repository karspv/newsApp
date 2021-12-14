//
//  SourceView.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import SwiftUI

struct SourceView: View {
    
    var source: SourceEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(source.title)
                .bold()
                .font(.system(size: 25))
                .foregroundColor(.black)
                .lineLimit(1)
            
            Text(source.description)
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .lineLimit(.none)
        }.padding(.all, 20)
    }
}

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView(source: .default)
            .previewLayout(.sizeThatFits)
    }
}
