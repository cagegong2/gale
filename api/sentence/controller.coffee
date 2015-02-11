express = require("express")
router = express.Router()

Sentence = _u.getModel 'sentence'
WrapRequest = new (require '../../utils/WrapRequest')(Sentence)

router.get "/", (req, res, next) ->
  conditions = {}
  conditions.lessonNo = req.query.lessonNo if req.query.lessonNo
  findParams =
    conditions: conditions
    options: {sort: {lessonNo: 1, sentenceNo: 1}}

  WrapRequest.wrapIndex req, res, next, findParams

module.exports = router
