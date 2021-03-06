#if INCLUDE_REALM

    import RealmSwift

    public class DbJsonEntry: Object {
        @objc dynamic var key = ""
        @objc dynamic var value = ""
    }

    public class DbJson {
        public static let instance = DbJson()
        private let realm: Realm?

        private init() {
            do {
                realm = try Realm()
            } catch {
                GLog.e("Failed initializing Realm", error: error)
                realm = nil
            }
        }

        private func row(key: String) -> DbJsonEntry? {
            return realm?.objects(DbJsonEntry.self).filter("key = %@", key).first
        }

        public func set(_ object: Json, forKey key: String) {
            if let str = object.rawString(), let database = realm {
                do {
                    try database.write {
                        if let row = row(key: key) {
                            row.value = str
                        } else {
                            let row = DbJsonEntry()
                            row.key = key
                            row.value = str
                            database.add(row)
                        }
                    }
                } catch {
                    GLog.e("Failed writing to Realm", error: error)
                }
            }
        }

        public func object(forKey key: String) -> Json {
            if let row = row(key: key) {
                let json = Json(parseJSON: row.value)

                do {
                    _ = try json.rawData()
                    return json
                } catch { // E.g. a JSON that is just a standalone string value
                    return Json(row.value)
                }
            }
            return Json(NSNull())
        }

        public func removeObject(forKey key: String) {
            do {
                if let database = realm {
                    try database.write {
                        if let row = row(key: key) {
                            database.delete(row)
                        }
                    }
                }
            } catch {
                GLog.e("Failed removing from Realm", error: error)
            }
        }
    }

#endif
