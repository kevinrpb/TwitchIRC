@testable import TwitchIRC
import XCTest

final class NoticeTests: XCTestCase {
    
    /// Test `MessageID.init(rawValue:)` is dash-independent.
    func testMessageIDInitDashIndependent() throws {
        let first = try XCTUnwrap(Notice.MessageID(rawValue: "followers_onzero"))
        let second = try XCTUnwrap(Notice.MessageID(rawValue: "followers_on_zero"))
        let third = try XCTUnwrap(Notice.MessageID(rawValue: "followersonzero"))
        
        XCTAssertEqual(.followersOnZero, first)
        XCTAssertEqual(first, second)
        XCTAssertEqual(second, third)
    }
    
    func testParsedValues1() throws {
        let string = "@msg-id=slow_off :tmi.twitch.tv NOTICE #dallas :This room is no longer in slow mode."
        
        let notice: Notice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(notice.message, "This room is no longer in slow mode.")
        XCTAssertEqual(notice.channel, "dallas")
        let messageId = try XCTUnwrap(notice.messageId)
        XCTAssertEqual(messageId, .slowOff)
    }
    
    func testParsedValues2() throws {
        let string = "@msg-id=followers_on_zero :tmi.twitch.tv NOTICE #simonpetrik :This room is now in followers-only mode."
        
        let notice: Notice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(notice.message, "This room is now in followers-only mode.")
        XCTAssertEqual(notice.channel, "simonpetrik")
        let messageId = try XCTUnwrap(notice.messageId)
        XCTAssertEqual(messageId, .followersOnZero)
    }
}
