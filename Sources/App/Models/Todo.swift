import FluentPostgreSQL
import Vapor

/// A single entry of a Todo list.
final class plays: PostgreSQLModel {
    
    /// The unique identifier for this `plays` table.
    var id: Int?

    /// The id of the Song
    var songId: Int

    // The id of the Artist
    var artistId: Int

    /// The State or Provience the song was played in
    var state: String
    
    /// The song's genere
    var style: String
    
    /// A latitude of where the song was played
    var latitude: Float

    /// The longitude of where the song was played
    var longitude: Float

    /// The time the song was played
    var playDate: String

    /// Creates a new `Todo`.
    init(id: Int? = nil, songId: Int, artistId: Int, latitude: Float, longitude: Float, playDate: String, style: String, state: String) {
        self.id = id
        self.songId = songId
        self.artistId = artistId
        self.state = state
        self.style = style
        self.latitude = latitude
        self.longitude = longitude
        self.playDate = playDate
    }
}

/// Allows `Todo` to be used as a dynamic migration.
extension plays: Migration { }

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension plays: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension plays: Parameter { }
