module.exports = {
  _id: "share-id-1", // ObjectID
  content: "Nice whether, right?", // string
  createdBy: {
    _id: "user-id-1", // ObjectID
    username: "Bosson" // string
  },
  createdAt: "2014-8-21", // Date
  attachmentUrl: "/attachment/123456", // string
  tags: ["心情"], // string
  likes: ["user-id-1", "user-id-2"] // ObjectID
};
