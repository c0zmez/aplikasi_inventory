const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, "./uploads");
    },
    filename: function(req, file, cb) {
        cb(null, Date.now() + "-" + file.originalname);
    }
});

const fileFilter = (req, file, callback) => {
    const validExts = [".png", ".jpg", ".jpeg"];

    if (!validExts.includes(path.extname(file.originalname))) {
        return callback(new Error("Hanya bisa format .png, .jpg, & .jpeg"));
    }

    const fileSize = parseInt(req.header["context-length"]);
    if(fileSize > 1048576) {
        return callback(new Error("Ukuran file terlalu besar"));
    }

    callback(null, true);
};

let upload = multer({
    storage: storage,
    fileFilter: fileFilter,
    fileSize: 1048576, //10Mb
});

module.exports = upload.single("productImage")


