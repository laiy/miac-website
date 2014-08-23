var album = {
  _id: "album-id-1", // ObjectID
  title: "春季出游", // ObjectID
  createdAt: "2014-2-20", // Date
  createdBy: {
    _id: "user-id-1", // ObjectID
    username: "TianQing" // string
  },
  pictures: ["/pictures/1", "/pictures/2"] // string
};

exports.album = album;
