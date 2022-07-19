
/// A Twitch `USERSTATE` message.
public struct UserState: MessageWithBadges {
    
    /// Channel's name with no uppercased/Han characters.
    public var channel = String()
    /// User's badge info.
    public var badgeInfo = [String]()
    /// User's badges.
    public var badges = [String]()
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with uppercased/Han characters.
    public var displayName = String()
    /// User's emote sets.
    public var emoteSets = [String]()
    /// The ID of this user state message.
    public var id = String()
    /// Contains info about unused info and parsing problems.
    public var parsingLeftOvers = ParsingLeftOvers()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#", contentLhs.count > 2 else {
            return nil
        }
        self.channel = String(contentRhs.dropFirst())
        
        var parser = ParametersParser(String(contentLhs.dropLast(2).dropFirst()))
        
        self.badgeInfo = parser.array(for: "badge-info")
        self.badges = parser.array(for: "badges")
        self.color = parser.string(for: "color")
        self.displayName = parser.string(for: "display-name")
        self.emoteSets = parser.array(for: "emote-sets")
        self.id = parser.string(for: "id")
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        let sometimesUnavailableKeys = ["id"]
        self.parsingLeftOvers = parser.getLeftOvers(
            excludedUnusedKeys: deprecatedKeys + sometimesUnavailableKeys
        )
    }
}

// MARK: - Sendable conformance
#if swift(>=5.5)
extension UserState: Sendable { }
#endif
