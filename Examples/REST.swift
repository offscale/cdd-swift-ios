struct TourFull : Decodable {
	let id: String?
	let updatedTs: Float?
	let specialization: String?
	let country: String?
	let city: String?
	let tags: String?
	let description: String?
	let transfer: String?
	let published: Bool?
	let createdTs: Float?
	let language: String?
	let name: String?
	let ownerUserId: Int?
}

struct Room_rename : Decodable {
	let room_id: String?
	let user_id: String?
	let room_name: String?
	let room_name_old: String?
}

struct Favorite : Decodable {
	let tourId: String?
	let id: String?
}

struct Schedule : Decodable {
	let ownerUserId: Int?
	let ts: Int?
	let tourId: String?
	let id: String?
}

struct Room_preview_full : Decodable {
	let last_message: String?
	let name: String?
	let room_id: String?
	let last_messages: String?
	let image: String?
	let type: String?
	let unread: Int?
}

struct Message : Decodable {
	let image: String?
	let room_id: String?
	let message_id: String?
	let user_id: String?
	let created_at: String?
	let status: String?
	let thumbnail: String?
	let message: String?
	let modified_at: String?
}

struct UserOnline : Decodable {
	let specialization: String?
	let id: String?
	let email: String?
	let phone: String?
	let city: String?
	let birthdate: String?
	let lastName: String?
	let status: String?
	let description: String?
	let logoPath: String?
	let firstName: String?
	let gender: String?
}

struct On_joined : Decodable {
	let username: String?
	let numUsers: Int?
}

struct Delete_message : Decodable {
	let room_id: String?
	let message_id: String?
	let user_id: String?
}

struct On_typing : Decodable {
	let room_id: String?
	let user_id: String?
}

struct Booking : Decodable {
	let ownerUserId: Int?
	let id: String?
	let GuideUserId: Int?
	let tourId: String?
	let scheduleId: String?
	let status: String?
	let createdTs: Int?
	let ts: Int?
}

struct Attachment : Decodable {
	let message: String?
	let thumbnail: String?
	let uuid: String?
	let type: String?
	let url: String?
}

struct Image : Decodable {
	let description: String?
	let name: String?
	let path: String?
}

struct Room_create : Decodable {
	let owner: String?
	let room_name: String?
	let users: String?
	let image: String?
	let request_id: String?
	let room_id: String?
}

struct Guide_places : Decodable {
	let description: String?
	let name: String?
	let address: String?
	let geoPosition: String?
}

struct Tour : Decodable {
	let ownerUserId: Int?
	let images: String?
	let published: Bool?
	let name: String?
	let createdTs: Float?
	let updatedTs: Float?
	let transfer: String?
	let tags: String?
	let city: String?
	let language: String?
	let description: String?
	let specialization: String?
	let country: String?
	let id: String?
}

struct Attach_room : Decodable {
	let owner: String?
	let room_id: String?
	let user_id: String?
}

struct UserAuth : Decodable {
	let email: String?
	let gender: String?
	let lastName: String?
	let token: String?
	let city: String?
	let phone: String?
	let logoPath: String?
	let birthdate: String?
	let specialization: String?
	let firstName: String?
	let description: String?
	let id: Int?
}

struct Guide : Decodable {
	let category: String?
	let country: String?
	let tags: String?
	let name: String?
	let published: Bool?
	let ownerUserId: Int?
	let updatedTs: Float?
	let description: String?
	let id: String?
	let city: String?
	let createdTs: Float?
}

struct Room_preview : Decodable {
	let room_name: String?
	let last_message: String?
	let unread: Int?
	let type: String?
	let users: [String]?
	let room_id: String?
	let last_messages: String?
}

struct User : Decodable {
	let email: String?
	let phone: String?
	let birthdate: String?
	let gender: String?
	let specialization: String?
	let logoPath: String?
	let description: String?
	let firstName: String?
	let lastName: String?
	let city: String?
	let id: Int?
}

struct Comment : Decodable {
	let guideId: String?
	let rating: Float?
	let message: String?
	let timestamp: String?
	let tourId: String?
	let id: String?
}

struct RecentStatus : Decodable {
	let last_join_timestamp: Int?
	let is_online: Bool?
	let seconds: Int?
	let last_time_string: String?
}

struct MessageHistoryList : Decodable {
	let hasMore: Bool?
}

struct SocketOn_joinPostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/on_join" }
	func method() -> HTTPMethod { return .post }
	let username: String
	let tokenauth: String
	let tokenapp: String
	let token: String
}

struct ApiV2GuideUpdatePostRequest : APIRequest {
	typealias ResponseType = Guide
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/update" }
	func method() -> HTTPMethod { return .post }
	let id: String
	let name: String?
	let description: String?
	let tags: String?
	let price: Float?
	let city: String?
	let country: String?
	let category: String?
	let places: String?
	let published: Bool?
}

struct SocketOn_messageGetRequest : APIRequest {
	typealias ResponseType = Message
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/on_message" }
	func method() -> HTTPMethod { return .get }
}

struct SocketOn_messagePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/on_message" }
	func method() -> HTTPMethod { return .post }
	let request_id: String
	let message_id: String?
	let room_id: String
	let room_id_list: String
	let message: String
	let user_id: String
	let user_id_list: String
	let type: String
	let thumbnail: String?
	let image: String?
	let attachments: String?
}

struct SocketMessage_statusPostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/message_status" }
	func method() -> HTTPMethod { return .post }
	let status: String
	let messages: String
}

struct ApiV2ProfilePostRequest : APIRequest {
	typealias ResponseType = User
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/profile" }
	func method() -> HTTPMethod { return .post }
	let id: String
	let firstName: String
	let lastName: String
	let email: String
	let logoPath: String?
	let description: String?
	let specialization: String?
	let gender: String?
	let city: String?
	let birthdate: String?
}

struct ApiV1RoomCreateRoom_idPutRequest : APIRequest {
	typealias ResponseType = Room_create
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/roomCreate/\(room_id)" }
	func method() -> HTTPMethod { return .put }
	let room_id: String
	let token: String
	let userId: Int?
	let room_name: String?
	let image: String?
	let is_attach: Bool?
	let type: String?
	let userList: String?
}

struct SocketOn_joinedGetRequest : APIRequest {
	typealias ResponseType = On_joined
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/on_joined" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2RoomCreateRoom_idPostRequest : APIRequest {
	typealias ResponseType = Room_create
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/roomCreate/\(room_id)" }
	func method() -> HTTPMethod { return .post }
	let room_id: String
	let token: String
	let userId: Int?
	let name: String?
	let image: String?
	let type: String?
	let userList: String?
}

struct ApiV1RoomRoom_idUndeliveredGetRequest : APIRequest {
	typealias ResponseType = [Message]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/room/\(room_id)/undelivered" }
	func method() -> HTTPMethod { return .get }
	let room_id: String
	let token: String
	let userId: Int?
}

struct ApiV2GuidePopularGetRequest : APIRequest {
	typealias ResponseType = [Guide]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/popular" }
	func method() -> HTTPMethod { return .get }
	let city: String
	let limit: Float
}

struct ApiV1UserGetOnlineGetRequest : APIRequest {
	typealias ResponseType = [String]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/user/getOnline" }
	func method() -> HTTPMethod { return .get }
	let userList: String
}

struct ApiV2LoginPostRequest : APIRequest {
	typealias ResponseType = UserAuth
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/login" }
	func method() -> HTTPMethod { return .post }
	let phone: String
	let code: String
}

struct ApiV2BookingListMyGetRequest : APIRequest {
	typealias ResponseType = [Booking]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/booking/list/my" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2BookingListGuideGetRequest : APIRequest {
	typealias ResponseType = [Booking]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/booking/list/guide" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV1AppUnregisterGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/app/unregister" }
	func method() -> HTTPMethod { return .get }
	let token: String
}

struct ApiV2ScheduleDeletePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/schedule/delete" }
	func method() -> HTTPMethod { return .post }
	let id: String?
}

struct ApiV1AppRegisterGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/app/register" }
	func method() -> HTTPMethod { return .get }
	let owner: String
	let platform: String
	let token: String
	let hwid: String
	let is_dev: String
}

struct ApiV2TourGetGetRequest : APIRequest {
	typealias ResponseType = TourFull
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/get" }
	func method() -> HTTPMethod { return .get }
	let tourId: String
}

struct ApiV2RoomRoom_idLeavePostRequest : APIRequest {
	typealias ResponseType = Room_create
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/room/\(room_id)/leave" }
	func method() -> HTTPMethod { return .post }
	let room_id: String
	let userId: Int?
	let token: String
}

struct ApiV2ScheduleListGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/schedule/list" }
	func method() -> HTTPMethod { return .get }
	let tourId: String?
	let start: Float?
	let end: Float?
}

struct ApiV2TourCreatePostRequest : APIRequest {
	typealias ResponseType = Tour
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/create" }
	func method() -> HTTPMethod { return .post }
	let name: String?
	let description: String?
	let tags: String?
	let price: Float?
	let duration: Float?
	let startHour: Float?
	let maxPeople: Int?
	let specialization: String?
	let language: String?
	let transfer: String?
	let city: String?
	let country: String?
	let published: Bool?
}

struct ApiV2TourDeletePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/delete" }
	func method() -> HTTPMethod { return .post }
	let id: String
}

struct ApiV2GuideCommentListGetRequest : APIRequest {
	typealias ResponseType = [Comment]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/comment/list" }
	func method() -> HTTPMethod { return .get }
	let guideId: String?
	let start: Float?
	let limit: Float?
}

struct ApiV1AppCheckGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/app/check" }
	func method() -> HTTPMethod { return .get }
	let users: String
}

struct ApiV2RoomsRoomIdBanGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/rooms/\(roomId)/ban" }
	func method() -> HTTPMethod { return .get }
	let token: String
	let userId: Int?
	let roomId: String
}

struct ApiV2RoomRoom_idNew_messagesGetRequest : APIRequest {
	typealias ResponseType = [Message]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/room/\(room_id)/new_messages" }
	func method() -> HTTPMethod { return .get }
	let room_id: String
	let token: String
	let userId: Int?
	let ts: Int?
	let limit: Int?
}

struct ApiV1UserUser_idRoomsFullGetRequest : APIRequest {
	typealias ResponseType = [Room_preview_full]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/user/\(user_id)/roomsFull" }
	func method() -> HTTPMethod { return .get }
	let user_id: String
}

struct ApiV2GuideImageAddPostRequest : APIRequest {
	typealias ResponseType = Image
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/image/add" }
	func method() -> HTTPMethod { return .post }
	let guideId: String?
	let name: String?
	let description: String?
	let path: String?
}

struct SocketAttach_roomGetRequest : APIRequest {
	typealias ResponseType = Attach_room
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/attach_room" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2TourImageAddPostRequest : APIRequest {
	typealias ResponseType = Image
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/image/add" }
	func method() -> HTTPMethod { return .post }
	let tourId: String?
	let name: String?
	let description: String?
	let path: String?
}

struct ApiV2TourCommentPostRequest : APIRequest {
	typealias ResponseType = Comment
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/comment" }
	func method() -> HTTPMethod { return .post }
	let message: String?
	let rating: String?
	let tourId: String?
}

struct ApiV2TourCommentListGetRequest : APIRequest {
	typealias ResponseType = [Comment]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/comment/list" }
	func method() -> HTTPMethod { return .get }
	let tourId: String?
}

struct SocketAdd_userGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/add_user" }
	func method() -> HTTPMethod { return .get }
}

struct SocketRoomsGetRequest : APIRequest {
	typealias ResponseType = [Room_preview]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/rooms" }
	func method() -> HTTPMethod { return .get }
}

struct SocketStop_typingGetRequest : APIRequest {
	typealias ResponseType = On_typing
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/stop_typing" }
	func method() -> HTTPMethod { return .get }
}

struct SocketStop_typingPostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/stop_typing" }
	func method() -> HTTPMethod { return .post }
	let room_id: String
}

struct ApiV2UserUser_idAddressbookPostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/user/\(user_id)/addressbook" }
	func method() -> HTTPMethod { return .post }
	let user_id: String
}

struct ApiV2GuidePointAddPostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/point/add" }
	func method() -> HTTPMethod { return .post }
	let guideId: String?
	let name: String?
	let description: String?
	let address: String?
	let geoPosition: String?
}

struct ApiV2RoomsRoomIdUnbanGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/rooms/\(roomId)/unban" }
	func method() -> HTTPMethod { return .get }
	let token: String
	let userId: Int?
	let roomId: String
}

struct ApiV2RoomRoom_idImagesGetRequest : APIRequest {
	typealias ResponseType = [Message]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/room/\(room_id)/images" }
	func method() -> HTTPMethod { return .get }
	let room_id: String
	let token: String
	let userId: Int?
}

struct SocketDeattach_roomGetRequest : APIRequest {
	typealias ResponseType = Attach_room
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/deattach_room" }
	func method() -> HTTPMethod { return .get }
}

struct SocketOn_typingGetRequest : APIRequest {
	typealias ResponseType = On_typing
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/on_typing" }
	func method() -> HTTPMethod { return .get }
}

struct SocketOn_typingPostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/on_typing" }
	func method() -> HTTPMethod { return .post }
	let room_id: String
}

struct ApiV2GuideListGetRequest : APIRequest {
	typealias ResponseType = [Guide]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/list" }
	func method() -> HTTPMethod { return .get }
	let guideId: String?
}

struct ApiV1RoomRoom_idDeleteRequest : APIRequest {
	typealias ResponseType = Room_rename
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/room/\(room_id)" }
	func method() -> HTTPMethod { return .delete }
	let room_id: String
	let token: String
	let userId: Int?
}

struct ApiV2RegisterPostRequest : APIRequest {
	typealias ResponseType = User
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/register" }
	func method() -> HTTPMethod { return .post }
	let phone: String
}

struct ApiInternalPushSendPostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/internal/push/send" }
	func method() -> HTTPMethod { return .post }
	let phones: String?
	let users: String?
	let message: String
}

struct ApiV2RoomsBanGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/rooms/ban" }
	func method() -> HTTPMethod { return .get }
	let token: String
	let userId: Int?
}

struct ApiV2GuideSearchGetRequest : APIRequest {
	typealias ResponseType = [Guide]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/search" }
	func method() -> HTTPMethod { return .get }
	let pattern: String?
	let city: String?
	let category: String?
}

struct ApiV2GuideCreatePostRequest : APIRequest {
	typealias ResponseType = Guide
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/create" }
	func method() -> HTTPMethod { return .post }
	let name: String?
	let description: String?
	let tags: String?
	let price: Float?
	let city: String?
	let country: String?
	let category: String?
	let places: String?
	let published: Bool?
}

struct SocketDelete_messagePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/delete_message" }
	func method() -> HTTPMethod { return .post }
	let message_id: String
	let message_id_list: String
	let all: Bool?
}

struct SocketDelete_messageGetRequest : APIRequest {
	typealias ResponseType = Delete_message
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/delete_message" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2UserListGetRequest : APIRequest {
	typealias ResponseType = [UserOnline]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/userList" }
	func method() -> HTTPMethod { return .get }
	let userList: String
}

struct ApiV1UserGetLastOnlineGetRequest : APIRequest {
	typealias ResponseType = RecentStatus
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/user/getLastOnline" }
	func method() -> HTTPMethod { return .get }
	let userId: String
}

struct ApiV2MessageListGetRequest : APIRequest {
	typealias ResponseType = MessageHistoryList
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/message/list" }
	func method() -> HTTPMethod { return .get }
	let token: String
	let userId: Int?
	let limit: Int?
	let date: Int?
}

struct ApiV2FavoritetourListGetRequest : APIRequest {
	typealias ResponseType = [Favorite]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/favoritetour/list" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2UserUser_idGetRequest : APIRequest {
	typealias ResponseType = User
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/user/\(user_id)" }
	func method() -> HTTPMethod { return .get }
	let user_id: String
}

struct ApiV2FavoritetourCreatePostRequest : APIRequest {
	typealias ResponseType = Favorite
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/favoritetour/create" }
	func method() -> HTTPMethod { return .post }
	let tourId: String?
}

struct ApiV2RoomRoom_idPostRequest : APIRequest {
	typealias ResponseType = Room_create
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/room/\(room_id)" }
	func method() -> HTTPMethod { return .post }
	let room_id: String
	let name: String?
	let userList: String?
	let image: String?
}

struct ApiV2GuideGetGetRequest : APIRequest {
	typealias ResponseType = Guide
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/get" }
	func method() -> HTTPMethod { return .get }
	let guideId: String?
}

struct V2MessageSendPostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/v2/message/send" }
	func method() -> HTTPMethod { return .post }
	let request_id: String
	let message_id: String?
	let room_id: String
	let room_id_list: String
	let message: String
	let user_id: String
	let user_id_list: String
	let type: String
	let thumbnail: String?
	let image: String?
	let attachments: String?
}

struct ApiV2RoomRoom_idMessagesGetRequest : APIRequest {
	typealias ResponseType = MessageHistoryList
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/room/\(room_id)/messages" }
	func method() -> HTTPMethod { return .get }
	let room_id: String
	let token: String
	let userId: Int?
	let limit: Int?
	let date: Int?
}

struct ApiV1RoomRoom_idMessagesGetRequest : APIRequest {
	typealias ResponseType = [Message]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/room/\(room_id)/messages" }
	func method() -> HTTPMethod { return .get }
	let room_id: String
	let token: String
	let userId: Int?
	let limit: Int?
	let offset: Int?
	let status: String
	let page: Int?
	let date_start: Int?
	let date_end: Int?
}

struct ApiV2GuideImageDeletePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/image/delete" }
	func method() -> HTTPMethod { return .post }
	let guideId: String?
	let name: String?
}

struct SocketMessage_sentGetRequest : APIRequest {
	typealias ResponseType = Message
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/message_sent" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2ScheduleCreatePostRequest : APIRequest {
	typealias ResponseType = Schedule
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/schedule/create" }
	func method() -> HTTPMethod { return .post }
	let tourId: String?
	let timestamp: Float?
}

struct ApiV1RoomRoom_idResetGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/room/\(room_id)/reset" }
	func method() -> HTTPMethod { return .get }
	let room_id: String
}

struct ApiV1UserUser_idRoomsFullCacheGetRequest : APIRequest {
	typealias ResponseType = [Room_preview_full]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/user/\(user_id)/roomsFullCache" }
	func method() -> HTTPMethod { return .get }
	let user_id: String
}

struct ApiV2TourUpdatePostRequest : APIRequest {
	typealias ResponseType = Tour
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/update" }
	func method() -> HTTPMethod { return .post }
	let id: String?
	let name: String?
	let description: String?
	let tags: String?
	let price: Float?
	let duration: Float?
	let startHour: Float?
	let maxPeople: Int?
	let specialization: String?
	let language: String?
	let transfer: String?
	let city: String?
	let country: String?
	let published: Bool?
}

struct ApiV2TourImageDeletePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/image/delete" }
	func method() -> HTTPMethod { return .post }
	let tourId: String?
	let name: String?
}

struct ApiV1UserUser_idRoomsRoom_idDeleteGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/user/\(user_id)/rooms/\(room_id)/delete" }
	func method() -> HTTPMethod { return .get }
	let user_id: String
	let room_id: String
}

struct ApiV2ScheduleUpdatePostRequest : APIRequest {
	typealias ResponseType = Schedule
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/schedule/update" }
	func method() -> HTTPMethod { return .post }
	let id: String?
	let tourId: String?
	let timestamp: Float?
}

struct ApiV2TourPopularGetRequest : APIRequest {
	typealias ResponseType = [Tour]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/popular" }
	func method() -> HTTPMethod { return .get }
	let city: String
	let limit: Float
}

struct ApiV2TourListGetRequest : APIRequest {
	typealias ResponseType = [Tour]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/list" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2BookingCreatePostRequest : APIRequest {
	typealias ResponseType = Booking
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/booking/create" }
	func method() -> HTTPMethod { return .post }
	let tourId: String?
	let scheduleId: String?
}

struct ApiV2ScheduleRangePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/schedule/range" }
	func method() -> HTTPMethod { return .post }
	let tourId: String?
	let start: Float?
	let end: Float?
	let timeOfTheDay: Float?
	let daysOfTheWeek: String?
}

struct SocketRemove_userGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/remove_user" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2RoomRoom_idMessageStatusPostRequest : APIRequest {
	typealias ResponseType = Message
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/room/\(room_id)/messageStatus" }
	func method() -> HTTPMethod { return .post }
	let room_id: String
	let status: String
	let timestamp: Int
}

struct ApiV2TourSearchGetRequest : APIRequest {
	typealias ResponseType = [Tour]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/search" }
	func method() -> HTTPMethod { return .get }
	let pattern: String
	let city: String
	let isGroup: Bool
	let startDate: Float
	let endDate: Float
}

struct SocketMessage_changeGetRequest : APIRequest {
	typealias ResponseType = Message
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/message_change" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2FavoritetourDeletePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/favoritetour/delete" }
	func method() -> HTTPMethod { return .post }
	let tourId: String?
}

struct ApiV2ScheduleListMyGetRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/schedule/list/my" }
	func method() -> HTTPMethod { return .get }
	let start: Float?
	let end: Float?
}

struct SocketOn_message_updatePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/socket/on_message_update" }
	func method() -> HTTPMethod { return .post }
	let request_id: String
	let message: String
	let thumbnail: String?
	let image: String?
	let attachments: String?
}

struct ApiV1UserUser_idRoomsCacheGetRequest : APIRequest {
	typealias ResponseType = [Room_preview]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/user/\(user_id)/roomsCache" }
	func method() -> HTTPMethod { return .get }
	let user_id: String
}

struct ApiV2GuideCommentPostRequest : APIRequest {
	typealias ResponseType = Comment
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/comment" }
	func method() -> HTTPMethod { return .post }
	let message: String?
	let rating: String?
	let guideId: String?
}

struct ApiV2TourListRateGetRequest : APIRequest {
	typealias ResponseType = [Tour]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/tour/list/rate" }
	func method() -> HTTPMethod { return .get }
}

struct ApiV2GuidePointDeletePostRequest : APIRequest {
	typealias ResponseType = EmptyResponse
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v2/guide/point/delete" }
	func method() -> HTTPMethod { return .post }
	let guideId: String?
	let name: String?
}

struct ApiV1UserUser_idRoomsGetRequest : APIRequest {
	typealias ResponseType = [Room_preview]
	typealias ErrorType = EmptyResponse 
	func urlPath() -> String { return "/api/v1/user/\(user_id)/rooms" }
	func method() -> HTTPMethod { return .get }
	let user_id: String
}
