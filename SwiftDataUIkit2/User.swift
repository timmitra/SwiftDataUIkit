//
// ---------------------------- //
// Original Project: SwiftDataUIkit
// Created on 2024-12-08 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.



import SwiftData

@Model
class User {
    var name: String
    var birthYear: Int

    init(name: String, birthYear: Int) {
        self.name = name
        self.birthYear = birthYear
    }
}