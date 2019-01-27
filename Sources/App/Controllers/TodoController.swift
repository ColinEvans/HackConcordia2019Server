import Vapor
import FluentPostgreSQL

/// Controls basic CRUD operations on `Todo`s.
final class TodoController {
    /// Returns a list of all `Todo`s.
    func plays(_ req: Request) throws -> Future<[SongRecord]> {
        guard let flags = try? req.query.decode(Flags.self) else { throw Abort(.notFound, reason: "Invalid Parameters") }
        var stateClause = ""
        if let state = flags.state {
            stateClause = "AND state = '\(state)'"
        }

        return req.withPooledConnection(to: .psql) { (conn: PostgreSQLDatabase.Connection) in
            return conn.raw(
                """
                SELECT COUNT(*) as count, "songId", MAX("artistId") as "artistId", MAX("state") as "state", MAX("style") as "style" FROM plays
                WHERE "playDate" >= '\(flags.startDate)'
                AND "playDate" <= '\(flags.endDate)'
                \(stateClause)
                GROUP BY "songId"
                ORDER BY count DESC
                LIMIT 3
                """
            ).all(decoding: SongRecord.self)
        }
    }

    func artists(_ req: Request) throws -> Future<[ArtistRecord]> {
        guard let flags = try? req.query.decode(Flags.self) else { throw Abort(.notFound, reason: "Invalid Parameters") }
        var stateClause = ""
        if let state = flags.state {
            stateClause = "AND state = '\(state)'"
        }
        return req.withPooledConnection(to: .psql) { (conn: PostgreSQLDatabase.Connection) in
            return conn.raw(
                """
                SELECT COUNT(*) as count, "artistId" FROM plays
                WHERE "playDate" >= '\(flags.startDate)'
                AND "playDate" <= '\(flags.endDate)'
                \(stateClause)
                GROUP BY "artistId"
                ORDER BY count DESC
                LIMIT 3
                """
                ).all(decoding: ArtistRecord.self)
        }
    }

    func styles(_ req: Request) throws -> Future<[GenreRecord]> {
        guard let flags = try? req.query.decode(Flags.self) else { throw Abort(.notFound, reason: "Invalid Parameters") }
        var stateClause = ""
        if let state = flags.state {
            stateClause = "AND state = '\(state)'"
        }
        return req.withPooledConnection(to: .psql) { (conn: PostgreSQLDatabase.Connection) in
            return conn.raw(
                """
                SELECT COUNT(*) as count, "style" FROM plays
                WHERE "playDate" >= '\(flags.startDate)'
                AND "playDate" <= '\(flags.endDate)'
                \(stateClause)
                GROUP BY "style"
                ORDER BY count DESC
                LIMIT 3
                """
                ).all(decoding: GenreRecord.self)
        }
    }
//
//    /// Saves a decoded `Todo` to the database.
//    func create(_ req: Request) throws -> Future<plays> {
//        return try req.content.decode(plays.self).flatMap { todo in
//            return todo.save(on: req)
//        }
//    }
//
//    /// Deletes a parameterized `Todo`.
//    func delete(_ req: Request) throws -> Future<HTTPStatus> {
//        return try req.parameters.next(plays.self).flatMap { todo in
//            return todo.delete(on: req)
//        }.transform(to: .ok)
//    }
}
