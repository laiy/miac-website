var message = {
  _id: "message-id-1", // ObjectID
  replyTo: "discuss-id-1", // "discuss-id-1" or "message-id-2", "article-id-1" ObjectID
  type: "comment", // comment or reply , announcement string
  content: "I think you are right..", // string
  createdBy: {
    _id: "user-id-1", // ObjectID
    username: "bossonchan" // string
  },
  createdAt: "2014-8-21" // Date
};
