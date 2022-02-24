
/// A Twitch message indicating usage of an unknown command.
public struct UnknownCommand: Sendable {
    
    /// The lowercased Twitch account username that sent the message.
    public var username = String()
    /// The command that was unknown.
    public var command = String()
    /// The Twitch message sent as an explanation.
    public var message = String()
    
    public init() { }
    
    init? (contentRhs: String) {
        guard let (username, theRest) = contentRhs.componentsOneSplit(separatedBy: " "),
              let (command, message) = theRest.componentsOneSplit(separatedBy: " :")
        else { return nil }
        
        self.username = username
        self.command = command
        self.message = message
    }
}
