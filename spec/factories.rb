Factory.define :message do |message|
  message.pickUpCode        "12345"
  message.contents          "p7xcl2w5ndkhxvscp6iiy0idtvskfe6ph9fzx4nbdgfzwzwhb20wbz2o0vpxn6wfp6f2n3o8vk7hqcge09zu9c0mz86jg2qu1d2cj0a4hgpu8uoc96rxbusmugf5x50hwfgod5ldpa5i8sb91pbfykfsfqd69pvrkhnjsl9yyhizwftnzcetkf9w3yhmdqbwj0cos5m542cq5h20tu1imhlnlpc393xphi4irihmw7ny2opriib91gzo3l8kgb3di8kcszchx3726zx1awtoj84c72wuakq6v63u8u6mg6ly3979vsfhkmpwbr7z3x0imhlxjjiyu7k2xeypv3539f3h20obv2m5dg5mkayxitmrlqfogfc7gtjglfqgp87pqznbnoh55u3llmof7agiszx7y4ytemu0e3oj9mixgdwp9slewmg2bwwtszcganne1vqf1comh3fw36z5t5ni869wdbmfc0kge7ysfftfn9bo4wm8lkuq"
  message.password          "12345"
end

Factory.define :user do |user|
  user.name                   "Scott Moschella"
  user.email                  "scottmosch@gmail.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end